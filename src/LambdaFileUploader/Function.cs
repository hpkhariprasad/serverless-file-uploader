using Amazon.Lambda.Core;
using Amazon.S3;
using Amazon.S3.Transfer;
using System.IO;
using System.Threading.Tasks;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace LambdaFileUploader
{
    public class Function
    {
        protected readonly IAmazonS3 _s3Client;
        private readonly string _bucketName;

        public Function() : this(new AmazonS3Client()) { }

        public Function(IAmazonS3 s3Client)
        {
            _s3Client = s3Client;
            _bucketName = Environment.GetEnvironmentVariable("BUCKET_NAME");

            if (string.IsNullOrEmpty(_bucketName))
                throw new InvalidOperationException("Environment variable BUCKET_NAME is not set.");
        }

        public virtual async Task<string> FunctionHandler(Stream input, ILambdaContext context)
        {
            var fileName = $"upload-{System.Guid.NewGuid()}.txt";
            var uploadRequest = new TransferUtilityUploadRequest
            {
                InputStream = input,
                Key = fileName,
                BucketName = _bucketName
            };

            var transferUtility = new TransferUtility(_s3Client);
            await transferUtility.UploadAsync(uploadRequest);

            return $"File uploaded successfully: {fileName}";
        }
    }

}

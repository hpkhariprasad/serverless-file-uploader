using System.IO;
using System.Threading;
using System.Threading.Tasks;
using Amazon.S3;
using Amazon.S3.Transfer;
using Amazon.Lambda.Core;
using LambdaFileUploader;
using Moq;
using Xunit;

public class FunctionTests
{
    [Fact]
    public async Task FunctionHandler_UploadsFile_ReturnsSuccessMessage()
    {
        // Arrange
        var s3ClientMock = new Mock<IAmazonS3>();
        var transferUtilityMock = new Mock<TransferUtility>(s3ClientMock.Object);

        transferUtilityMock
            .Setup(tu => tu.UploadAsync(
                It.IsAny<TransferUtilityUploadRequest>(),
                It.IsAny<CancellationToken>()))
            .Returns(Task.CompletedTask);

        var function = new FunctionTestable(s3ClientMock.Object, transferUtilityMock.Object);

        var testStream = new MemoryStream(new byte[] { 1, 2, 3 });
        var contextMock = new Mock<ILambdaContext>();

        // Act
        var result = await function.FunctionHandler(testStream, contextMock.Object);

        // Assert
        Assert.StartsWith("File uploaded successfully: upload-", result);
        Assert.EndsWith(".txt", result.Substring(result.LastIndexOf(':') + 2));
    }
}

// Helper class to inject mocks
public class FunctionTestable : Function
{
    private readonly TransferUtility _transferUtility;

    public FunctionTestable(IAmazonS3 s3Client, TransferUtility transferUtility)
        : base(s3Client)
    {
        _transferUtility = transferUtility;
    }

    public override async Task<string> FunctionHandler(Stream input, ILambdaContext context)
    {
        var fileName = $"upload-{System.Guid.NewGuid()}.txt";
        var uploadRequest = new TransferUtilityUploadRequest
        {
            InputStream = input,
            Key = fileName,
            BucketName = "serverless-file-uploader-yourname"
        };

        await _transferUtility.UploadAsync(uploadRequest);

        return $"File uploaded successfully: {fileName}";
    }
}

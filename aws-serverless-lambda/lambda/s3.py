const AWS = require('aws-sdk');
const s3 = new AWS.S3();

exports.handler = async (event) => {
    try {
        // Retrieve and return static content from S3
        const params = {
            Bucket: 'your-s3-bucket',
            Key: event.pathParameters.filename,
        };
        const data = await s3.getObject(params).promise();

        const response = {
            statusCode: 200,
            body: data.Body.toString('utf-8'),
        };
        return response;
    } catch (error) {
        console.error('Error:', error);
        return {
            statusCode: 500,
            body: JSON.stringify({ error: 'Internal Server Error' }),
        };
    }
};

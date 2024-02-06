const jwt = require('jsonwebtoken');

exports.handler = async (event) => {
    const token = event.authorizationToken.replace('Bearer ', '');

    try {
        const decoded = jwt.verify(token, 'your-secret-key');

        // Perform custom authorization logic based on decoded information
        if (decoded && decoded.userRole === 'admin') {
            return generatePolicy('user', 'Allow', event.methodArn);
        } else {
            return generatePolicy('user', 'Deny', event.methodArn);
        }
    } catch (error) {
        return generatePolicy('user', 'Deny', event.methodArn);
    }
};

const generatePolicy = (principalId, effect, resource) => {
    const policyDocument = {
        Version: '2012-10-17',
        Statement: [{
            Action: 'execute-api:Invoke',
            Effect: effect,
            Resource: resource,
        }],
    };

    return {
        principalId,
        policyDocument,
    };
};

// const ParseSwagger = require('parse-server-swagger');

// const Parse = require('parse/node');

// Parse.initialize("b298c38bbb5cf19e3e7739fdcf917adb", "", "e89cbd61c67dfbf3b34b67e54084eada");
// //javascriptKey is required only if you have it on server.

// Parse.serverURL = 'http://tumorboard.ir/tcc'
// // Serve swagger API documentation
// const parseSwagger = new ParseSwagger({
//     swaggerUrl: "http://tumorboard.ir"
// });
// app.use(parseSwagger);


const express = require('express');
const ParseServer = require('parse-server').ParseServer;
const ParseSwagger = require('parse-server-swagger');

const run = async () => {
    const app = express();

    const server = new ParseServer({
        databaseURI: 'mongodb://localhost:27017/tcc', // Connection string for your MongoDB database
        //   cloud: './cloud/main.js', // Path to your Cloud Code
        appId: 'myAppId',
        masterKey: 'myMasterKey', // Keep this key secret!
        fileKey: 'optionalFileKey',
        serverURL: 'http://localhost:1337/tcc', // Don't forget to change to https if needed
        allowOrigin: '[::1]:1337',
        masterKeyIps: ['::ffff:10.0.97.230', '0.0.0.0/0', '::/0'],
    });

    // Start server
    await server.start();

    // Serve the Parse API on the /parse URL prefix
    app.use('/tcc', server.app);
    const parseSwagger = new ParseSwagger({
        host: 'http://localhost:1337',
        // parsePath: '/parse',
        apiRoot: '/tcc',
        appId: 'myAppId',
        masterKey: 'myMasterKey',
    });
    app.use(parseSwagger);

    app.listen(1337, function () {
        console.log('parse-server-example running on port 1337.');
    });
}

run();
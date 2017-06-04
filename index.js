const grpc = require('grpc');
const path = require('path');

module.exports = function startServer({ configFilePath, address }){
    const config = require(configFilePath);
    const handlers = require('maracuya').configureFromObject(config);
    const { maracuya } = grpc.load(path.join(__dirname, 'service.proto'));

    const server = new grpc.Server();

    server.addService(maracuya.Maracuya.service, {
        take: (call, cb) => {
            const params = call.request;
            handlers.take(params.type, params.id, params.amount || 1, cb);
        }
    });

    server.bind(address, grpc.ServerCredentials.createInsecure());
    server.start();
};
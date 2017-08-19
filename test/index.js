const grpc = require('grpc');
const path = require('path');
const expect = require('chai').expect;

const { maracuya } = grpc.load(path.join(__dirname, '../service.proto'));
const startServer = require('..');

describe('test running server', () => {
    let client;
    before(() => {
        const serverAddress = '0.0.0.0:30001';
        startServer({ 
            configFilePath: path.join(__dirname, '../deps/maracuya-config.json'),
            address: serverAddress
        });

        client = new maracuya.Maracuya(serverAddress, grpc.credentials.createInsecure());
    });

    it('should be able to perform request', done => {
        client.take({ type: 'customers', id: 'pied piper' },  (err, result) => {
            expect(err).to.be.null;
            expect(result.allowed).to.be.true;
            done();
        });
    });
});
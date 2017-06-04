const grpc = require('grpc');
const path = require('path');
const fs = require('fs');

const { maracuya } = grpc.load(path.join(__dirname, '../../service.proto'));

const client = new maracuya.Maracuya('localhost:4433', 
    grpc.credentials.createSsl(
        new Buffer(fs.readFileSync(path.join(__dirname, '../../deps/certs/ca.pem')))
    )
);

let payload = { type: 'invalid' };
console.log('Sending an invalid bucket type', payload);
client.take({ type: 'invalid' }, err => {
    console.error('An error ocurred:', err);

    payload = { type: 'customers', id: 'pied piper' };
    console.log('Sending a valid bucket type', payload);
    client.take(payload, (err, result) => {
        console.log('Result was', err, result);
    });
});
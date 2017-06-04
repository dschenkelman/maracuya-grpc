const grpc = require('grpc');
const path = require('path');

const { maracuya } = grpc.load(path.join(__dirname, '../../service.proto'));

const client = new maracuya.Maracuya('0.0.0.0:50001', grpc.credentials.createInsecure());

let payload = { type: 'invalid' };
console.log('Sending an invalid bucket type', payload);
client.take({ type: 'invalid' }, err => {
    console.error('An error ocurred:', err);

    payload = { type: 'customers', id: 'pied piper' };
    console.log('Sending a valid bucket type', payload);
    client.take(payload, (err, result) => {
        console.log('Result was', result);
    });
});
# maracuya-grpc ![](https://travis-ci.org/dschenkelman/maracuya-grpc.svg?branch=master)
A rate limiting service with a grpc interface that uses "maracuya"

## Installing
```
npm install maracuya-grpc
```

## Usage
As a library:
```node
const startServer = require('maracuya-grpc');

startServer({ 
    configFilePath: './maracuya-config-file.json',
    address: '0.0.0.0:30001'
});
```

As a binary:
```
ADDRESS=127.0.0.1:50001 MARACUYA_CONFIG=./bin/maracuya-config.json ./bin/server.js
```

## Contributing
Feel free to open issues with questions/bugs/features. PRs are also welcome.

## License
[MIT](./LICENSE)
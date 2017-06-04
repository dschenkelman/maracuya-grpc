#!/usr/bin/env node

const path = require('path');

require('dotenv-safe').load({
    sample: path.join(__dirname, './.env.example')
});

const startServer = require('..');

startServer({ 
    configFilePath: process.env.MARACUYA_CONFIG,
    address: process.env.ADDRESS
});

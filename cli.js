#!/usr/bin/env node
/*eslint no-console:0*/
'use strict';
var meow = require('meow');
var electronOpenLinkInBrowser = require('./');

var cli = meow({
  help: [
    'Usage',
    '  $ electron-open-link-in-browser [input]',
    '',
    'Examples',
    '  $ electron-open-link-in-browser',
    '  unicorns & rainbows',
    '',
    '  $ electron-open-link-in-browser ponies',
    '  ponies & rainbows',
    '',
    'Options',
    '  --foo  Lorem ipsum. Default: false'
  ]
});

console.log(electronOpenLinkInBrowser(cli.input[0] || 'unicorns'));

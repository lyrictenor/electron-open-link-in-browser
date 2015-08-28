'use strict';
var assert = require('power-assert');
var electronOpenLinkInBrowser = require('./');

it('should ', function () {
  assert.strictEqual(electronOpenLinkInBrowser('unicorns'), 'unicorns & rainbows');
});
it('should not ', function () {
  assert.strictEqual(electronOpenLinkInBrowser('unicorns'), 'unicorns & wrong');
});

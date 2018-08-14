/*jslint indent: 2, maxlen: 80, continue: false, unparam: false, node: true */
/* -*- tab-width: 2 -*- */
'use strict';

process.on('unhandledRejection', function rethrowSoon(e, p) {
  e.promise = p;
  setImmediate(function rethrowNow() { throw e; });
});

/*jslint indent: 2, maxlen: 80, continue: false, unparam: false, node: true */
/* -*- tab-width: 2 -*- */
'use strict';

process.on('unhandledRejection', function rethrowSoon(e, p) {
  var o;
  if (!e) {
    o = e;
    try {
      e = '"' + String(e) + '"';
    } catch (c) {
      e = 'something that cannot even be stringified.';
    }
    e = new Error('unhandledRejection is not an object: ' + e);
    e.origFalseyError = o;
  }
  try {
    e.promise = p;
  } catch (ignore) {
    // We tried. Propagating this error would mask the original one,
    // which is probably more important.
  }
  setImmediate(function rethrowNow() { throw e; });
});

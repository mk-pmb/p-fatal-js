
<!--#echo json="package.json" key="name" underline="=" -->
p-fatal
=======
<!--/#echo -->

<!--#echo json="package.json" key="description" -->
Re-throw unhandled promise rejections in the next turn, so other listeners get
a chance to also run.
<!--/#echo -->



API
---

This module exports nothing.
It does all work as a side effect of importing it.



<!--#toc stop="scan" -->



Known issues
------------

* Versions 0.1.x don't care whether the rejection becomes handled later.
  I currently consider this a feature, but I'd be willing to offer opt-out.
  I think it's still a better idea to setup your rejection handlers asap.
* Version 0.1.6 didn't register its handler in Node.js v24+,
  because I mistakenly assumed Node.js itself would now deal with unhandled
  promise rejections. When I added the CI test for process return value
  (exit status) though, it proved that Node.js would exit with 0 (success),
  so I had to revert that change in v0.1.7.



&nbsp;


License
-------
<!--#echo json="package.json" key=".license" -->
ISC
<!--/#echo -->

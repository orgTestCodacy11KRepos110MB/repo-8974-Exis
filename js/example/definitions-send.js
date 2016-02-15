// Example Want Definitions Send - defines how to use want for sending actions
// ARBITER set action defs

// In NodeJS you must import jsriffle:
var riffle = require('jsriffle');

// First setup your domain
var app = riffle.Domain("xs.demo.test");
// Now setup who you want to communicate with
var backend = app.subdomain("backend");

// Calls are asynchronous code, so they use
// promises, like so:
backend.call("endpoint", "arg1").want(String).then(
    function (s) {
        console.log("I got a string: " + s);
    }, function (err) {
        console.log("ERROR: " + err);
    });
// The call above sends a string, and asks for
// a string, if the backend doesn't return a string
// then the error function will be called instead.

// You can call without requiring anything in return
backend.call("hello", "hi");

// Asking for primitives
backend.call("hello").want(String).then(
    function (s) {...}
);
backend.call("hello").want(Number).then(
    function (n) {...}
);
backend.call("hello").want(Boolean).then(
   function (b) {...}
);

// Collections
backend.call("hello").want([String]).then(
    function (stringList) {...}
);
backend.call("hello").want({name: String}).then(
    function (myDict) {...}
);
// The argument myDict above will require a dict with the key name
// which is a String.

// Many arguments
// s is str, i is int, b is boolean
backend.call("hello").want(String, Number, Boolean).then(
    function (s, i, b) {...}
);
// d is str, e is a list of int's
backend.call("hello").want(String, [Number]).then(
    function (d, e) {...}
);

// End Example Want Definitions Send

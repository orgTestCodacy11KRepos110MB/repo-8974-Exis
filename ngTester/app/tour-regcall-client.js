#####################################TEST######################################
Reg call with correct type

$riffle.call("iWantStrings", "Hello").want(String).then(function (s) {
    assert(s === "Hello World", "Expected: 'Hello World' Got: " + s);
},
function (err) {
    assert(false, "Error: Promise Rejected with: " + err);
});


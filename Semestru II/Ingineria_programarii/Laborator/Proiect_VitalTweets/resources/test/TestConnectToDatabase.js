var sql = require('../js/ConnectToDatabase').sql;
var connectionSuccessful = require('../js/ConnectToDatabase').connectionSuccessful;
var fs = require('fs');

describe("Connect to database", function() {
    it("Check Database Connection", function (done) {
        if (-1 != connectionSuccessful) {
            done();
        } else {
            done(new Error("Connection failed."));
        }
    });

    it("Sql Query", function (done) {
        if (null != sql) {
            done();
        } else {
            done(new Error("SQl query return with null."));
        }
    });

    it("JSON Data", function (done) {
        fs.readFile('../json/keyTerms.json', readFileCb(err, data));
    });
});

function readFileCb(err, data) {
    if (err) {
        throw err;
    }

    if (null == data) {
        console.log("Empty json");
    }
}
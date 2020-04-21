"use strict";

const mysql = require("mysql");
const config = require("../configurations/databaseConfig");

const conn = new mysql.createConnection(config);

conn.connect(function(err) {
    if (err) {
        console.log(err);
    } else {
        console.log("Connection established.");
    }
});

function readData() {
    return new Promise(function(resolve, reject) {
        var responseObject = {};

        conn.query("SELECT * FROM Tweets", function(err, results, fields) {
            if (err) {
                reject(err);
            } else {
                console.log("Selected " + results.length + " row(s).");
                resolve({ results: results, fields: fields });
                console.log("Done.");
            }
        });
    });
}

module.exports = {
    readData: readData
};
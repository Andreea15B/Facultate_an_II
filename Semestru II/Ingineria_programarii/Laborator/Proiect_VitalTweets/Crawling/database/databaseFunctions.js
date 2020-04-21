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

        conn.query("SELECT * FROM KeyTerms", function(err, results, fields) {
            if (err) {
                reject(err);
            } else {
                console.log("Selected " + results.length + " row(s).");
                for (var j = 1; j < fields.length; j++) {
                    responseObject[fields[j].name] = [];
                }

                for (var k = 1; k < fields.length; k++) {
                    for (var i = 0; i < results.length; i++) {
                        responseObject[fields[k].name].push(
                            results[i][fields[k].name]
                        );
                    }
                }
                resolve(responseObject);
                console.log("Done.");
            }
        });
    });
}

function insertTweetIntoDatabase(data) {
    var sql = "INSERT INTO Tweets (ID, create_date, longitude, latitude, disease, username, text, pictureURL, language, nr_shares, nr_likes, screenname, country, city) VALUES (?)";
    var values = [
        data.id,
        data.created_at,
        data.longitude,
        data.latitude,
        data.id_boala,
        data.username,
        data.text,
        data.profilePicture,
        data.language,
        data.shares,
        data.likes,
        data.screen_name,
        data.country,
        data.city
    ];

    conn.query(sql, [values], function(err, result) {
        if (err) {
            console.log(err.sqlMessage);
        } else {
            console.log("Success!");
        }
    });
}

module.exports = {
    readData: readData,
    insertTweetIntoDatabase: insertTweetIntoDatabase
};

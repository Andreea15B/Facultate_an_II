var readData = require("../database/databaseFunctions").readData;
var insert = require("../database/databaseFunctions").insertTweetIntoDatabase;
const mysql = require("mysql");
const config = require("../configurations/databaseConfig");
const conn = new mysql.createConnection(config);

describe("test databaseFunctions", function() {
    var data = {
        id: "22",
        created_at: "1111-11-11501:11:11.000Z",
        longitude: "0.0",
        latitude: "0.0",
        id_boala: "1",
        username: "testname1",
        text: "Ma dor toate. #REZIST",
        profilePicture: "https://google.ro",
        language: "romgleza",
        shares: "333",
        likes: "100",
        screen_name: "testName"
    };

    it("test 'SELECT * FROM keyterms' not null", function(done) {
        readData().then(function(object) {
            if (object) {
                done();
            } else {
                done(new Error("Err: There are no keywords."));
            }
        });
    });

    it("Keyterm should be in romanian - 'pojar'", function(done) {
        readData().then(function(object) {
            if (object["ro"][0] == "pojar") {
                done();
            } else {
                done(
                    new Error(
                        "Err: The keywords are not in the desired language."
                    )
                );
            }
        });
    });

    it("Keyterm should be in english - 'measles'", function(done) {
        readData().then(function(object) {
            if (object["en"][0] == "measles") {
                done();
            } else {
                done(
                    new Error(
                        "Err: The keywords are not in the desired language."
                    )
                );
            }
        });
    });

    it("Keyterm should be in german - 'Masern'", function(done) {
        readData().then(function(object) {
            if (object["de"][0] == "Masern") {
                done();
            } else {
                done(
                    new Error(
                        "Err: The keywords are not in the desired language."
                    )
                );
            }
        });
    });

    it("Keyterm should be in french - 'rougeole'", function(done) {
        readData().then(function(object) {
            if (object["fr"][0] == "rougeole") {
                done();
            } else {
                done(
                    new Error(
                        "Err: The keywords are not in the desired language."
                    )
                );
            }
        });
    });

    it("Keyterm should be in spanish 'sarampión'", function(done) {
        readData().then(function(object) {
            if (object["es"][0] == "sarampión") {
                done();
            } else {
                done(
                    new Error(
                        "Err: The keywords are not in the desired language."
                    )
                );
            }
        });
    });

    it("Keyterm shouldn't exist", function(done) {
        readData().then(function(object) {
            if (object["ar"]) {
                done(new Error("Err: Keyterm SHOULD NOT exist."));
            } else {
                done();                
            }
        });
    });

    it("Testing if InsertTweetIntoDatabase is correctly inserting into database", function(done) {
        var ok = 0;
        insert(data);

        conn.query("DELETE FROM tweets WHERE id=22", function(err, result) {
            if (err) {
                console.log(err.sqlMessage);
            } else {                
                ok = 1;
            }
        });

        setTimeout(function() {
            if (ok == 1) {
                done();
            } else {
                done(new Error("database error."));
            }
        }, 1700);
    });
});

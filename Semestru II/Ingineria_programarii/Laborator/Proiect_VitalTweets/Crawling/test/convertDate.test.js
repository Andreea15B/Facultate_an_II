var date = require("../utils/calendarHelpers").convertDate;

describe("Vital tweets stringHelpers", function () {
    var dataTest = date("Wed Aug 22 07:06:33 +0000 2018");
    var vectDateTotal = dataTest.split(" ");
    var vectDate = vectDateTotal[0].split("-");
    var vectHour = vectDateTotal[1].split(":");
    var year = vectDate[0];
    var month = vectDate[1];
    var day = vectDate[2];
    var hour = vectHour[0];
    var min = vectHour[1];
    var sec = vectHour[2];

    it("Should return the date formatted in the following format yyyy-mm-dd hh:mm:ss", function (done) {
        if (dataTest == "2018-08-22 10:06:33") {
            //compara cu UTC+3
            done();
        } else {
            done(new Error("The date is of an unexpected format."));
        }
    });

    it("Year shouldnt be less than 2016 and more than the current year", function (done) {
        if (parseInt(year) > 2016 && parseInt(year) <= 2019) {
            done();
        } else {
            done(
                new Error(
                    "The year doesn't belong to the expected interval. 2016<yyyy<=2019"
                )
            );
        }
    });

    it("Month shouldnt be less than 1 and more than 12", function (done) {
        if (parseInt(month) > 0 && parseInt(month) <= 12) {
            done();
        } else {
            done(
                new Error(
                    "The month number doesn't belong to the expected interval. 0<mm<12"
                )
            );
        }
    });

    it("Day shouldnt be less than 1 and more than 31", function (done) {
        if (parseInt(day) > 0 && parseInt(day) <= 31) {
            done();
        } else {
            done(
                new Error(
                    "The day number doesn't belong to the expected interval. 0<dd<=31"
                )
            );
        }
    });

    it("Hour shouldnt be less than 1 and more than 12", function (done) {
        if (parseInt(hour) > 0 && parseInt(hour) <= 12) {
            done();
        } else {
            done(
                new Error(
                    "The hour doesn't belong to the expected interval. 0<hh<=23"
                )
            );
        }
    });

    it("Minute shouldnt be less than 1 and more than 59", function (done) {
        if (parseInt(min) > 0 && parseInt(min) <= 59) {
            done();
        } else {
            done(
                new Error(
                    "The minute number doesn't belong to the expected interval. 0<mm<=59"
                )
            );
        }
    });

    it("Second shouldnt be less than 1 and more than 59", function (done) {
        if (parseInt(sec) > 0 && parseInt(sec) <= 59) {
            done();
        } else {
            done(
                new Error(
                    "The second number doesn't belong to the expected interval. 0<ss<=59"
                )
            );
        }
    });
});

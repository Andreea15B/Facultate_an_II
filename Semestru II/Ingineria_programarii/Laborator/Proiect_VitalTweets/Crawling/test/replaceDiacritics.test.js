var replace = require('../utils/stringHelpers');

describe("Vital tweets utils", function() {
    var noDiacritics = replace.replaceDiacritics("Iași");
    var noDiacritics2 = replace.replaceDiacritics("Bóston");
    it("Testing function replaceDiacritics output - should be 'Iasi'", function (done) {
        if (noDiacritics == "Iasi") {
            done();
        } else {
            done(new Error("Diacritics haven't been properly removed."));
        }
    });

    it("Testing function replaceDiacritics output - should be 'Boston'", function (done) {
        if (noDiacritics2 == "Boston") {
            done();
        } else {
            done(new Error("Diacritics haven't been properly removed."));
        }
    });
});

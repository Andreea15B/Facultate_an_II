var replace = require('../utils/stringHelpers');

describe("Vital tweets utils", function() {
    var filterLinks = replace.filter("Display Items https://t.co/xFox78juL1 Angular");
    it("Testing if filter function removes the links", function (done) {
        if (filterLinks == "Display Items  Angular") {
            done();
        } else {
            done(new Error("Links haven't been properly removed."));
        }
    });

    var filterHashtags = replace.filter("Display Items https://t.co/xFox78juL1 #Angular");
    it("Testing if filter function removes hashtags", function (done) {
        if (filterHashtags == "Display Items  Angular") {
            done();
        } else {
            done(new Error("Hashtags haven't been properly removed."));
        }
    });

    var filterEmoticons = replace.filter("Display Items https://t.co/xFox78juL1 #Angular U+1F601"); 
    it("Testing if filter function removes emoticons", function (done) {
        if (filterEmoticons == "Display Items  Angular ") {
            done();
        } else {
            done(new Error("Emoticons haven't been properly removed."));
        }
    });

});
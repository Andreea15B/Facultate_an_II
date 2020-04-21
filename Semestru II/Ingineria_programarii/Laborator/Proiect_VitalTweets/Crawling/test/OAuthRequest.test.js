var Twitter = require("twitter-node-client").Twitter;
var config = require("../configurations/twitterconfig");

describe("Vital tweets Unit Testing", function() {
    var twitter = new Twitter(config);
    
    // This is the name of the test
    it("There should be a valid OAuthRequestToken", function(done) {
        twitter.getOAuthRequestToken(function(oauth) {
            if (oauth == null) {
                done(new Error("Request token is invalid"));
            } else {
                done();
            }
        });
    });
});

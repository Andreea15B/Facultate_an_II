"use strict";

var Twitter = require("twitter-node-client").Twitter;
var config = require("../configurations/twitterconfig");
var readData = require("../database/databaseFunctions").readData;
var { insertTweetIntoDatabase } = require("../database/databaseFunctions");
var calendarHelpers = require("../utils/calendarHelpers");
var { filter } = require("../utils/stringHelpers");
var getLocation = require("../utils/getLocation");
var { containsBadWords } = require("../utils/interdictions");
var badWordList = require("../utils/interdictions").getForbiddenWords();

var twitter = new Twitter(config);
var tweets = {};

function handleError(err, response, body) {
    console.log(JSON.stringify(err));
}

function success(data) {
    var disease = arguments[0];
    tweets = JSON.parse(arguments[1]).statuses;
    
    for (var index in Object.keys(tweets)) {
        getLocation(tweets[index], disease)
            .then(function(object) {
                if (containsBadWords(object.tweet.full_text, badWordList) == true) {
                    console.log("This text contains bad words");
                } else {
                    insertTweetIntoDatabase({
                        id: object.tweet.id_str,
                        created_at: calendarHelpers.convertDate( object.tweet.created_at ),
                        longitude: object.longitude,
                        latitude: object.latitude,
                        id_boala: object.disease,
                        username: object.tweet.user.name,
                        text: filter(object.tweet.full_text),
                        profilePicture: object.tweet.user.profile_image_url_https,
                        language: object.tweet.lang,
                        shares: object.tweet.retweet_count,
                        likes: object.tweet.favorite_count,
                        screen_name: object.tweet.user.screen_name,
                        userId: object.tweet.user.id_str,
                        country: object.country,
                        city: object.city
                    });
                }
            })
            .catch(function(err) {
                console.log(err);
            });
    }
}

function action() {
    readData()
        .then(function(object) {
            Object.keys(object).forEach(element => {
                for (var j = 0; j < object[element].length; j++) {
                    twitter.getCustomApiCall(
                        "/search/tweets.json",
                        {
                            q: object[element][j],
                            count: "200",
                            lang: element,
                            result_type: "recent",
                            tweet_mode: "extended",
                            filter: "verified",
                            exclude: "retweets",
                            exclude: "replies"
                        },
                        handleError,

                        // pass as a parameter the english word which describes the disease
                        success.bind(null, object['en'][j])
                    );
                }
            });
        })
        .catch(function(err) {
            console.log(err);
        });
}

function crawlingAction() {
    // Se va executa functia 'action' la un interval de 3 ore de la pornirea server-ului
    setInterval(action, 360 * 60000);
}

module.exports = {
    crawlingAction: crawlingAction,
    action: action
};

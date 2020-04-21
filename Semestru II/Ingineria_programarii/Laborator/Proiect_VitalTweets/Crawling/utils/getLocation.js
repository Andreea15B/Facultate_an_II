"use strict";

var nodeGeocoder = require("node-geocoder");
var options = require("../configurations/geocoderConfig");
var { filter } = require("../utils/stringHelpers");

var geocoder = nodeGeocoder(options);

function getLocation(tweet, disease) {
    if(tweet.hasOwnProperty('retweeted_status')) {
        tweet = tweet.retweeted_status;
    }

    var location = tweet.user.location;

    return new Promise(function(resolve, reject) {
        try {
            geocoder
                .geocode(filter(location))
                .then(function(res) {
                    if (typeof res != "undefined" && res.length != 0) {
                        if (location && disease) {
                            resolve({
                                country: res[0].country,
                                city: res[0].city,
                                latitude: res[0].latitude,
                                longitude: res[0].longitude,
                                tweet: tweet,
                                disease: disease
                            });
                        } else {
                            reject("Something went wrong");
                        }
                    } else {
                        console.log(location, filter(location));
                        reject("No location found");
                    }
                })
                .catch(function(err) {
                    console.log(err);
                });
        } catch (e) {
            console.log("Invalid location name");
        }
    });
}

module.exports = getLocation;

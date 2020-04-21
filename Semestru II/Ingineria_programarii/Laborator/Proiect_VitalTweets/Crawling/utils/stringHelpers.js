"use strict";

function replaceDiacritics(initialString) {
    var removeDiacritics = require("diacritics").remove;

    return removeDiacritics(initialString);
}

function filter(text) {
    //removing '#', special characters such as ideograms and emoticons, links
    text = text.replace(/#/g, "")
                .replace(/U\+1F6\w{2}/, "")                //removing emoticons
                .replace(/htt\w+:\/+(\w+[.|/])+\w+/g, "")   //removing links
                .replace(/[\u2100-\uFFFF]/g, "");           //removing other special characters

    return text;
}

module.exports = {
    replaceDiacritics: replaceDiacritics,
    filter: filter
};

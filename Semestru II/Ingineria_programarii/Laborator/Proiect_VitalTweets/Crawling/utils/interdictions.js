"use strict";

const lineByLine = require("n-readlines");
const liner = new lineByLine("./utils/resources/ForbiddenWords.txt");

function getForbiddenWords() {
    let line;
    let words = new Array();
    
    while ((line = liner.next())) {
        words.push(line.slice(0, line.length - 1).toString());
    }

    return words;
}

function containsBadWords(text, badWords) {
    text = text.toLowerCase();

    for (let i = 0; i < badWords.length; i++) {
        let regex = new RegExp('(^|\\W)' + badWords[i] + '($|\\W)');
        if (text.search(regex) != -1) {
            return true;
        }
    }
    return false;
}

module.exports = {
    containsBadWords: containsBadWords,
    getForbiddenWords: getForbiddenWords
};
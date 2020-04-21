"use strict";
var dateFormat = require("dateformat");

/**
 * 
 * @param {*} dateString a string which contains a date in Twitter format
 * Returns a date string in the following format yyyy-mm-dd h:MM:ss
 */
function convertDate(dateString) {
    return dateFormat(dateString, "yyyy-mm-dd h:MM:ss");
}

module.exports = {
    convertDate: convertDate
};

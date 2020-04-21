"use strict";

var express = require("express");
var router = express.Router();
var { action } = require("../crawling/crawling.js");

router.get("/refresh", function(req, res, next) {
    action();
    res.sendStatus(200);
});

module.exports = router;

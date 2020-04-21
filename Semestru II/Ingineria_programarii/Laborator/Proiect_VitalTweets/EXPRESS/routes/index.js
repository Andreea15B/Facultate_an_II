var express = require('express');
var router = express.Router();
var { readData } = require('../database/databaseFunctions');

/* GET home page. */
router.get('/', function(req, res, next) {
    readData().then(function(obj) {
        res.render('index', { markers: obj.results });
    });
});

module.exports = router;
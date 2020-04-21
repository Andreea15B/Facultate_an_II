var express = require("express");
var router = express.Router();

/* GET aboutUs page. */
router.get('/', function(req, res, next) {
  res.render('aboutUs');
});

module.exports = router;

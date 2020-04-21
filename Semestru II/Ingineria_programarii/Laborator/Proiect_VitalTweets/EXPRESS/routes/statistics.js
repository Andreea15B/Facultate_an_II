var express = require("express");
var router = express.Router();

/* GET statistics page. */
router.get('/', function(req, res, next) {
  res.render('statistics');
});

module.exports = router;

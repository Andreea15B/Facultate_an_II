const dbUtils = require("./../database/database");

module.exports = (() => {
  "use strict";

  const deleteUser = async (req, res) => {
    var dbConnection = await dbUtils.getConnection();
    var result;
    const { body } = req;
    var values = Object.values(body);
    var sql = "select AuthenticationPackage.deleteUser(:1, :2) from dual";

    if (dbConnection == undefined) {
      res.json({
        success: 0,
        loggedIn: 0,
        message: "Couldn't create database connection"
      });
      return;
    }

    try {
      result = await dbConnection.execute(sql, values);
      console.log(result);
    } catch (e) {
      console.log(e);
      // if something failed, let the client know
      res.json({
        success: 0,
        deleted: 0,
        message: "SQL Execution failed in NodeJS"
      });
      return;
    }

    res.json(JSON.parse(result["rows"][0][0]));
  };

  const isLoggedIn = async (req, res) => {
    var dbConnection = await dbUtils.getConnection();
    var result;
    var id = req.query.id;
    var sql = "select AuthenticationPackage.isLoggedIn(:1) from dual";

    if (dbConnection == undefined) {
      res.json({
        success: 0,
        loggedIn: 0,
        message: "Couldn't create database connection"
      });
      return;
    }

    console.log("Checking if user with id: " + id + " is logged in");
    try {
      result = await dbConnection.execute(sql, [id]);
    } catch (e) {
      console.log(e);
      // if something failed, let the client know
      res.json({
        success: 0,
        loggedIn: 0,
        message: "SQL Execution failed in NodeJS"
      });
      return;
    }

    res.json(JSON.parse(result["rows"][0][0]));
  };

  const signUp = async (req, res) => {
    var dbConnection = await dbUtils.getConnection();
    var result;
    const { body } = req;
    var values = Object.values(body);
    var sql = "select AuthenticationPackage.signUp(:1, :2, :3, :4, :5, :6, :7, :8, :9) from dual";

    if (dbConnection == undefined) {
      res.json({
        success: 0,
        loggedIn: 0,
        message: "Couldn't create database connection"
      });
      return;
    }

    try {
      // the signUp function from the database should commit on its own after inserting
      result = await dbConnection.execute(sql, values);
      console.log(result);
    } catch (e) {
      console.log(e);
      // if something failed, let the client know
      res.json({
        success: 0,
        id: -1,
        message: "SQL Execution failed in NodeJS"
      });
      return;
    }

    // the signUp function will return a JSON object as its result
    // so I can parse that and send to the client
    res.json(JSON.parse(result["rows"][0][0]));
  };

  const login = async (req, res) => {
    var dbConnection = await dbUtils.getConnection();
    var result;
    const { body } = req;
    var values = Object.values(body);
    console.log(values);
    var sql = "select AuthenticationPackage.logIn(:1, :2) from dual";

    if (dbConnection == undefined) {
      res.json({
        success: 0,
        loggedIn: 0,
        message: "Couldn't create database connection"
      });
      return;
    }

    try {
      result = await dbConnection.execute(sql, values);
      console.log(result);
    } catch (e) {
      console.log(e);
      // if something failed, let the client know
      res.json({
        success: 0,
        id: -1,
        message: "SQL Execution failed in NodeJS"
      });
      return;
    }

    // the logIn function will return a JSON object as its result
    // so I can parse that and send to the client
    res.json(JSON.parse(result["rows"][0][0]));
  };

  const updateUser = async (req, res) => {
    var dbConnection = await dbUtils.getConnection();
    var result;
    const { body } = req;
    var values = Object.values(body);

    console.log('received update request: ');
    console.log(values);
    var sql = "select AuthenticationPackage.updateUser(:1, :2, :3, :4, :5, :6, :7, :8, :9) from dual";

    if (dbConnection == undefined) {
      res.json({
        success: 0,
        loggedIn: 0,
        message: "Couldn't create database connection"
      });
      return;
    }

    try {
      // the signUp function from the database should commit on its own after inserting
      result = await dbConnection.execute(sql, values);
      console.log(result);
    } catch (e) {
      console.log(e);
      // if something failed, let the client know
      res.json({
        success: 0,
        id: -1,
        message: "SQL Execution failed in NodeJS"
      });
    }

    // the signUp function will return a JSON object as its result
    // so I can parse that and send to the client
    res.json(JSON.parse(result["rows"][0][0]));
  };

  const getUserInfo = async (req, res) => {
    var dbConnection = await dbUtils.getConnection();
    var result;
    var id = req.query.id;

    var sql = "select id, type, name, surname, username, email, address, country from users where id = " + id;
    console.log(sql);

    if (dbConnection == undefined) {
      res.json({
        success: 0,
        loggedIn: 0,
        message: "Couldn't create database connection"
      });
      return;
    }

    try {
      result = await dbConnection.execute(sql,);
      console.log(result);
    } catch (e) {
      console.log(e);
      // if something failed, let the client know
      res.json({
        success: 0,
        id: -1,
        message: "SQL Execution failed in NodeJS"
      });
      return;
    }

    res.json(result["rows"][0]); // an array containing all the information
  };

  return {
    signUp,
    login,
    isLoggedIn,
    deleteUser,
    updateUser,
    getUserInfo
  };
})();

const hostName = "http://localhost:3000";
const urlIsLoggedIn = hostName + "/profile/isloggedin";
const urlDeleteUser = hostName + "/profile/delete";
const urlUpdateUser = hostName + "/profile/update";
const urlGetUserInfo = hostName + "/profile/info";

function handleDelete() {
  deleteData = $("#delete-account-form").serializeArray();
  credentials = {};
  credentials["id"] = localStorage.getItem("idUserLoggedIn");

  for (var i = 0; i < deleteData.length; ++i)
    credentials[deleteData[i]["name"]] = deleteData[i]["value"];


  // while I'm waiting for a response from the database
  // remove any previous messages
  $("#delete-esponse").text("");
  // show the loading animation
  $("#delete-response").append("<div class='loader'></div>");

  $.post(urlDeleteUser, credentials)
    .done(function (data) {
      console.log(data);
      $("#delete-response").text(data["message"]);
    })
    .fail(function (e) {
      console.log(e);
    });
}

function handleUpdate() {
  deleteData = $("#update-account-form").serializeArray();
  credentials = {};
  credentials["id"] = localStorage.getItem("idUserLoggedIn");

  for (var i = 0; i < deleteData.length; ++i)
    credentials[deleteData[i]["name"]] = deleteData[i]["value"];

  console.log("Credentials: ");
  console.log(credentials);


  // while I'm waiting for a response from the database
  // remove any previous messages
  $("#update-response").text("");
  // show the loading animation
  $("#update-response").append("<div class='loader'></div>");

  $.post(urlUpdateUser, credentials)
    .done(function (data) {
      console.log(data);
      $("#update-response").text(data["message"]);
    })
    .fail(function (e) {
      console.log(e);
    });
}

function getUserInfo() {
  $.get(urlGetUserInfo, { id: localStorage.getItem("idUserLoggedIn") })
    .done(function (data) {
      console.log(data);
      console.log(data.length);

      // display on profile.html the current user's information
      for (var i = 0; i < data.length; ++i) {
        $(`#user-info-${i}`).text(data[i]); // using backtics (`) instead of " so i can format the string
        console.log(`user-info-${i}`);
      }
    })
    .fail(function (e) {
      console.log(e);
      window.location.replace("login.html");
    });
}



$(document).ready(function () {
  if (localStorage.getItem("idUserLoggedIn") == null) {
    window.location.replace("login.html");
    return;
  }

  $.get(urlIsLoggedIn, { id: localStorage.getItem("idUserLoggedIn") })
    .done(function (data) {
      if (data["isLoggedIn"] == 0) {
        window.location.replace("login.html");
        return;
      }

      // if the user is logged in, also get his user info
      getUserInfo();
    })
    .fail(function (e) {
      console.log(e);
      window.location.replace("login.html");
      return;
    });

  $("#delete-button").on("click", function () {
    handleDelete();
  });

  $("#update-button").on("click", function () {
    handleUpdate();
  });

});

$(document).ready(function () {
    const hostName = 'http://localhost:3000';
    const urlLogIn = hostName + '/login';

    $('#login-button').on('click', function () {
        handleLogIn();
    });

    function handleLogIn() {
        logInData = $('form').serializeArray();
        credentials = {};
        for (var i = 0; i < logInData.length; ++i)
            credentials[logInData[i]["name"]] = logInData[i]["value"];

        console.log('Logging with:');
        console.log(credentials);

        // while I'm waiting for a response from the database
        // remove any previous messages
        $("#response").text("");
        // show the loading animation
        $("#response").append("<div class='loader'></div>");

        $.post(urlLogIn, credentials)
            .done(function (data) {
                // give some feedback to the user
                // also replaces the child of response (the loader div) with just text
                $("#response").text(data["message"]);
                if (data["success"] == 1) {
                    localStorage.setItem("lastTimeLoggedIn", Date.now());
                    localStorage.setItem("idUserLoggedIn", data["id"]);
                    window.location.replace('profile.html');
                }
            })
            .fail(function (e) {
                $("#response").text("Login POST failed.");
                console.log(e);
            });
    }

});
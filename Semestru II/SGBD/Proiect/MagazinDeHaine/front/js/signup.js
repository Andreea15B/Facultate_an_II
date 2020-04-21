$(document).ready(function () {
    const hostName = 'http://localhost:3000';
    const urlSignUp = hostName + '/signup';

    $('#signup-button').on('click', function () {
        handleSignUp();
    });

    function handleSignUp() {
        signUpData = $('form').serializeArray();
        credentials = {};
        for (var i = 0; i < signUpData.length; ++i)
            credentials[signUpData[i]["name"]] = signUpData[i]["value"];

        console.log('Signing up with:');
        console.log(credentials);

        // while I'm waiting for a response from the database
        // remove any previous messages
        $("#response").text("");
        // show the loading animation
        $("#response").append("<div class='loader'></div>");

        $.post(urlSignUp, credentials)
            .done(function (data) {
                // give some feedback to the user
                // also replaces the child of response (the loader div) with just text
                $("#response").text(data["message"]);
                if (data["success"] == 1) {
                    localStorage.setItem("lastTimeLoggedIn", Date.now());
                    localStorage.setItem("idUserLoggedIn", data["id"]);
                }
            })
            .fail(function (e) {
                $("#response").text("SignUp POST failed.");
                console.log(e);
            });
    }

});
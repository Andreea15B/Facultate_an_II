const hostName = "http://localhost:3000";
const urlGetOrders = hostName + "/orders";
const urlIsLoggedIn = hostName + "/profile/isloggedin";

$(document).ready(function () {
    // make sure user is logged in
    if (!localStorage.getItem("idUserLoggedIn")) {
        window.location.replace("login.html");
        return;
    }

    $.get(urlIsLoggedIn, { id: localStorage.getItem("idUserLoggedIn") })
        .done(function (data) {
            if (data["isLoggedIn"] == 0) {
                window.location.replace("login.html");
                return;
            }

            $.get(urlGetOrders, { id_user: localStorage.getItem("idUserLoggedIn") })
                .done(function (data) {
                    console.log(data);

                    data.forEach(addOrder);
                })
                .fail(function (e) {
                    console.log(e);
                });
        })
        .fail(function (e) {
            console.log(e);
            window.location.replace("login.html");
            return;
        });



    $.get(urlGetOrders)
});

function addOrder(orderId) {
    var order = document.createElement("p");
    order.textContent = orderId;
    
    var ordersDiv = document.getElementById("orders");
    ordersDiv.append(order);
}
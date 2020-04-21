const hostName = "http://localhost:3000";
const urlGetCategories = hostName + '/categories';
const urlGetProducers = hostName + '/producers';
const urlIsLoggedIn = hostName + '/profile/isLoggedIn';
const urlAddProduct = hostName + '/products/add';
const urlAddProductImage = hostName + '/products/addimage';


$(document).ready(function () {
    // if user is not logged in, redirect to login
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
        })
        .fail(function (e) {
            console.log(e);
            window.location.replace("login.html");
            return;
        });

    $.get(urlGetCategories).done(function (data) {
        data.forEach(addCategory);
    });

    $.get(urlGetProducers).done(function (data) {
        data.forEach(addProducer);
    });

    $("#add-product-button").on('click', function () {
        handleAddProduct();
    });
});

function handleAddProduct() {
    var FR = new FileReader();
    var formData = $('#add-product-form').serializeArray();
    productData = {};

    for (var i = 0; i < formData.length; ++i)
        productData[formData[i]["name"]] = formData[i]["value"];
    productData["id_user"] = localStorage.getItem("idUserLoggedIn");

    var imageInput = document.getElementById("product-image-input");
    if (imageInput.files == undefined || imageInput.files.length == 0) {
        console.log("You need to load an image");
        return;
    }

    // remove any previous messages
    $("#response").text("");
    // show the loading animation
    $("#response").append("<div class='loader'></div>");

    // convert image to base64
    // see here: https://stackoverflow.com/questions/17710147/image-convert-to-base64
    FR.addEventListener("load", function (e) {
        console.log("loaded");
        // after the image is loaded, e.target.result represents the image encoded in base64
        $.post(urlAddProduct, productData)
            // i first add the product
            .done(function (data) {
                $("#response").text(data["message"]);
                console.log(data);
                // then, if everything is ok, I add its image
                if (data["success"] == 0) return;

                // get the product id
                var productId = data["id"];
                $.post(urlAddProductImage, { product_image: e.target.result, id: productId })
                    .done(function (data) {
                        $("#response").text(data["message"]);
                        console.log(data);
                    }).fail(function (e) {
                        console.log("Could not add product image");
                        console.log(e);
                    });
            })
            .fail(function (e) {
                console.log('Could not add product');
                console.log(e);
                $("#response").text("Product could not be added: " + e.toString());
            });
    });
    FR.readAsDataURL(imageInput.files[0]);
}

function addCategory(categoryInfo) {
    var newCategory = document.createElement("option");
    newCategory.setAttribute("value", `${categoryInfo["id"]}`);
    newCategory.textContent = categoryInfo["name"];

    $("#select-category").append(newCategory);
}


function addProducer(producerInfo) {
    var newProducer = document.createElement("option");
    newProducer.setAttribute("value", `${producerInfo["id"]}`);
    newProducer.textContent = producerInfo["name"];

    $("#select-producer").append(newProducer);
}
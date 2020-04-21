const hostName = "http://localhost:3000";
const urlGetProducts = hostName + '/products';
const urlGetProductInfo = hostName + '/product';
const urlGetProductImage = hostName + '/product/image';
const urlGetNumberOfProducts = hostName + '/products/count';
const urlGetProductsFilters = hostName + '/products/filters';
const urlIsLoggedIn = hostName + "/profile/isloggedin";
const urlPlaceOrder = hostName + "/orders/place";

$(document).ready(function () {
    getProducts();
    addPageButtons();
    getProductsFilters();
});

function getProductsFilters() {
    $.get(urlGetProductsFilters)
        .done(function (data) {
            if (data["success"] != 1) {
                console.log("failed to get filters");
                return;
            }

            var form = document.getElementsByClassName("filter-form")[0];

            for (var i in Object.keys(data)) {
                var key = Object.keys(data)[i];
                if (key == "success" || key == "category" || key == "producer") continue;
                var label = document.createElement("label");
                label.setAttribute("for", key);
                label.textContent = key;

                var select = document.createElement("select");
                select.setAttribute("name", key);
                // content.classList.add("content");
                var option = document.createElement("option");
                option.setAttribute("name", "all");
                option.setAttribute("value", "all");
                option.textContent = "all";
                select.append(option);

                for (var j in data[key]) {
                    var option = document.createElement("option");
                    option.setAttribute("name", data[key][j]);
                    option.setAttribute("value", data[key][j]);
                    option.textContent = data[key][j];
                    select.append(option);
                }

                form.append(label);
                form.append(select);
            }

            // categories and producers separately
            for (var i in Object.keys(data)) {
                var key = Object.keys(data)[i];
                if (key != "category" && key != "producer") continue;
                var label = document.createElement("label");
                label.setAttribute("for", key == "category" ? "id_category" : "id_producer");
                label.textContent = key;

                var select = document.createElement("select");
                select.setAttribute("name", key == "category" ? "id_category" : "id_producer");
                // content.classList.add("content");
                var option = document.createElement("option");
                option.setAttribute("name", "all");
                option.setAttribute("value", "all");
                option.textContent = "all";
                select.append(option);

                for (var j in data[key]) {
                    var option = document.createElement("option");
                    option.setAttribute("name", data[key][j]["name"]);
                    option.setAttribute("value", data[key][j]["id"]);
                    option.textContent = data[key][j]["name"];
                    select.append(option);
                }

                form.append(label);
                form.append(select);
            }


            var submit = document.createElement("button");
            submit.setAttribute("type", "button");
            submit.textContent = "Submit";
            submit.setAttribute("id", "form-submit");
            form.append(submit);
            addListenerForFormSubmit();
        })
        .fail(function (e) {
            console.log(e);
        });
}

function addListenerForFormSubmit() {
    $("#form-submit").on('click', function () {
        var data = $("form").serializeArray();
        var newUrl = window.location.href;

        for (var i in data) {
            var newValue = null;
            if (data[i]["value"] != "all")
                newValue = data[i]["value"];
            newUrl = updateSearchParameterInCurrentUrl(newUrl, data[i]["name"], newValue);
            console.log(newUrl);
        }

        if (newUrl == window.location.href) return;
        window.location.replace(newUrl);
    });
}

function getProducts() {
    // https://stackoverflow.com/questions/8648892/convert-url-parameters-to-a-javascript-object
    var search = location.search.substring(1);
    var searchParametersObject = {};

    if (search.length > 0)
        searchParametersObject = JSON.parse('{"' + search.replace(/&/g, '","').replace(/=/g, '":"') + '"}', function (key, value) { return key === "" ? value : decodeURIComponent(value) })
    else
        searchParametersObject = {};

    $.get(urlGetProducts, searchParametersObject)
        .done(function (data) {
            data.forEach(addProduct);
        }).fail(function (e) {
            console.log("get products failed");
            console.log(e);
        });
}

function addPageButtons() {
    var currentPortion = 1;
    if (getQueryStringValue("portion"))
        currentPortion = parseInt(getQueryStringValue("portion"));
    else
        currentPortion = 1;

    $.get(urlGetNumberOfProducts)
        .done(function (data) {
            var numberOfProducts = data["numberOfProducts"];
            // a product page will contain only 50 items
            var numberOfPages = Math.ceil(numberOfProducts / 50);
            // if there are too many pages, add the first one separately 
            if (currentPortion != 1 && numberOfPages > 20) {
                $(".page-count").append(createPageButton(1));
                addListenerForPageButton(1);
            }

            // add the max 18 buttons in-between
            var lastButton = Math.min(currentPortion + 18, numberOfPages - 1);
            var firstButton = (numberOfPages > 20 ? currentPortion : 1);
            for (var i = firstButton; i <= lastButton; i++) {
                $(".page-count").append(createPageButton(i));
                addListenerForPageButton(i);

            }

            // add the last one separately
            $(".page-count").append(createPageButton(numberOfPages));
            addListenerForPageButton(numberOfPages);
        });

}

function addListenerForPageButton(buttonNumber) {
    $(`#page-button-${buttonNumber}`).on('click', function (data) {
        // the user wants another page
        // so I reload the page with the proper portion parameter
        var newUrl = updateSearchParameterInCurrentUrl(window.location.href, "portion", buttonNumber);
        window.location.replace(newUrl);
    });
}

function updateSearchParameterInCurrentUrl(url, parameter, value) {
    // returns the new url
    var currentUrl = new URL(url);
    var queryString = currentUrl.search;
    var searchParams = new URLSearchParams(queryString);

    if (value == null)
        searchParams.delete(parameter);
    else
        searchParams.set(parameter, value);
    // change the search property of the main url
    currentUrl.search = searchParams.toString();
    // the new url string
    var newUrl = currentUrl.toString();
    return newUrl;
}

function createPageButton(value) {
    var pageButton = document.createElement("button");
    pageButton.textContent = `${value}`;
    pageButton.setAttribute("id", `page-button-${value}`);
    return pageButton;
}

function getQueryStringValue(key) {
    return decodeURIComponent(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURIComponent(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
}

function addProduct(productId) {
    $.get(urlGetProductInfo + '?id=' + `${productId}`)
        .done(function (data) {
            // add product to page
            // <div class="product-box">
            //     <img src="imagini/men/men1.jpg" alt="ShoeImage" />
            //     <div class="product-box-title">
            //         <p>Man Shoes #1</p>
            //     </div>
            // </div>
            var product = document.createElement("div");
            product.classList.add("product-box");
            product.setAttribute("id", `product-box-${productId}`);
            var productImage = document.createElement("img");
            productImage.setAttribute("src", "https://www.jainsusa.com/images/store/landscape/not-available.jpg");

            var productTitle = document.createElement("div");
            productTitle.classList.add("product-box-title");
            productTitle.textContent = `${data["name"]}; id: ${data["id"]}; price: ${data["price"]}; id_category: ${data["id_category"]}; color: ${data["color"]}`;

            var orderButton = document.createElement("button");
            orderButton.setAttribute("id", `order-product-${productId}`);
            orderButton.textContent = "Order";

            var quantity = document.createElement("input");
            quantity.setAttribute("type", "number");
            quantity.setAttribute("id", `order-product-quantity-${productId}`);

            product.appendChild(productImage);
            product.appendChild(productTitle);
            product.appendChild(quantity);
            product.appendChild(orderButton);

            $(".products-showcase").append(product);

            getImageForProduct(productId);
            addListenerForOrderButton(productId);

        });
}

async function addListenerForOrderButton(productId) {
    $(`#order-product-${productId}`).on('click', function () {
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

                var quantity;

                // if quantity has not been entered
                if (!parseInt(document.getElementById(`order-product-quantity-${productId}`).value)) {
                    console.log("Enter a quantity!!!");
                    return;
                }
                else
                    quantity = document.getElementById(`order-product-quantity-${productId}`).value;

                // if he is logged in, then place order
                $.post(urlPlaceOrder, {
                    id_user: localStorage.getItem("idUserLoggedIn"),
                    id_product: productId,
                    quantity: quantity
                })
                    .done(function (data) {
                        console.log(data);
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

    });
}

async function getImageForProduct(productId) {
    $.get(urlGetProductImage, { id: productId }).done(function (data) {
        var productBox = document.getElementById(`product-box-${productId}`);
        if (data["success"] == 1 && data["image"]) {
            var image = new Image();
            image.src = data["image"];
            // var productImage = document.createElement("img");
            // replace the "no image available" with the real image
            productBox.replaceChild(image, productBox.getElementsByTagName("img")[0]);
        }
    });
}
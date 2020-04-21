module.exports = (() => {
    "use strict";
    const express = require("express");
    const bodyParser = require('body-parser');
    const cors = require('cors');
    const { signUp, login, isLoggedIn, deleteUser, updateUser, getUserInfo } = require('./authentication');
    const { getProducts, getProductInfo, getCategories, getProducers, addProduct, addProductImage, getProductsCount, getImageForProduct, getProductsFilters } = require('./product_actions');
    const { placeOrder, getOrders } = require('./order_actions');

    let serverInterface = undefined;
    const getInstance = () => {
        // The server is Singleton
        serverInterface || (serverInterface = initialize());
        return serverInterface;
    };

    const initialize = () => {
        const app = express();
        app.use(bodyParser.urlencoded({ extended: false, limit: '50mb' }));
        app.use(bodyParser.json());
        app.use(cors());

        app.get('/', function (req, res) {
            res.send('Hello! The API is at http://localhost/api');
        });
        app.get('/profile/isloggedin', isLoggedIn);
        app.get('/profile/info', getUserInfo);
        app.get('/products', getProducts);
        app.get('/products/count', getProductsCount);
        app.get('/categories', getCategories);
        app.get('/producers', getProducers);
        app.get('/product', getProductInfo);
        app.get('/product/image', getImageForProduct);
        app.get('/products/filters', getProductsFilters);
        app.get('/orders', getOrders);
        app.post('/signup', signUp);
        app.post('/login', login);
        app.post('/profile/delete', deleteUser);
        app.post('/profile/update', updateUser);
        app.post('/products/add', addProduct);
        app.post('/orders/place', placeOrder);
        // the image is added separately because it is encoded in base64
        // which is a very long string
        // and PL/SQL functions for some reason don't accept strings that large
        app.post('/products/addimage', addProductImage);

        const start = (port) => {
            app.listen(port); // start listening for requests
        };
        return Object.freeze({
            start
        });
    };
    return Object.freeze({
        getInstance
    });
})();
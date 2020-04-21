const dbUtils = require("./../database/database");

module.exports = (() => {
    "use strict";

    function buildQueryValues(query) {
        var values = {};
        values["portion"] = query.portion ? parseInt(query.portion) : 1;
        values["id_category"] = query.id_category ? parseInt(query.id_category) : null;
        values["id_producer"] = query.id_producer ? parseInt(query.id_producer) : null;
        values["min_price"] = query.min_price ? parseInt(query.min_price) : null;
        values["max_price"] = query.max_price ? parseInt(query.max_price) : null;
        values["min_rating"] = query.min_rating ? parseInt(query.min_rating) : null;
        values["color"] = query.color ? query.color : null;
        values["product_size"] = query.product_size ? query.product_size : null;
        values["material_type"] = query.material_type ? query.material_type : null;
        values["gender"] = query.gender ? query.gender : null;
        return Object.values(values);
    }

    const getProducts = async (req, res) => {
        var dbConnection = await dbUtils.getConnection();
        var result;
        var values = buildQueryValues(req.query);
        var sql = "select ProductsPackage.filterProducts(:1, :2, :3, :4, :5, :6, :7, :8, :9, :10) from dual";

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

    const getProductInfo = async (req, res) => {
        var dbConnection = await dbUtils.getConnection();
        var result;
        var sql = `select ProductsPackage.getProductInfo(${req.query.id ? parseInt(req.query.id) : null}) from dual`;

        if (dbConnection == undefined) {
            res.json({
                success: 0,
                loggedIn: 0,
                message: "Couldn't create database connection"
            });
            return;
        }

        try {
            result = await dbConnection.execute(sql);
            // console.log(result);
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

    const getCategories = async (req, res) => {
        var dbConnection = await dbUtils.getConnection();
        var result;
        var sql = 'select ProductsPackage.getCategories() from dual';

        if (dbConnection == undefined) {
            res.json({
                success: 0,
                loggedIn: 0,
                message: "Couldn't create database connection"
            });
            return;
        }

        try {
            result = await dbConnection.execute(sql);
            // console.log(result);
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

    const getProducers = async (req, res) => {
        var dbConnection = await dbUtils.getConnection();
        var result;
        var sql = 'select ProductsPackage.getProducers() from dual';

        if (dbConnection == undefined) {
            res.json({
                success: 0,
                loggedIn: 0,
                message: "Couldn't create database connection"
            });
            return;
        }

        try {
            result = await dbConnection.execute(sql);
            // console.log(result);
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

    function buildProductInfo(productData) {
        // this is the info I must receive
        // and I have to build them for the addProduct function from the database in this order
        var necessaryFields = ["id_user", "password", "id_category", "id_producer", "name", "price", "color", "product_size", "material_type", "stock", "gender"];
        // some of the fields need to be converted from char to int
        var requiresParsedToInt = [true, false, true, true, false, true, false, false, false, true, false];
        var values = {};

        for (var i = 0; i < necessaryFields.length; ++i) {
            if (!productData[necessaryFields[i]])
                return null;
            if (requiresParsedToInt[i])
                values[necessaryFields[i]] = parseInt(productData[necessaryFields[i]]);
            else
                values[necessaryFields[i]] = productData[necessaryFields[i]];
        }

        return values;
    }

    const addProduct = async (req, res) => {
        var dbConnection = await dbUtils.getConnection();
        var { body } = req;
        var productInfo = buildProductInfo(body);
        var result;

        if (productInfo == null) {
            res.json({
                success: false,
                message: "Product information is incorrect!"
            });
            return;
        }

        var sql = 'select ProductsPackage.addProduct(:id_user, :password, :id_category, :id_producer, :name, :price, :color, :product_size, :material_type, :stock, :gender) from dual';

        if (dbConnection == undefined) {
            res.json({
                success: 0,
                message: "Couldn't create database connection"
            });
            return;
        }

        try {
            // here productInfo represents a JSON object where each field corresponds to a field from the sql statement above
            result = await dbConnection.execute(sql, productInfo);
        } catch (e) {
            console.log(e);
            // if something failed, let the client know
            res.json({
                success: 0,
                message: "SQL Execution failed in NodeJS"
            });
            return;
        }

        res.json(JSON.parse(result["rows"][0][0]));

    };

    const addProductImage = async (req, res) => {
        var dbConnection = await dbUtils.getConnection();
        var { body } = req;
        var result;

        if (!body["product_image"] || !body["id"]) {
            res.json({
                success: 0,
                message: "Image or product id not provided!"
            });
            return;
        }

        var sql = 'update products set imageinbase64 = :product_image where id = :id';

        if (dbConnection == undefined) {
            res.json({
                success: 0,
                message: "Couldn't create database connection"
            });
            return;
        }

        try {
            result = await dbConnection.execute(sql, {
                product_image: body["product_image"],
                id: body["id"]
            });
            console.log(result);
        } catch (e) {
            console.log(e);
            // if something failed, let the client know
            res.json({
                success: 0,
                message: "SQL Execution failed in NodeJS"
            });
            return;
        }

        res.json({
            success: true,
            message: "Image added!"
        });
    };

    const getProductsCount = async (req, res) => {
        var dbConnection = await dbUtils.getConnection();
        var sql = 'select count(*) from products';
        var result;

        if (dbConnection == undefined) {
            res.json({
                success: 0,
                message: "Couldn't create database connection"
            });
            return;
        }

        try {
            result = await dbConnection.execute(sql);
            console.log(result);
        } catch (e) {
            console.log(e);
            // if something failed, let the client know
            res.json({
                success: 0,
                message: "SQL Execution failed in NodeJS"
            });
            return;
        }

        res.json({ success: true, numberOfProducts: result["rows"][0][0] });
    };

    const getImageForProduct = async (req, res) => {
        var dbConnection = await dbUtils.getConnection();
        var id = req.query.id;
        if (!id) {
            res.json({
                success: false,
                message: "Product id is invalid!"
            });
            return;
        }
        var sql = 'select imageinbase64 from products where id = :id';
        var result;

        if (dbConnection == undefined) {
            res.json({
                success: 0,
                message: "Couldn't create database connection"
            });
            return;
        }

        try {
            result = await dbConnection.execute(sql, [id]);
        } catch (e) {
            console.log(e);
            // if something failed, let the client know
            res.json({
                success: 0,
                message: "SQL Execution failed in NodeJS"
            });
            return;
        }

        // the result now contains in result["rows"][0][0] a LOB, the CLOB from products table
        // and in database.js we have: 
        // oracledb.fetchAsString = [ oracledb.CLOB ]; // return CLOBS as strings
        // so every clob is returned as a string
        // so the image is a base64 encoding as a string
        res.json({ success: true, image: result["rows"][0][0], message: "ok" });
    };

    const getProductsFilters = async (req, res) => {
        var dbConnection = await dbUtils.getConnection();
        var sql = 'select ProductsPackage.getProductsFilters() from dual';
        var result;

        if (dbConnection == undefined) {
            res.json({
                success: 0,
                message: "Couldn't create database connection"
            });
            return;
        }

        try {
            result = await dbConnection.execute(sql);
        } catch (e) {
            console.log(e);
            // if something failed, let the client know
            res.json({
                success: 0,
                message: "SQL Execution failed in NodeJS"
            });
            return;
        }

        var obj = JSON.parse(result["rows"][0][0]);
        obj["success"] = 1;
        res.json(obj);
    };

    return {
        getProducts,
        getProductInfo,
        getCategories,
        getProducers,
        addProduct,
        addProductImage,
        getProductsCount,
        getImageForProduct,
        getProductsFilters
    };
})();

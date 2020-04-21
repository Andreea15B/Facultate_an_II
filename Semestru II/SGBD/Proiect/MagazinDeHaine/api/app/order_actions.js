const dbUtils = require("./../database/database");

module.exports = (() => {
    "use strict";

    const placeOrder = async (req, res) => {
        var dbConnection = await dbUtils.getConnection();
        var result;
        const { body } = req;

        var sql = 'BEGIN OrdersPackage.placeOrder(:id_user, :id_product, :quantity); END;';

        try {
            result = await dbConnection.execute(sql, body);
            console.log(result);
        }
        catch (e) {
            console.log(e);
            res.json({
                success: false,
                message: "SQL failed in NodeJS"
            });
            return;
        }

        res.json({
            success: true,
            message: "order placed!"
        });
    }

    const getOrders = async (req, res) => {
        var dbConnection = await dbUtils.getConnection();
        var result;
        var id_user = req.query.id_user;

        if (!id_user) {
            res.json({
                success: 0,
                message: "id_user was not provided!"
            });
            return;
        }

        var sql = 'select id from orders where id_user = :id_user'; // nu permite SQL injection
        // var sql = 'select id from orders where id_user = ' + id_user; // SQL injection

        try {
            result = await dbConnection.execute(sql, [id_user]); // nu permite SQL injection
            // result = await dbConnection.execute(sql); // permite SQL injection
            console.log(result);
        }
        catch (e) {
            console.log(e);
            res.json({
                success: false,
                message: "SQL failed in NodeJS"
            });
            return;
        }

        // res.json(JSON.parse(result["rows"][0][0]));

        var obj = [];
        for (var i in result["rows"]) {
            obj.push(result["rows"][i]);
        }
        res.json(obj);
    }


    return {
        placeOrder,
        getOrders
    };
})();

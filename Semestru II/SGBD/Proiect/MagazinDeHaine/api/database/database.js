var oracledb = require('oracledb');
oracledb.autoCommit = true; // commit after every insert or update or delete or create
oracledb.fetchAsString = [ oracledb.CLOB ]; // return CLOBS as strings

module.exports = (() => {
    "use strict";

    let databaseInterface = undefined;
    const getConnection = async () => {
        // The server is Singleton
        if (databaseInterface == undefined)
            databaseInterface = await initialize();
        return databaseInterface;
    };


    const initialize = async () => {
        var connection = undefined;
        try {
            connection = await oracledb.getConnection({
                user: 'STUDENT',
                password: 'STUDENT',
                connectString: 'localhost',
            });
            console.log("Successfully connected to Oracle!")
        } catch (err) {
            console.log("Error: ", err);
        }
        return connection;
    }

    return {
        getConnection
    }
})();


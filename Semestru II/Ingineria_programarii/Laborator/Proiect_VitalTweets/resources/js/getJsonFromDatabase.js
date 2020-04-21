const mysql = require('mysql');
const fs = require('fs');

const con = mysql.createConnection({
	host: 'fenrir.info.uaic.ro',
	user: 'dbip',
	password: '9TheAH11Lc',
	database: 'dbip'
});

con.connect(function (err) {
	if (err) {
		throw err;
	}

	console.log("Connected!");

	sql = 'SELECT disease AS Disease, country AS Country, count(disease) AS Cases FROM Tweets GROUP BY disease, country';
	filename = '../json/tweetsView.json';
	getJsonView(sql, filename);

	sql = 'SELECT * FROM KeyTerms';
	filename = '../json/keyTermsView.json';
	getJsonView(sql, filename);

	console.log("Disconnected!");

	con.end();
});

function getJsonView (sql, filename) {
	con.query(sql, function (err, result) {
		if (err) throw err;

		fs.writeFile(filename, JSON.stringify(result), function (err) {
			if (err) {
				throw err;
			}
		});
	});
}


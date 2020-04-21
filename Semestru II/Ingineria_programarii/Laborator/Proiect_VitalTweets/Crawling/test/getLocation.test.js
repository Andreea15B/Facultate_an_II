var getLocation = require("../utils/getLocation");

describe("Test extract country,city, latitude and longitude", function() {
    var locationTest = {
        latitude: 48.8566101,
        longitude: 2.3514992,
        country: "France",
        city: "Paris"
    };
    it("Location should correspond with the locationTest", function(done) {
        getLocation(null, "paris")
            .then(function(location) {
                var country = location.country;
                var city = location.city;
                var latitude = location.latitude;
                var longitude = location.longitude;
                if (
                    locationTest.country == country &&
                    locationTest.city == city &&
                    locationTest.latitude == latitude &&
                    locationTest.longitude == longitude
                ) {
                    done();
                } else {
                    done(new Error("The location do not match the real one."));
                }
            })
            .catch(function(err) {
                done(new Error(err));
            });
    });
});

describe("test getLocation", function() {
    var realCoord = ["38.8950092", "-77.0365625"];

    it("Latitude and longitude should correspond with the correct coordinates of Washington", function(done) {
        getLocation(null, "Washington")
            .then(function(coordinates) {
                var long = coordinates.longitude;
                var lat = coordinates.latitude;
                if (
                    parseFloat(realCoord[0]).toPrecision(4) ==
                        parseFloat(lat).toPrecision(4) &&
                    parseFloat(realCoord[1]).toPrecision(4) ==
                        parseFloat(long).toPrecision(4)
                ) {
                    done();
                } else {
                    done(
                        new Error("The coordinates do not match the real ones.")
                    );
                }
            })
            .catch(function(err) {
                done(new Error(err));
            });
    });
});

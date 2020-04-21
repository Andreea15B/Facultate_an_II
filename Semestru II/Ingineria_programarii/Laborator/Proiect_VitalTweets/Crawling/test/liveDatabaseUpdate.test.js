const assert = require("assert");
const request = require("supertest");
const app = require("../app");

describe("Unit testing the /refresh route", function() {
    it("should return OK status", function() {
        return request(app)
            .get("/refresh")
            .then(function(response) {
                assert.equal(response.status, 200);
            });
    });
});

describe("Unit testing the / route", function() {
    it("should return OK status", function() {
        return request(app)
            .get("/")
            .then(function(response) {
                assert.equal(response.status, 200);
            });
    });
});

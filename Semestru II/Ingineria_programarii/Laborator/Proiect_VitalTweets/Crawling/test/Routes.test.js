const assert = require("assert");
const expect = require("chai").expect;
const request = require("supertest");
const router = require("../app");

describe("Unit testing the /refresh route", function() {
    it("should return OK status", function() {
        return request(router)
            .get("/refresh")
            .then(function(response) {
                assert.equal(response.status, 200);
            });
    });
});

describe("Unit testing the / route", function() {
    it("should return OK status", function() {
        return request(router)
            .get("/")
            .then(function(response) {
                assert.equal(response.status, 200);
            });
    });
});

describe("Unit testing a non-existent route", function() {
    it('should return "Not Found" status', function() {
        return request(router)
            .get("/doesNotExist")
            .then(function(response) {
                assert.equal(response.status, 404);
            });
    });
});

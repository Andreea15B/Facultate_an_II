
describe("Vital tweets utils", function() {
    var data={
        created_at: 'Mon May 06 10:53:23 +0000 2019',
        id: 1125352855198675000,
        id_str: '1125352855198674944',
        full_text:
         'A prisión hombre que abusó de su sobrino y le contagió sífilis https://t.co/uBsMrkzMXJ',
        truncated: false,
        display_text_range: [ 0, 86 ]
    };
    it("Check if tweet has 'full_text' property", function (done) {
        if (data.hasOwnProperty('full_text')) {
            done();
        } else {
            done(new Error("Tweet does not have full_text property."));
        }
    });
    var data1={
        created_at: 'Mon May 06 10:53:23 +0000 2019',
        id: 1125352855198675000,
        id_str: '1125352855198674944',
        full_tex:
         'A prisión hombre que abusó de su sobrino y le contagió sífilis https://t.co/uBsMrkzMXJ',
        truncated: false,
        display_text_range: [ 0, 86 ]
    };
    it("Check if tweet hasn't 'full_text' property", function (done) {
        if (data1.hasOwnProperty('full_text') == 0) {
            done();
        } else {
            done(new Error("Tweet does not have full_text property."));
        }
    });
});
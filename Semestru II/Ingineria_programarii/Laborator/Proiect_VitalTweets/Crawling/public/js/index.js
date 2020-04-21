$( ".refresh" ).click(function() {
    $(".refresh").toggleClass("down").css("pointer-events", "none").css("color", "gray");

    $.ajax({
        type:"GET",
        contentType:"json", 
        url: "/refresh",
        error: function(error){
            alert(JSON.stringify(error));
        },
        success: function(result) {
            $("#onclick").css("visibility", "visible");

            setTimeout(function() {
                $("#onclick").css("visibility", "hidden");
            }, 30000); 

            setTimeout(function() {
                $(".refresh").css("pointer-events", "auto").css({"color": "white"});
            }, 30 * 60000); 
        }    
    });
});
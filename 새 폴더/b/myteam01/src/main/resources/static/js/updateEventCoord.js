/**
 * 
 */

var geocoder ;
var list = [];
var data ;
function selectEhost(){
	$.ajax({
		type: "get",
		url: "/eventRest/ehost",
		success: function(hostList) {
            console.log(hostList); // result = ehost List
            for (var i = 0; i < hostList.length; i++) {
                (function(i) {
                    geocoder = new kakao.maps.services.Geocoder();
                    geocoder.addressSearch(hostList[i], function(result, status) { // result = x,y
                        if (status === kakao.maps.services.Status.OK) {
                            //console.log(hostList[i] + " y좌표: " + result[0].y + " x좌표: " + result[0].x);
                       		//list.push({"ehost": hostList[i], "excoord": result[0].x, "eycoord": result[0].y});
							data = {"ehost": hostList[i], "excoord": result[0].x, "eycoord": result[0].y} ;
							updateEventCoord(data);
                        }
                    });
                })(i);
            }//for end
           
        } // success end
	});
};

function updateEventCoord(dagta){
	console.log("updateEventCoord data: ", data);
    $.ajax({
        type: "POST",
        url: "/eventRest/updateEventCoord",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(result){
            console.log("Success: ", result)
            console.log(JSON.stringify(data));
        },
        error: function(xhr, status, error) {
            console.error("Error: " + error);
        }
    });//ajax end
}
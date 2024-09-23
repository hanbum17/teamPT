/**
 * 
 */

$("#selectUserList").on("click", function(e){
	e.preventDefault();
	
	$.ajax({
		type: "get",
		url: "/admin/manage/userList",
		success: function(result){
			console.log(result);
		}
	});
});
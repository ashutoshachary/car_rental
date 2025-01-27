<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.text.ParseException" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.Calendar" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="assets\css\login.css">
<title>Car Book Website</title>
</head>
<body>
	<div class = "center" style = "width: 60%;">
	<h1>Booking Successful</h1>
	<div style = "padding: 40px; color: rgb(70, 70, 70);">
		
		<div style = "float: left">
		ID <br>
		Name <br>
		E-Mail <br>
		Phone No <br><br>
		Car No <br>
		Date of Booking <br>
		Location <br>
		Duration <br>
		Price <br>
		Cancel WithIn <br>
		</div>
		
		<div style = "color: black; font-weight: bold; transform: translate(10%)">
<%
	try{
		String url = "jdbc:mysql://localhost:3306/car_rental";
		String uname = "root";
		String passwd = "ashutosh16";
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, uname, passwd);
		
		PreparedStatement statement = conn.prepareStatement("select * from booking order by id  desc limit 1");
		
		ResultSet result = statement.executeQuery();
		result.next();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String newDateString = null;
        String bookingDateString = result.getString(9);
        String pickupDateString = result.getString(3);

        Date bookingDate = dateFormat.parse(bookingDateString);
        Date pickupDate = dateFormat.parse(pickupDateString);

        long timeDifferenceInMillis = pickupDate.getTime() - bookingDate.getTime();
        long daysDifference = timeDifferenceInMillis / (24 * 60 * 60 * 1000);
        if(daysDifference >= 30 && daysDifference < 60){
        	String originalDateString = result.getString(9);

            Date originalDate = dateFormat.parse(originalDateString);

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(originalDate);

            calendar.add(Calendar.DAY_OF_MONTH, 7);

            Date newDate = calendar.getTime();
            newDateString = dateFormat.format(newDate);
        }
        else if(daysDifference >= 60 && daysDifference < 180){
        	String originalDateString = result.getString(9);

            Date originalDate = dateFormat.parse(originalDateString);

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(originalDate);

            calendar.add(Calendar.DAY_OF_MONTH, 15);

            Date newDate = calendar.getTime();
            newDateString = dateFormat.format(newDate);
        }
		else if(daysDifference >= 180 && daysDifference < 365){
			String originalDateString = result.getString(9);

            Date originalDate = dateFormat.parse(originalDateString);

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(originalDate);

            calendar.add(Calendar.DAY_OF_MONTH, 60);

            Date newDate = calendar.getTime();
            newDateString = dateFormat.format(newDate);
		        }
		else if(daysDifference >= 365){
			String originalDateString = result.getString(9);

            Date originalDate = dateFormat.parse(originalDateString);

            Calendar calendar = Calendar.getInstance();
            calendar.setTime(originalDate);

            calendar.add(Calendar.DAY_OF_MONTH, 180);

            Date newDate = calendar.getTime();
            newDateString = dateFormat.format(newDate);
		}else{
			newDateString = result.getString(3);
		}
        System.out.println("The difference between booking and pickup dates is: " + daysDifference + " days");
		out.println("<em>"+ result.getString(10)+
		"<br>"+ result.getString(5) +
		"<br>" + result.getString(6) +
		"<br>" + result.getString(7) +
		"<br><br>" + result.getString(8) +
		"<br>" + result.getString(9) +
		"<br>" + result.getString(1) +
		"<br>" + result.getString(3) + " to " + result.getString(4) +
		"<br>" + result.getString(11) +
		"<br>" + newDateString +
		"<br><br></em>");
	}
	catch(SQLException e){
		out.println("Unexpected Error");
	}
%>
		</div>
		
		<form>
		<br>
		<table style = "width: 100%; table-layout: fixed;">
			<tr>
				<style>
					#cancelButton{
						width: 100%;
						height: 50px;
						border: 1px solid;
						background: #f94545;
						border-radius: 25px;
						font-size: 18px;
						color: #e9f4fb;
						font-weight: 700;
						cursor: pointer;
						outline: none;
					}
					
					#cancelButton:hover{
						border-color: #b23737;
						transition: .5s;
					}
					
					#messageBox{
						width: 400px;
						height: 100px;
						background: white;
						color: #f94545;
						padding: 20px;
						margin-left: auto;
						margin-right: auto;
						text-align: center;
						border: 1px solid #aaaaaa;
						display: none;
					}
					#content{
						float: left;
						padding: 2px;
						border-radius: 50%;
						background: #f94545;
					}
					#inside{
						float: left;
						width: 45px;
						height: 45px;
						border-radius: 50%;
						background: white;
						text-align: center;
						font-size: 32px;
					}
				</style>
				<td><button type = "button" id = "cancelButton" onclick = "dialogBox()">Cancel Booking</button></td>
				<td><input type = "submit" value = "Home" formaction = "index.jsp"/></td>

			</tr>
		</table>
		</form>
	</div>
	</div>
	
	<div class ="center" id = "messageBox">
			<div id = "content">
				<div id = "inside">!</div>
				</div>
			&nbsp; Your booking has been canceled(remember your ID to it may be required for canceling the order).
			<button type = "button" id = "cancelButton" style = "width: 150px;float: right" onclick = "location.href = 'cancel.jsp';">Continue</button>
	</div>
	<script>
		function dialogBox(){
			document.getElementById("messageBox").style.display = "block";
		}
	</script>
</body>
</html>
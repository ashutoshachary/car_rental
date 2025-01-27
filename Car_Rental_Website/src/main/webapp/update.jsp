<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.time.format.DateTimeFormatter" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ page import = "java.time.LocalDate" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.util.List" %>
<% 
if (session.getAttribute("AccEmail") == null) {
    response.sendRedirect("login.jsp");
} else {
    
}
%>
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<%
	try{
		String url = "jdbc:mysql://localhost:3306/car_rental";
		String uname = "root";
		String passwd = "ashutosh16";
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, uname, passwd);
		
		String pickUpLoc = request.getParameter("pickup");
		String returnLoc = request.getParameter("return");
		String pickUpDate = request.getParameter("pickupdate");
		String returnDate = request.getParameter("returndate");
		String name = request.getParameter("name");
		String car_price = request.getParameter("car_price");
		String num_days = request.getParameter("num_days");
		System.out.println(car_price);
		System.out.println(num_days);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate p_dat = LocalDate.parse(pickUpDate, formatter);
        LocalDate r_dat = LocalDate.parse(returnDate, formatter);
        long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(p_dat, r_dat);
        int floorDays = (int) Math.floor(daysBetween);
		double carPrice = Double.parseDouble(car_price);
	    double numDays = Double.parseDouble(num_days);
	    boolean isPastDate3;
	    double pr2;
	    double result = 0.0;
	    String stringValue1;
	    isPastDate3 = r_dat.isBefore(p_dat);
	    
		String id = request.getParameter("id");
		
		if(isPastDate3 != true){
			if (numDays > 0) {
		        result = carPrice / numDays;
		        //System.out.println("Result of car_price / num_days: " + result);
		    } else if (numDays == 0) {
		    	result = carPrice / 1;
		    }
			
			if( floorDays <= 0){
	        	pr2 = 1*result;
	        	stringValue1 = String.valueOf(pr2);
	        }
	        else{
	        	pr2 = result*floorDays;
	        	stringValue1 = String.valueOf(pr2);
	        }
		
			PreparedStatement statement = conn.prepareStatement("update booking set pickup_loc = ?, return_loc = ?, pickup_date = ?, return_date = ?, name = ? ,price = ? where id = ?");
		
			statement.setString(1, pickUpLoc);
			statement.setString(2, returnLoc);
			statement.setString(3, pickUpDate);
			statement.setString(4, returnDate);
			statement.setString(5, name);
			statement.setString(6, stringValue1);
			statement.setString(7, id);
			
			int flag = statement.executeUpdate();
			if(flag > 0){
				response.sendRedirect("account.jsp");
			}
			else{
				out.println("<br>booking failed<br>");
			}
		}else{
			out.println("<div class=\"container-fluid center-div\">");
		    out.println("    <div class=\"jumbotron text-center\">");
		    out.println("        <h1 class=\"display-4\">Update Failed!</h1>");
		    out.println("        <p class=\"lead\">Due to wrong Time format.</p>");
			out.println("        <button type=\"button\" class=\"btn btn-primary mt-3  justify-content-center align-items-center\" onclick=\"redirectToBookingPage()\"> Return To Booking</button>");
			out.println("    </div>");
			out.println("</div>");
			out.println("<script>");
			out.println("    function redirectToBookingPage() {");
			out.println("        window.location.href = 'editpage.jsp';");
			out.println("    }");
			out.println("</script>");
		}
		
	}
	catch(SQLException e){
		out.println(e);
	}
		
%>
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
		String id = request.getParameter("carId1");
		String numbers = request.getParameter("availableCars1");
		if(id != null){
		PreparedStatement statement = conn.prepareStatement("update car_inventory set  available_cars = ? where car_id = ?");
		statement.setString(1, numbers);
		statement.setString(2, id);
		
		int flag = statement.executeUpdate();
		if(flag > 0){
			response.sendRedirect("admin.jsp#inv");
		}
		else{
			out.println("<br>No Id<br>");
			response.sendRedirect("admin.jsp#inv");
		}
		}else{
			out.println("<div class=\"container-fluid center-div\">");
		    out.println("    <div class=\"jumbotron text-center\">");
		    out.println("        <h1 class=\"display-4\">Update Failed!</h1>");
		    out.println("        <p class=\"lead\">No id Available.</p>");
			out.println("        <button type=\"button\" class=\"btn btn-primary mt-3  justify-content-center align-items-center\" onclick=\"redirectToBookingPage()\"> Return To Booking</button>");
			out.println("    </div>");
			out.println("</div>");
			out.println("<script>");
			out.println("    function redirectToBookingPage() {");
			out.println("        window.location.href = 'admin.jsp#inv';");
			out.println("    }");
			out.println("</script>");
		}
	}catch(Exception e){
		System.out.println(e);
		
	}
%>
>
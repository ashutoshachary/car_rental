<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.time.format.DateTimeFormatter" %>
<%@ page import = "java.time.LocalDate" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.util.List" %>
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<%
//boolean isDateInPast(LocalDate inputDate, LocalDate referenceDate) {
//    return inputDate.isBefore(referenceDate);
//}
	try{
		String url = "jdbc:mysql://localhost:3306/car_rental";
		String uname = "root";
		String passwd = "ashutosh16";
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, uname, passwd);
		String x = (String)session.getAttribute("AccEmail");
		String pickUpLoc = request.getParameter("pickup");
		String returnLoc = request.getParameter("return");
		String pickUpDate = request.getParameter("pickupdate");
		String returnDate = request.getParameter("returndate");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phoneNo = request.getParameter("phone");
		String carName = request.getParameter("car_name");
		String price = request.getParameter("car_price");
		String car_id = request.getParameter("car_id");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate p_dat = LocalDate.parse(pickUpDate, formatter);
        LocalDate r_dat = LocalDate.parse(returnDate, formatter);
        LocalDate today = LocalDate.now();
        boolean isPastDate1;
        boolean isPastDate2;
        boolean isPastDate3;
        long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(p_dat, r_dat);
        int floorDays = (int) Math.floor(daysBetween);
        int pr2;
        String stringValue1;
        isPastDate1 = p_dat.isBefore(today);
        isPastDate2 = r_dat.isBefore(today);
        isPastDate3 = r_dat.isBefore(p_dat);
        System.out.print(car_id);
        if( floorDays <= 0){
        	int number = Integer.parseInt(price);
        	pr2 = 1*number;
        	stringValue1 = String.valueOf(pr2);
        }
        else{
        	int number = Integer.parseInt(price);
        	pr2 = number*floorDays;
        	stringValue1 = String.valueOf(pr2);
        }
        System.out.println(isPastDate1);
        System.out.println(isPastDate2);
        
		if(phoneNo != null && isPastDate1 != true && isPastDate2 != true && isPastDate3 != true && x.equals(email)){
		
			PreparedStatement statement = conn.prepareStatement("insert into booking(pickup_loc, return_loc, pickup_date, return_date, name, email, phone_no, car, price) values(?, ?, ?, ?, ?, ?, ?, ?, ?)");
		
			statement.setString(1, pickUpLoc);
			statement.setString(2, returnLoc);
			statement.setString(3, pickUpDate);
			statement.setString(4, returnDate);
			statement.setString(5, name);
			statement.setString(6, email);
			statement.setLong(7, Long.parseLong(phoneNo));
			statement.setString(8, carName);
			statement.setString(9, stringValue1);
			
			int flag = statement.executeUpdate();
			if(flag > 0){
				response.sendRedirect("booked.jsp");
			}
			else{
				System.out.println("Booking Failed");
			}
			String updateQuery = "UPDATE car_inventory SET available_cars = available_cars - 1 WHERE car_id = ?";
	        PreparedStatement preparedStatement = conn.prepareStatement(updateQuery);
	        preparedStatement.setInt(1, Integer.parseInt(car_id));
	        preparedStatement.executeUpdate();

	           
	        
		}else{
			out.println("<div class=\"container-fluid center-div\">");
		    out.println("    <div class=\"jumbotron text-center\">");
		    out.println("        <h1 class=\"display-4\">Booking Failed !</h1>");
		    out.println("        <p class=\"lead\">Due to wrong Time format.</p>");
		    out.println("        <p class=\"lead\">Or due to Wrong E-mail.</p>");
			out.println("        <button type=\"button\" class=\"btn btn-primary mt-3  justify-content-center align-items-center\" onclick=\"redirectToBookingPage()\"> Return To Booking</button>");
			out.println("    </div>");
			out.println("</div>");
			out.println("<script>");
			out.println("    function redirectToBookingPage() {");
			out.println("        window.location.href = 'fleet.jsp#car_serv';");
			out.println("    }");
			out.println("</script>");
		}
	}
	catch(SQLException e){
		out.println(e);
	}
		
%>
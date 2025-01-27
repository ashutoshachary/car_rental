<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.time.format.DateTimeFormatter" %>
<%@ page import = "java.time.LocalDate" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.util.List" %>
<% 
if (session.getAttribute("AccEmail") == null) {
    response.sendRedirect("login.jsp");
} else {
    
}
%>
     
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">

    <title>Admin</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/owl.css">
<style>
        .kkk {
            max-width: 400px;
            margin: auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }
        .form-container {
            max-width: 400px;
            margin: auto;
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-container h2 {
            background-color: #007bff;
            color: #ffffff;
            padding: 10px;
            border-radius: 5px;
        }
        .table123{
        margin-top:100px;
        }
    </style>

</head>
<body>
<div id="preloader">
        <div class="jumper">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>  
   
    <div class="sub-header">
      <div class="container">
        <div class="row">
          <div class="col-md-8 col-xs-12">
            <ul class="left-info">
              <li><a href="#"><i class="fa fa-envelope"></i>bookcar@company.com</a></li>
              <li><a href="#"><i class="fa fa-phone"></i>123-456-7890</a></li>
            </ul>
          </div>
          <div class="col-md-4">
            <ul class="right-icons">
              <li><a href="#"><i class="fa fa-facebook"></i></a></li>
              <li><a href="#"><i class="fa fa-twitter"></i></a></li>
              <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    
    <header class="bg-secondary rounded shadow">
      <nav class="navbar navbar-expand-lg">
        <div class="container">
          <a class="navbar-brand" href="index.jsp"><h2>Car Book<em>.com</em></h2></a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
              <li class="nav-item">
                <a class="nav-link" href="index.jsp">Home
                  <span class="sr-only">(current)</span>
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="fleet.jsp#car_serv">Book Now</a>
              </li>
              <li class="nav-item dropdown">
                <a class="dropdown-toggle nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">About</a>
              
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="about.jsp">About Us</a>
                    <a class="dropdown-item" href="team.jsp">Team</a>
                    <a class="dropdown-item" href="faq.jsp">FAQ</a>
                    <a class="dropdown-item" href="terms.jsp">Terms</a>
                </div>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="contact.jsp">Contact Us</a>
              </li>
              <li class="nav-item dropdown">
                <a class="dropdown-toggle nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Account</a>
                <%if(session.getAttribute("AccEmail").equals("admin@gmail.com")){ %>
                 <div class="dropdown-menu mb-2">
                    <a class="dropdown-item text-center" href="admin.jsp" style = "color: blue">Admin</a>
                    <a class="dropdown-item text-center" href="admin.jsp#u_inv" style = "color: blue">Update Inventory</a>
                    <a class="dropdown-item text-center" href="admin.jsp#d_msg" style = "color: blue">Delete Message</a>
                    <a class="dropdown-item text-center" href="admin.jsp#c_book" style = "color: blue">Cancel Booking</a>
                    <a class="dropdown-item text-center" href="admin.jsp#t_user" style = "color: blue">See The Users</a>
                    <a class="dropdown-item text-center" href="logout.jsp" style = "color: red">Logout</a>
                </div>
                <% }%>
                <div class="dropdown-menu mb-2">
                    <a class="dropdown-item text-center" href="logout.jsp" style = "color: red">Logout</a>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </header>
     
<%
try{
	String url = "jdbc:mysql://localhost:3306/car_rental";
	String uname = "root";
	String passwd = "ashutosh16";
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(url, uname, passwd);
	PreparedStatement statement = conn.prepareStatement("select * from car_inventory");
	ResultSet result = statement.executeQuery();
	out.println("<div class='table-responsive table123 rounded shadow' id='inv' >");
    out.println("<table class='table table-bordered text-center'>");
    out.println("<thead class='thead-dark'>");
    out.println("<tr>");
    out.println("<th>Car ID</th>");
    out.println("<th>Car Name</th>");
    out.println("<th>Total Number of cars</th>");
    out.println("<th>Available Cars</th>");
    out.println("</tr>");
    out.println("</thead>");
    out.println("<tbody>");

    while (result.next()) {
        out.println("<tr text-center>");
        out.println("<td >" + result.getString(1) + "</td>");
        out.println("<td>" + result.getString(4) + "</td>");
        out.println("<td>" + result.getString(2) + "</td>");
        out.println("<td>" + result.getString(3) + "</td>");
        
        out.println("</tr>");
    }

    out.println("</tbody>");
    out.println("</table>");
    out.println("</div>");
}catch(Exception e){
	System.out.println(e);
}
%>

<div class="container my-3 border rounded bg-secondary">
    <h2 class="text-center text-white mb-4 " id="u_inv">Update Car Inventory</h2>

    <div class="row mb-2">
        <div class="col-md-6 my-1">
            <form action="update_avil.jsp" method="post" class="border rounded bg-light p-3">
                <div class="form-group">
                    <label for="carId1">Car ID:</label>
                    <input type="text" class="form-control" id="carId1" name="carId1" required>
                </div>
                
                <div class="form-group">
                    <label for="availableCars1">Available Cars :</label>
                    <input type="number" class="form-control" id="availableCars1" name="availableCars1" required>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Update Available Cars</button>
                </div>
            </form>
        </div>

        <div class="col-md-6 my-1">
            <form action="update_total.jsp" method="post" class="border rounded bg-light p-3">
                <div class="form-group">
                    <label for="carId2">Car ID:</label>
                    <input type="text" class="form-control" id="carId2" name="carId2" required>
                </div>
                <div class="form-group">
                    <label for="totalCars2">Total Number of cars:</label>
                    <input type="number" class="form-control" id="totalCars2" name="totalCars2" required>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary">Update Total Cars</button>
                </div>
            </form>
        </div>
    </div>
</div>
<h2 class="text-center text-white rounded bg-secondary ">Bookings</h2>
<%
try{
	String url = "jdbc:mysql://localhost:3306/car_rental";
	String uname = "root";
	String passwd = "ashutosh16";
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn1 = DriverManager.getConnection(url, uname, passwd);
	PreparedStatement statement1 = conn1.prepareStatement("select * from booking");
	ResultSet result1 = statement1.executeQuery();
	out.println("<div class='table-responsive mt-3 rounded shadow' id='t_booking'>");
    out.println("<table class='table table-bordered text-center'>");
    out.println("<thead class='thead-dark'>");
    out.println("<tr>");
    out.println("<th>Booking ID</th>");
    out.println("<th>Car Name</th>");
    out.println("<th>Persion E-Mail</th>");
    out.println("<th>Persion Number</th>");
    out.println("<th>Persion Name</th>");
    out.println("<th>Pick-up Location</th>");
    out.println("<th>Return Location</th>");
    out.println("<th>Pick-up Date</th>");
    out.println("<th>Return Date</th>");
    out.println("<th>Date</th>");
    out.println("<th>Price</th>");
    out.println("</tr>");
    out.println("</thead>");
    out.println("<tbody>");

    while (result1.next()) {
        out.println("<tr text-center>");
        out.println("<td >" + result1.getString(10) + "</td>");
        out.println("<td>" + result1.getString(5) + "</td>");
        out.println("<td>" + result1.getString(7) + "</td>");
        out.println("<td>" + result1.getString(8) + "</td>");
        out.println("<td >" + result1.getString(6) + "</td>");
        out.println("<td>" + result1.getString(1) + "</td>");
        out.println("<td>" + result1.getString(2) + "</td>");
        out.println("<td>" + result1.getString(3) + "</td>");
        out.println("<td >" + result1.getString(4) + "</td>");
        out.println("<td>" + result1.getString(9) + "</td>");
        out.println("<td>" + result1.getString(11) + "</td>");
        
        
        out.println("</tr>");
    }

    out.println("</tbody>");
    out.println("</table>");
    out.println("</div>");
}catch(Exception e){
	System.out.println(e);
}
%>
<div class="container my-3 " id="c_book">
    <div class="form-container kkk">
        <h2 class="text-center mb-4">Cancel Booking</h2>

        <form action="cancel_booking.jsp" method="post">
            <div class="form-group">
                <label for="bookingId">Enter Booking ID:</label>
                <input type="text" class="form-control" id="bookingId" name="bookingId" required>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-danger">Cancel</button>
            </div>
        </form>
    </div>
</div>
<h2 class="text-center text-white rounded bg-secondary ">Users</h2>
<%
try{
	String url = "jdbc:mysql://localhost:3306/car_rental";
	String uname = "root";
	String passwd = "ashutosh16";
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn2 = DriverManager.getConnection(url, uname, passwd);
	PreparedStatement statement2 = conn2.prepareStatement("select * from login");
	ResultSet result2 = statement2.executeQuery();
	out.println("<div class='table-responsive mt-3 rounded shadow' id='t_user'>");
    out.println("<table class='table table-bordered text-center'>");
    out.println("<thead class='thead-dark'>");
    out.println("<tr>");
    out.println("<th>Persion Name</th>");
    out.println("<th>Persion E-Mail</th>");
    out.println("<th>Persion Address</th>");
    
    out.println("</tr>");
    out.println("</thead>");
    out.println("<tbody>");

    while (result2.next()) {
        out.println("<tr text-center>");
        out.println("<td >" + result2.getString(1) + "</td>");
        out.println("<td>" + result2.getString(2) + "</td>");
        out.println("<td>" + result2.getString(4) + "</td>");  
        out.println("</tr>");
    }

    out.println("</tbody>");
    out.println("</table>");
    out.println("</div>");
}catch(Exception e){
	System.out.println(e);
}
%>
<h2 class="text-center text-white rounded bg-secondary ">Messages</h2>
<%
try{
	String url = "jdbc:mysql://localhost:3306/car_rental";
	String uname = "root";
	String passwd = "ashutosh16";
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn3 = DriverManager.getConnection(url, uname, passwd);
	PreparedStatement statement3 = conn3.prepareStatement("select * from contact_messages");
	ResultSet result3 = statement3.executeQuery();
	out.println("<div class='table-responsive mt-3 rounded shadow' id='msg' >");
    out.println("<table class='table table-bordered text-center'>");
    out.println("<thead class='thead-dark'>");
    out.println("<tr>");
    out.println("<th>Message Id</th>");
    out.println("<th>Persion Name</th>");
    out.println("<th>Persion E-Mail</th>");
    out.println("<th>Topic</th>");
    
    out.println("<th>Message</th>");
    out.println("<th>Submission Time</th>");
    
    out.println("</tr>");
    out.println("</thead>");
    out.println("<tbody>");

    while (result3.next()) {
        out.println("<tr text-center>");
        out.println("<td >" + result3.getString(1) + "</td>");
        out.println("<td>" + result3.getString(2) + "</td>");
        out.println("<td>" + result3.getString(3) + "</td>"); 
        out.println("<td >" + result3.getString(4) + "</td>");
        out.println("<td>" + result3.getString(5) + "</td>");
        out.println("<td>" + result3.getString(6) + "</td>"); 
        out.println("</tr>");
    }

    out.println("</tbody>");
    out.println("</table>");
    out.println("</div>");
}catch(Exception e){
	System.out.println(e);
}
%>
<div class="container my-3 " id="d_msg">
    <div class="form-container kkk">
        <h2 class="text-center mb-4">Delete Message</h2>

        <form action="delete_message.jsp" method="post">
            <div class="form-group">
                <label for="messageId">Enter Message ID:</label>
                <input type="text" class="form-control" id="messageId" name="messageId" required>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-danger">Delete Message</button>
            </div>
        </form>
    </div>
</div>
<footer>
      <div class="container">
        <div class="row">
          <div class="col-md-3 footer-item">
            <h4>CarBook.com</h4>
            <p>With flexible rental options and a wide network that's visible across most cities in India, renting from carBook.com has become the preferred choice for most BBSR locals.</p>
            <ul class="social-icons">
              <li><a rel="nofollow" href="#" target="_blank"><i class="fa fa-facebook"></i></a></li>
              <li><a href="#"><i class="fa fa-twitter"></i></a></li>
              <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
            </ul>
          </div>
          <div class="col-md-3 footer-item">
            <h4>Made By</h4>
            <ul class="menu-list">
              <li><a href="team.jsp">Ashutosh Acharya</a></li>
              <li><a href="team.jsp">Pritam Nanda</a></li>
            </ul>
          </div>
          <div class="col-md-3 footer-item">
            <h4>Additional Pages</h4>
            <ul class="menu-list">
              <li><a href="about.jsp">About Us</a></li>
              <li><a href="faq.jsp">FAQ</a></li>
              <li><a href="contact.jsp">Contact Us</a></li>
              <li><a href="terms.jsp">Terms</a></li>
            </ul>
          </div>
          <div class="col-md-3 footer-item last-item">
            <h4>Contact Us</h4>
            <div class="contact-form">
              <form id="contact footer-contact" action="feedback" method="post">
                <div class="row">
                  <div class="col-lg-12 col-md-12 col-sm-12">
                    <fieldset>
                      <input name="name" type="text" class="form-control" id="name" placeholder="Full Name" required="">
                    </fieldset>
                  </div>
                  <div class="col-lg-12 col-md-12 col-sm-12">
                    <fieldset>
                      <input name="email" type="text" class="form-control" id="email" pattern="[^ @]*@[^ @]*" placeholder="E-Mail Address" required="">
                    </fieldset>
                  </div>
                  <div class="col-lg-12 col-md-12 col-sm-12">
                    <fieldset>
                      <input name="subject" type="text" class="form-control" id="subject" placeholder="Subject" >
                    </fieldset>
                  </div>
                  <div class="col-lg-12">
                    <fieldset>
                      <textarea name="message" rows="6" class="form-control" id="message" placeholder="Your Message" required=""></textarea>
                    </fieldset>
                  </div>
                  <div class="col-lg-12">
                    <fieldset>
                      <button type="submit" id="form-submit" class="filled-button">Send Message</button>
                    </fieldset>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </footer>
     <div class="sub-footer">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <p>
                Copyright © 2023<br> Pritam Nanda / Ashutosh Acharya
            </p>
          </div>
        </div>
      </div>
    </div>
    <script src="vendor/jquery/jquery.min.js">
    </script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Additional Scripts -->
    <script src="assets/js/custom.js"></script>
    <script src="assets/js/owl.js"></script>
    <script src="assets/js/slick.js"></script>
    <script src="assets/js/accordions.js"></script>

    <script language = "text/Javascript"> 
      cleared[0] = cleared[1] = cleared[2] = 0; //set a cleared flag for each field
      function clearField(t){                   //declaring the array outside of the
      if(! cleared[t.id]){                      // function makes it static and global
          cleared[t.id] = 1;  // you could use true and false, but that's more typing
          t.value='';         // with more chance of typos
          t.style.color='#fff';
          }
      }

     

    </script>
</body>
</html>
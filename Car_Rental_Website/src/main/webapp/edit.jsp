<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.util.List" %>
<%@ page import = "java.time.format.DateTimeFormatter" %>
<%@ page import = "java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/owl.css">
<title>Insert title here</title>
</head>
<body>
<% 
		String url = "jdbc:mysql://localhost:3306/car_rental";
		String uname = "root";
		String passwd = "ashutosh16";
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, uname, passwd);
		
		String id = request.getParameter("bookingID");
        String x = (String)session.getAttribute("AccEmail");
        //System.out.println(x);
		PreparedStatement statement = conn.prepareStatement("select * from booking where id = ? ");
		statement.setString(1, id);
		ResultSet result = statement.executeQuery();
		
		if(result.next()){
		//System.out.println(result.getString(7));
		//System.out.println(String.valueOf(x) == String.valueOf(result.getString(7)));
		if (x.equals(result.getString(7))  ){
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String p_dat1 = result.getString(3);
			String r_dat1 = result.getString(4);
			LocalDate p_dat = LocalDate.parse(p_dat1, formatter);
	        LocalDate r_dat = LocalDate.parse(r_dat1, formatter);
	        long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(p_dat, r_dat);
	        int floorDays = (int) Math.floor(daysBetween);
		out.println("Booking ID :::: " + result.getString(10));
		
%>


        <form action = "update.jsp" method="post">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Edit</h5>
            <button type="button" class="close" data-dismiss="modal" onclick = "location.href = 'account.jsp'" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              
                  <div class="row">
                   <div class="col-md-6">
                    <div class="form-group">
                     
                        <input type="text" class="form-control" placeholder="Pick-up location" value ="<%= result.getString(1) %>" name="pickup" required>
                     
                    </div>
                   </div>

                   <div class="col-md-6">
                    <div class="form-group">
                      
                        <input type="text" class="form-control" placeholder="Return location" value ="<%= result.getString(2) %>" name="return" required>
                     
                    </div>
                   </div>
                  </div>

                  <div class="row">
                   <div class="col-md-6">
                    <div class="form-group">
                      
                        <input type="date" class="form-control" placeholder="Pick-up date" value ="<%= result.getString(3) %>" name="pickupdate" id="pickupdate" required>
                      
                    </div>
                   </div>

                   <div class="col-md-6">
                    <div class="form-group">
                     
                        <input type="date" class="form-control" placeholder="Return date" value ="<%= result.getString(4) %>" name="returndate" id="returndate" required>
                     
                    </div>
                   </div>
                  </div>

                  <div class="form-group">
                    
                      <input type="text" class="form-control" placeholder="Enter full name" name="name" value ="<%= result.getString(6) %>" oninput="this.value = this.value.replace(/[^A-z ]/g, '').replace(/(\..*)\./g, '$1');" required>
                    
                  </div>

                  <div class="row">
                   <div class="col-md-6">
                    <div class="form-group">
                      
                        <input type="text" class="form-control" placeholder="Enter email address" value ="<%= result.getString(7) %>" name="email" readonly>
                      
                    </div>
                   </div>

                   <div class="col-md-6">
                    <div class="form-group">
                      
                        <input type="text" class="form-control" placeholder="Enter phone" value ="<%= result.getString(8) %>" name="phone" id = "myText" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" readonly>
                      
                    </div>
                   </div>
                  </div>
                  
              
          </div>
          <div class="modal-footer">
          	<div>
          	<input type="hidden" class="form-control" value ="<%= floorDays  %>" name="num_days" id="num_days">
          	<input type="hidden" class="form-control" value ="<%= result.getString(11) %>" name="car_price" id="car_price">
        	  	 <input type="hidden" class="form-control" value ="<%= result.getString(5) %>" name="car_name" id="car_name">
        	  	 <input type="hidden" class="form-control" value ="<%= result.getString(10) %>" name="id" id="booking_id">
          	</div>
            <input type = "submit" class="btn btn-primary" value = "Update"/>
          </div>
          
        </form>
        <%}else{%>
        	<div class="container-fluid center-div">
            <div class="jumbotron text-center">
                <h1 class="display-4">No Booking in this ID</h1>
                <p class="lead">Please check the ID and try again.</p>
            </div>
        </div><% 
        }}else{
        	%>
        	<div class="container-fluid center-div">
            <div class="jumbotron text-center">
                <h1 class="display-4">No Booking in this ID</h1>
                <p class="lead">Please check the ID and try again.</p>
            </div>
        </div><%
        } %>

<div class="sub-footer fixed-bottom">
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


    <!-- Bootstrap core JavaScript -->
    <script>
    var currentDate = new Date();
    var nextYearDate = new Date();
    nextYearDate.setFullYear(currentDate.getFullYear() + 1);

    // Ensure past days are not shown
    nextYearDate.setHours(0, 0, 0, 0);

    // Format the date to YYYY-MM-DD (required by the date input)
    var formattedNextYearDate = nextYearDate.toISOString().split('T')[0];

    // Set the minimum allowed date for the input fields (today)
    var formattedCurrentDate = currentDate.toISOString().split('T')[0];
    document.getElementById('returndate').setAttribute('min', formattedCurrentDate);
    document.getElementById('pickupdate').setAttribute('min', formattedCurrentDate);

    // Set the maximum allowed date for the input fields (next year)
    document.getElementById('returndate').setAttribute('max', formattedNextYearDate);
    document.getElementById('pickupdate').setAttribute('max', formattedNextYearDate);
    </script>
    <script src="vendor/jquery/jquery.min.js"></script>
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
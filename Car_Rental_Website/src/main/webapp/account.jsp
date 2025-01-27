<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
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

    <title>Car Book Website</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/owl.css">
  </head>

  <body>

    <!-- ***** Preloader Start ***** -->
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
    
    <header class="">
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

    <!-- Page Content -->
    <div class="page-heading header-text">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <h1><% out.println(session.getAttribute("AccName"));%></h1>
            <h4><% out.println(session.getAttribute("AccEmail"));%></h4>
            <span></span>
          </div>
        </div>
      </div>
    </div>
    
    <div style = "padding : 5px;" class="d-flex justify-content-center">
    <input type = "button" onclick = "location.href = 'editpage.jsp'" class="btn btn-primary m-3" value = "Edit Booking"/>
    <input type = "button" onclick = "location.href = 'cancel.jsp'"  class="btn btn-danger m-3" value = "Cancel Booking"/>
    </div>
    
    <!-- Account Contents -->
   <div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="section-heading">
                <h2>Booking <em>History</em></h2>
                <br>
                <style>
                    table {
                        width: 100%;
                        margin-top: 20px;
                    }

                    table,
                    th,
                    td {
                        border: 1px solid black;
                    }
                </style>
                <%
                    try {
                        String url = "jdbc:mysql://localhost:3306/car_rental";
                        String uname = "root";
                        String passwd = "ashutosh16";
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, uname, passwd);

                        String email = (String) session.getAttribute("AccEmail");

                        PreparedStatement statement = conn
                                .prepareStatement("select * from booking where email = ? order by id desc");
                        statement.setString(1, email);

                        ResultSet result = statement.executeQuery();

                        // table coding
                        out.println("<div class='table-responsive'>");
                        out.println("<table class='table table-bordered'>");
                        out.println("<thead class='thead-dark'>");
                        out.println("<tr>");
                        out.println("<th>Booking ID</th>");
                        out.println("<th>Date</th>");
                        out.println("<th>Pick-Up Location</th>");
                        out.println("<th>Return Location</th>");
                        out.println("<th>Duration</th>");
                        out.println("<th>Car Name</th>");
                        out.println("<th>Email</th>");
                        out.println("<th>Phone No</th>");
                        out.println("<th>Price</th>");
                        out.println("</tr>");
                        out.println("</thead>");
                        out.println("<tbody>");

                        while (result.next()) {
                            out.println("<tr>");
                            out.println("<td>" + result.getString(10) + "</td>");
                            out.println("<td>" + result.getString(9) + "</td>");
                            out.println("<td>" + result.getString(1) + "</td>");
                            out.println("<td>" + result.getString(2) + "</td>");
                            out.println("<td>" + result.getString(3) + " to " + result.getString(4) + "</td>");
                            out.println("<td>" + result.getString(5) + "</td>");
                            out.println("<td>" + result.getString(7) + "</td>");
                            out.println("<td>" + result.getLong(8) + "</td>");
                            out.println("<td>" + result.getLong(11) + "</td>");
                            out.println("</tr>");
                        }

                        out.println("</tbody>");
                        out.println("</table>");
                        out.println("</div>");

                    } catch (SQLException e) {
                        out.println(e);
                    }
                %>
            </div>
        </div>
    </div>
</div>

    
    
    <!-- Footer Starts Here -->
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
                      <input name="name" type="text" class="form-control" id="name" placeholder="Full Name" required>
                    </fieldset>
                  </div>
                  <div class="col-lg-12 col-md-12 col-sm-12">
                    <fieldset>
                      <input name="email" type="text" class="form-control" id="email" pattern="[^ @]*@[^ @]*" placeholder="E-Mail Address" required>
                    </fieldset>
                  </div>
                  <div class="col-lg-12 col-md-12 col-sm-12">
                    <fieldset>
                      <input name="subject" type="text" class="form-control" id="subject" placeholder="Subject" >
                    </fieldset>
                  </div>
                  <div class="col-lg-12">
                    <fieldset>
                      <textarea name="message" rows="6" class="form-control" id="message" placeholder="Your Message" required></textarea>
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


    <!-- Bootstrap core JavaScript -->
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
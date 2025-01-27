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
<%
 String url = "jdbc:mysql://localhost:3306/car_rental";
 String uname = "root";
 String passwd = "ashutosh16";

 try {
     Class.forName("com.mysql.cj.jdbc.Driver");
     try (Connection conn = DriverManager.getConnection(url, uname, passwd)) {
         String id = request.getParameter("bookingId");
         if (id != null) {
             String sql = "delete from booking where id=?";
             try (PreparedStatement statement = conn.prepareStatement(sql)) {
                 statement.setString(1, id);
                 

                 int flag = statement.executeUpdate();
                 if (flag > 0) {
                     response.sendRedirect("admin.jsp#t_booking");
                 } else {
                     response.sendRedirect("admin.jsp#t_booking");
                 }
             }
         }
     }
 } catch (ClassNotFoundException | SQLException e) {
     e.printStackTrace(); 
     response.sendRedirect("admin.jsp#t_booking");
 }
 
 %>>
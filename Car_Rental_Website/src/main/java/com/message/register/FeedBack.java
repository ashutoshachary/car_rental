package com.message.register;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FeedBack
 */
@WebServlet("/feedback")
public class FeedBack extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		PrintWriter out = response.getWriter();
//		out.print("Working");
		String uname = request.getParameter("name");
		String uemail = request.getParameter("email");
		String message = request.getParameter("message");
		String topic = request.getParameter("subject");

		RequestDispatcher dispatcher = null;
		Connection con = null;
		
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/car_rental","root","ashutosh16");
			PreparedStatement pst = con.prepareStatement("insert into contact_messages (name, email, topic, message) values(?,?,?,?)");
			pst.setString(1, uname);
			pst.setString(2, uemail);
			pst.setString(3, topic);
			pst.setString(4, message);
			
			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("index.jsp");
			
			dispatcher.forward(request, response);
			
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}

}

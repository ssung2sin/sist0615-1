package jdbc_sawon;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnect {
	
	//driver,url,����,��й�ȣ
	static final String ORACLE_URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	//driver
	String driver="oracle.jdbc.driver.OracleDriver";
	
	public DBConnect() {
		try {
			Class.forName(driver);
			System.out.println("����Ŭ ����̹� ����!!");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("����Ŭ ����̹� ����!!"+e.getMessage());
		}
	}
	public Connection getConnection() {
		Connection conn=null;
		try {
			conn = DriverManager.getConnection(ORACLE_URL, "ssung2sin", "a1234");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("����Ŭ ���� ����:url,����,��� Ȯ�ο��."+e.getMessage());
		}
		return conn;
	}
	
	public void dbClose(ResultSet rs,Statement stmt,Connection conn) {
		try {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void dbClose(Statement stmt,Connection conn) {
		try {
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void dbClose(ResultSet rs,PreparedStatement pstmt,Connection conn) {
		try {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void dbClose(PreparedStatement pstmt,Connection conn) {
		try {
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}

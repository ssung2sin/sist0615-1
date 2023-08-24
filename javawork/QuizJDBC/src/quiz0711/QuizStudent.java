package quiz0711;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class QuizStudent {
	
	DBConnect db = new DBConnect();
	Scanner sc=new Scanner(System.in);
	
	
	public void insertStudent() {
		Connection conn=db.getConnection();
		PreparedStatement pstmt = null;
		
		System.out.println("�Է��� �̸�?");
		String name=sc.nextLine();
		
		System.out.println("�Է��� �г�?");
		int grade=Integer.parseInt(sc.nextLine());
		
		System.out.println("�Է��� ����ȣ?");
		String hp=sc.nextLine();
		
		System.out.println("�Է��� �ּ�?");
		String addr=sc.nextLine();
		
		
		System.out.println("�Է��� ����?");
		int age=Integer.parseInt(sc.nextLine());
		
		String sql="insert into mystudent values(seq_stu.nextval,?,?,?,?,?,sysdate)";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, grade);
			pstmt.setString(3, hp);
			pstmt.setString(4, addr);
			pstmt.setInt(5, age);
			
			pstmt.execute();
			
			System.out.println("�Է¿Ϸ�.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	public void selectStudent() {
		Connection conn=db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		
		String sql="select * from mystudent order by stu_name";
		System.out.println("��ȣ\t�̸�\t�г�\t�޴�����ȣ\t\t�ּ�\t����\t���糯¥");
		System.out.println("======================================"
				+ "========================================");
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println(rs.getInt(1)+"\t"+rs.getString(2)
				+"\t"+rs.getInt(3)+"�г�\t"+rs.getString(4)
				+"\t"+rs.getString(5)+"\t"+rs.getInt(6)
				+"��\t"+rs.getString(7));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
	}
	
	public void deleteStudent() {
		System.out.println("������ ��ȣ?");
		int n = Integer.parseInt(sc.nextLine());
		
		String sql="delete from mystudent where stu_num="+n;
		
		Connection conn=db.getConnection();
		Statement stmt = null;
		
		try {
			stmt=conn.createStatement();
			int a=stmt.executeUpdate(sql);
			if(a==0) {
				System.out.println("��ȣ�� �߸� �Է��Ͽ����ϴ�.");
			}
			else if(a==1) {
				System.out.println("�����Ǿ����ϴ�.");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(stmt, conn);
		}
	}
	
	public void updateStudent() {
		System.out.println("������ ��ȣ?");
		int num=Integer.parseInt(sc.nextLine());
		if(!isDataStudent(num)) {
			System.out.println("��ȣ�� �߸� �Է��Ͽ����ϴ�.");
			return;
		}
		System.out.println("������ �̸�?");
		String name=sc.nextLine();
		
		System.out.println("������ �г�");
		int grade=Integer.parseInt(sc.nextLine());
		
		System.out.println("������ ����ȣ");
		String hp=sc.nextLine();
		
		System.out.println("������ �ּ�");
		String addr=sc.nextLine();
		
		System.out.println("������ ����?");
		int age=Integer.parseInt(sc.nextLine());
		
		String sql="update mystudent set stu_name=?,stu_grade=?,hp=?,addr=?,age=?"
				+ "where stu_num="+num;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, grade);
			pstmt.setString(3, hp);
			pstmt.setString(4, addr);
			pstmt.setInt(5, age);
			
			pstmt.execute();
			
			System.out.println("�����Ϸ�");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
		
	}
	
	public void searchStudent() {
		System.out.println("�˻��� �̸���(�Ϻ�)?");
		String name=sc.nextLine();
		
		String sql="select * from mystudent where stu_name like ?";
		
		System.out.println("��ȣ\t�̸�\t�г�\t�޴�����ȣ\t\t�ּ�\t����\t���糯¥");
		System.out.println("======================================"
				+ "========================================");
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt =null;
		ResultSet rs=null;
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, "%"+name+"%");
			rs=pstmt.executeQuery();
			
			
			while(rs.next()) {
				System.out.println(rs.getInt(1)+"\t"+rs.getString(2)
				+"\t"+rs.getInt(3)+"�г�\t"+rs.getString(4)
				+"\t"+rs.getString(5)+"\t"+rs.getInt(6)
				+"��\t"+rs.getString(7));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public boolean isDataStudent(int num) {
		boolean b=false;
		Connection conn=db.getConnection();
		Statement stmt=null;
		ResultSet rs=null;
		
		String sql="select * from mystudent where stu_num="+num;
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			
			if(rs.next()) {
				b=true;
			}
			else {
				b=false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, null, conn);
		}
		
		
		return b;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner sc=new Scanner(System.in);
		System.out.println("***�л�����***");
		QuizStudent qst=new QuizStudent();
		int n;
		
		while(true) {
			System.out.println("1.�Է� 2.��� 3.���� 4.���� 5.�л������˻� 9.����");
			System.out.println("======================================"
					+ "========================================");
			n=Integer.parseInt(sc.nextLine());
			if(n==1) {
				qst.insertStudent();
			}
			else if(n==2) {
				qst.selectStudent();
			}
			else if(n==3) {
				qst.deleteStudent();
			}
			else if(n==4) {
				qst.updateStudent();
			}
			else if(n==5) {
				qst.searchStudent();
			}
			else if(n==9) {
				System.out.println("�����մϴ�.");
				break;
			}
		}

	}

}

package jdbc_sawon;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class SawonCRUD {
	
	DBConnect db=new DBConnect();
	Scanner sc=new Scanner(System.in); //�������� �����ص� ���ο��� ���Ұ���

	public void addSawon() {
	
		System.out.println("***��� �߰��ϱ�***");
		
		System.out.println("�����?");
		String name = sc.nextLine();
		System.out.println("�μ���?");
		String buseo = sc.nextLine();
		System.out.println("����(����or����)?");
		String gender = sc.nextLine();
		System.out.println("�޿�?");
		int pay = Integer.parseInt(sc.nextLine());

		String sql="insert into sawon values(seq_sawon.nextval,'"+name+"','"+gender+"','"+buseo+"',"+pay+")";
		
		System.out.println(sql);
		
		//����Ŭ�� ����
		Connection conn=db.getConnection(); //null�� ���� ������ �̹� dbconnect Ŭ�������� try catchó����
		Statement stmt=null;
		
		try {
			stmt=conn.createStatement();
			stmt.execute(sql); //db�� ���� �� sql�� ����
			
			System.out.println("DB�� �߰���");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(stmt, conn);
		}
	}
	
	public void writeSawon() {
		
		String sql="select num,name,gender,buseo,to_char(pay,'L99,999,999') pay  from sawon";
		
		System.out.println("\t\t[��ü������]");
		System.out.println();
		
		System.out.println("������\t�����\t����\t�μ���\t     ���޿�");
		System.out.println("---------------------------------------------------");
		
		//db����
		Connection conn = db.getConnection();
		Statement stmt=null;
		ResultSet rs=null;
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			
			while(rs.next()) {
				System.out.println(rs.getInt("num")+"\t"
						+rs.getString("name")+"\t"
						+rs.getString("gender")+"\t"
						+rs.getString("buseo")
						+rs.getString("pay")); //to_char�� ����
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, stmt, conn);
		}
		
	}
	
	public void deleteSawon() {
		System.out.println("������ �����?");
		String name=sc.nextLine();
		
		String sql="delete from sawon where name ='"+name+"'";
		
		Connection conn=db.getConnection();
		Statement stmt=null;
		
		try {
			stmt=conn.createStatement();
			int a=stmt.executeUpdate(sql);
			if(a==0) {
				System.out.println("��ġ�ϴ� �̸��� �����ϴ�.");
			}
			else {
				System.out.println("�����Ǿ����ϴ�.");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(stmt, conn);
		}
	}
	
	public void updateSawon() {
		System.out.println("***��� ���� ����***");
		System.out.println("�ٲ� ������?");
		int seq=Integer.parseInt(sc.nextLine());
		System.out.println("�ٲ� �μ���(ȫ����,������,�λ��)?");
		String buseo=sc.nextLine();
		System.out.println("�޿�?");
		int pay=Integer.parseInt(sc.nextLine());
		
		String sql="update sawon set buseo='"+buseo+"',pay="+pay+" where num="+seq;
		
		Connection conn=db.getConnection();
		Statement stmt=null;
		
		try {
			stmt=conn.createStatement();
			stmt.execute(sql);
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(stmt, conn);
		}
	}
	
	public void searchName() {
		System.out.println("�˻��� �����(�Ϻΰ˻�����)");
		String name=sc.nextLine();
		
		String sql="select num,name,gender,buseo,to_char(pay,'L99,999,999') pay from sawon"
				+ " where name like '%"+name+"%'";
		
		System.out.println("\t\t[���������]");
		System.out.println();
		
		System.out.println("������\t�����\t����\t�μ���\t     ���޿�");
		System.out.println("---------------------------------------------------");
		
		Connection conn = db.getConnection();
		Statement stmt=null;
		ResultSet rs=null;
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			
			while(rs.next()) {
				System.out.println(rs.getInt("num")+"\t"
						+rs.getString("name")+"\t"
						+rs.getString("gender")+"\t"
						+rs.getString("buseo")
						+rs.getString("pay")); //to_char�� ����
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, stmt, conn);
		}
		
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		SawonCRUD sawon=new SawonCRUD();
		Scanner sc=new Scanner(System.in);
		
		int n;
		
		while(true) {
			System.out.println("Oracle DB_Sawon ����");
			System.out.println("1.insert 2.select 3.update 4.delete 5.search 9.quit");
			
			n=Integer.parseInt(sc.nextLine());
			
			if(n==1) {
				sawon.addSawon();
			}
			else if(n==2) {
				sawon.writeSawon();
			}
			else if(n==4) {
				sawon.deleteSawon();
			}
			else if(n==5) {
				sawon.searchName();
			}
			else if(n==9) {
				System.out.println("Quit DB Sawon");
				break;
			}
		}
	}

}
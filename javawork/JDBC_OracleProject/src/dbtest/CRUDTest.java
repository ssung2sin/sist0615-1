package dbtest;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class CRUDTest {
	
	DBConnect db=new DBConnect();
	
	//insert
	public void insert() {
		Scanner sc=new Scanner(System.in);
		
		System.out.println("�̸��Է�");
		String name=sc.nextLine();
		System.out.println("�ּ��Է�");
		String addr=sc.nextLine();
		
		String sql="insert into myinfo values "
				+ "(seq1.nextval,'"+name+"','"+addr+"'"
				+ ",sysdate)";
		
		//1.db����
		Connection conn=db.getConnection();
		//2.statement
		Statement stmt=null;
		try {
			stmt=conn.createStatement();
			stmt.execute(sql);
			
			System.out.println("***������ �߰��Ǿ����ϴ�***");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("insert error: "+e.getMessage());
		}finally {
			db.dbClose(stmt, conn);
		}
		
	}
	
	public void select() {
		Connection conn=db.getConnection();
		Statement stmt=null;
		ResultSet rs=null;
		System.out.println("��ȣ\t|�̸�\t|\t�ּ�\t|\t�Է½ð�");
		System.out.println("--------------------------------------------");
		String sql="select num,name,addr,sdate from myinfo order by 1 asc";
	
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next()) {
				int num=rs.getInt("num");
				String name=rs.getString("name");
				String addr=rs.getString("addr");
				String sd=rs.getString("sdate");
				
				System.out.println(num+"\t|"+name+"\t|"+addr+"\t|"+sd);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			db.dbClose(rs, stmt, conn);
		}
	}
	
	//delete
	public void delete() {
		int n;
		
		Scanner sc=new Scanner(System.in);
		System.out.print("������ ��ȣ�� �Է��ϼ��� : ");
		n=Integer.parseInt(sc.nextLine()); //���⼭ n�� String�̵� int�� �������
		
		String sql="delete from myinfo where num ="+n;
		Connection conn=db.getConnection();
		Statement stmt=null; //�ݾ��ٶ� try catch�� ������ ������ �ҷ��� ���� ����!!
		try {
			stmt=conn.createStatement();
			int a=stmt.executeUpdate(sql);
			
			if(a==0) { //���� ��ȣ �Է½� ���� ������ ���� �����Ƿ� 0 ��ȯ!
				System.out.println("���� ������ ��ȣ�Դϴ�.");
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
	
	//update
	public void update() {
		Scanner sc=new Scanner(System.in);
		String num;
		System.out.println("������ ��������?");
		num=sc.nextLine();
		//���� boolean �޼��� �����ͼ� ����
		if(!this.isData(num)) {
			System.out.println("�ش��ȣ�� �������� �ʽ��ϴ�.");
			return;
		}
		System.out.println("������ �̸���?");
		String name=sc.nextLine();
		
		System.out.println("������ �ּҴ�?");
		String addr=sc.nextLine();
		
		//sql
		String sql="update myinfo set name='"+name
				+"',addr='"+addr+"' where num="+num; //where�� ��ĭ������!
		
		System.out.println(sql);
		
		Connection conn=db.getConnection();
		Statement stmt=null;
		
		try {
			stmt=conn.createStatement();
			stmt.execute(sql);
			
			System.out.println("�����Ǿ����ϴ�.");
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("Update error :"+e.getMessage());
		}finally {
			db.dbClose(null, stmt, conn);
		}
	}
	
	//update �Ҷ� ���� ��ȣ���� �ִ� ��ȣ���� ã���ֱ�
	
	public boolean isData(String num) {
		boolean flag=false;
		
		String sql="select * from myinfo where num="+num;
		
		Connection conn=db.getConnection();
		Statement stmt=null;
		ResultSet rs=null; //����Ʈ�� ������ ����Ʈ�� �ʿ�
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			//1���� ��� if��
			if(rs.next()) { //�����Ͱ� �ִ� ���
				flag=true;
			}
			else { //�����Ͱ� ���� ���
				flag=false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, stmt, conn);
		}
		
		return flag;
	}
	

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		CRUDTest crud=new CRUDTest();
		Scanner sc=new Scanner(System.in);
		int n;
		
		while(true) {
			System.out.println("***Oracle DB ����_myinfo***");
			System.out.println("1.insert 2.select 3.delete 4.update 9.quit");
			n=Integer.parseInt(sc.nextLine());
			
			if(n==1) {
				crud.insert();
			}
			else if(n==2) {
				crud.select();
			}
			else if(n==3) {
				crud.delete();
			}
			else if(n==4) {
				crud.update();
			}
			else if(n==9) {
				System.out.println("�����մϴ�.");
				break;
			}
		}
	}

}

package dbtest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class PrepareMyShop {
	DBConnect db=new DBConnect();
	Scanner sc=new Scanner(System.in);
		
		//insert
	public void insertMyShop() {
		//Connection
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		System.out.println("��ǰ����?");
		String sang=sc.nextLine();
		System.out.println("����?");
		int su=Integer.parseInt(sc.nextLine());
		System.out.println("����?");
		int dan=Integer.parseInt(sc.nextLine());
		
		//sql..PrepareStatement�� �̿��� sql�����ۼ�
		String sql="insert into myshop values (seq1.nextval,?,?,?,sysdate)";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			//?�� ������� ���ε�
			pstmt.setString(1, sang);
			pstmt.setInt(2, su);
			pstmt.setInt(3, dan);
			
			//������Ʈ
			int a= pstmt.executeUpdate();
			
			if(a==1) {
				System.out.println("�μ�Ʈ ����!!");
			}
			else {
				System.out.println("�μ�Ʈ ����!!");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public void selectShop() {
		Connection conn=db.getConnection();
		Statement stmt=null;
		ResultSet rs=null;
		String sql="select * from myshop order by sangpum";
		System.out.println("��ǰ��ȣ\t��ǰ��\t����\t����\t�԰�¥");
		System.out.println("-------------------------------------------------");
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			
			while(rs.next()) {
				System.out.println(rs.getInt("shopnum")+"\t"+rs.getString("sangpum")
				+"\t"+rs.getInt("su")+"\t"+rs.getInt("price")+"\t"+rs.getString("ipgo"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, stmt, conn);
		}
		
	}
	public void deleteShop() {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		System.out.println("�����Ͻ� �������� �Է��ϼ���.");
		int n=Integer.parseInt(sc.nextLine());
		
		String sql="delete from myshop where shopnum="+n;
		
		try {
			pstmt=conn.prepareStatement(sql);
			// ?�� �� �־��ֱ� ! ���ε�
			pstmt.setInt(1, n);
			int a=pstmt.executeUpdate();
			
			if(a==0) {
				System.out.println("�ش��ȣ�� �������� �ʽ��ϴ�.");
			}
			else {
				System.out.println("�����Ͽ����ϴ�.");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public void updateShop() {
		System.out.println("������ ��������?");
		int num=Integer.parseInt(sc.nextLine());
		if(!isDataShop(num)) {
			System.out.println("�Է��Ͻ� �������� ���� �������� �ʽ��ϴ�.");
			return;
		}
		System.out.println("������ ��ǰ����?");
		String name=sc.nextLine();
		
		System.out.println("������ ������?");
		int su=Integer.parseInt(sc.nextLine());
		
		System.out.println("������ ������?");
		int price=Integer.parseInt(sc.nextLine());
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="update myshop set sangpum=?,su=?,price=?"
				+" where shopnum="+num;
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, su);
			pstmt.setInt(3, price);
			
			//������Ʈ
			pstmt.execute();
			
			System.out.println("�����Ϸ�");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	
	public boolean isDataShop(int num) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		boolean flag=false;
		String sql="select * from myshop where shopnum=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				flag=true;
			}
			else {
				flag=false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		
		return flag;
		
	}
	
	//�˻�
	public void searchSangpum() {
		
		System.out.println("�˻��� ��ǰ��(�Ϻ�)");
		String sang=sc.nextLine();
		
		String sql="select * from myshop where sangpum like ?";
		
		System.out.println("������\t��ǰ��\t����\t�ܰ�\t��¥");
		System.out.println("---------------------------------------------");
		
		Connection conn = db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, "%"+sang+"%"); //�Է��� ���� ���� �κ� �˻�
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				System.out.println(rs.getInt("shopnum")+"\t"+rs.getString("sangpum")
				+"\t"+rs.getInt("su")+"\t"+rs.getInt("price")+"\t"+rs.getString("ipgo"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
	}
	
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		PrepareMyShop shop=new PrepareMyShop();
		Scanner sc=new Scanner(System.in);
		
		int n;
		
		while(true) {
			System.out.println("****��ǰ�԰�****");
			System.out.println("1.��ǰ�߰�	 2.��ǰ���� 3.��ǰ���� 4.��ǰ��ü��� 5.��ǰ�˻� 9.����");
			n=Integer.parseInt(sc.nextLine());
			
			if(n==1) {
				shop.insertMyShop();
			}
			else if(n==2) {
				shop.deleteShop();
			}
			else if(n==3) {
				shop.updateShop();
			}
			else if(n==4) {
				shop.selectShop();
			}
			else if(n==5) {
				shop.searchSangpum();
			}
			else if(n==9) {
				System.out.println("�����մϴ�.");
				break;
			}
		}
		

	}

}

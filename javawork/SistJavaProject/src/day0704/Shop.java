package day0704;

public class Shop {
	
	private String sangName;
	private int su;
	private int dan;
	
	public Shop(String sn,int s,int d) {
		this.sangName=sn;
		this.su=s;
		this.dan=d;
	}

	public String getSangName() {
		return sangName;
	}

	public void setSangName(String sangName) {
		this.sangName = sangName;
	}

	public int getSu() {
		return su;
	}

	public void setSu(int su) {
		this.su = su;
	}

	public int getDan() {
		return dan;
	}

	public void setDan(int dan) {
		this.dan = dan;
	}
	

}

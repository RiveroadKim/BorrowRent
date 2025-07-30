package items;

public class Items_tp {
	
	private int tpID;
	private String tpName;
	private int tpQuan;
	private int tpYear;
	private int tpPrice;
	private String tpBrand;
	private String tpModel;
	private String tpColor;
	private String tpMemory;
	private int tpAvailable; // 아이템이 존재하면 1, 만약 삭제하거나 없어질 경우 0
	private String userEmail; // 유저테이블에서 참조한 외래키
	private String userName;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getTpID() {
		return tpID;
	}
	public void setTpID(int tpID) {
		this.tpID = tpID;
	}
	public String getTpName() {
		return tpName;
	}
	public void setTpName(String tpName) {
		this.tpName = tpName;
	}
	public int getTpQuan() {
		return tpQuan;
	}
	public void setTpQuan(int tpQuan) {
		this.tpQuan = tpQuan;
	}
	public int getTpYear() {
		return tpYear;
	}
	public void setTpYear(int tpYear) {
		this.tpYear = tpYear;
	}
	public int getTpPrice() {
		return tpPrice;
	}
	public void setTpPrice(int tpPrice) {
		this.tpPrice = tpPrice;
	}
	public String getTpBrand() {
		return tpBrand;
	}
	public void setTpBrand(String tpBrand) {
		this.tpBrand = tpBrand;
	}
	public String getTpModel() {
		return tpModel;
	}
	public void setTpModel(String tpModel) {
		this.tpModel = tpModel;
	}
	public String getTpColor() {
		return tpColor;
	}
	public void setTpColor(String tpColor) {
		this.tpColor = tpColor;
	}
	public String getTpMemory() {
		return tpMemory;
	}
	public void setTpMemory(String tpMemory) {
		this.tpMemory = tpMemory;
	}
	public int getTpAvailable() {
		return tpAvailable;
	}
	public void setTpAvailable(int tpAvailable) {
		this.tpAvailable = tpAvailable;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
	

}

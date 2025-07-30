package items;

public class Items_laptop {
	
	private int lapID;
	private String lapName;
	private int lapQuan;
	private int lapYear;
	private int lapPrice;
	private String lapBrand;
	private String lapModel;
	private String lapColor;
	private String lapGraphic;
	private String lapOS;
	private String lapCPU;
	private String lapMemory;
	private int lapAvailable; // 존재하면 1, 만약 삭제하거나 없어질 경우 0
	private String userEmail; // 유저테이블에서 참조한 외래키
	private String userName;
	
	public String getLapGraphic() {
		return lapGraphic;
	}
	public void setLapGraphic(String lapGraphic) {
		this.lapGraphic = lapGraphic;
	}
	public String getLapOS() {
		return lapOS;
	}
	public void setLapOS(String lapOS) {
		this.lapOS = lapOS;
	}
	public String getLapCPU() {
		return lapCPU;
	}
	public void setLapCPU(String lapCPU) {
		this.lapCPU = lapCPU;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getLapID() {
		return lapID;
	}
	public void setLapID(int lapID) {
		this.lapID = lapID;
	}
	public String getLapName() {
		return lapName;
	}
	public void setLapName(String lapName) {
		this.lapName = lapName;
	}
	public int getLapQuan() {
		return lapQuan;
	}
	public void setLapQuan(int lapQuan) {
		this.lapQuan = lapQuan;
	}
	public int getLapYear() {
		return lapYear;
	}
	public void setLapYear(int lapYear) {
		this.lapYear = lapYear;
	}
	public int getLapPrice() {
		return lapPrice;
	}
	public void setLapPrice(int lapPrice) {
		this.lapPrice = lapPrice;
	}
	public String getLapBrand() {
		return lapBrand;
	}
	public void setLapBrand(String lapBrand) {
		this.lapBrand = lapBrand;
	}
	public String getLapModel() {
		return lapModel;
	}
	public void setLapModel(String lapModel) {
		this.lapModel = lapModel;
	}
	public String getLapColor() {
		return lapColor;
	}
	public void setLapColor(String lapColor) {
		this.lapColor = lapColor;
	}
	public String getLapMemory() {
		return lapMemory;
	}
	public void setLapMemory(String lapMemory) {
		this.lapMemory = lapMemory;
	}
	public int getLapAvailable() {
		return lapAvailable;
	}
	public void setLapAvailable(int lapAvailable) {
		this.lapAvailable = lapAvailable;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
}

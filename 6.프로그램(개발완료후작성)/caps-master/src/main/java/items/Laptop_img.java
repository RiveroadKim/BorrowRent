package items;

public class Laptop_img {
	
	private int lap_img_ID;
	private String lap_img_Name;
	private int lapID; // Items_laptop 테이블에서 참조한 외래키
	private String lap_img_path;
	
	public Laptop_img() {
	}
	
	public int getLap_img_ID() {
		return lap_img_ID;
	}
	public Laptop_img(int lap_img_ID, String lap_img_Name, int lapID, String lap_img_path) {
		super();
		this.lap_img_ID = lap_img_ID;
		this.lap_img_Name = lap_img_Name;
		this.lapID = lapID;
		this.lap_img_path = lap_img_path;
	}

	public String getLap_img_Name() {
		return lap_img_Name;
	}

	public void setLap_img_Name(String lap_img_Name) {
		this.lap_img_Name = lap_img_Name;
	}

	public void setLap_img_ID(int lap_img_ID) {
		this.lap_img_ID = lap_img_ID;
	}
	public int getLapID() {
		return lapID;
	}
	public void setLapID(int lapID) {
		this.lapID = lapID;
	}
	public String getLap_img_path() {
		return lap_img_path;
	}

	public void setLap_img_path(String lap_img_path) {
		this.lap_img_path = lap_img_path;
	}
	
}

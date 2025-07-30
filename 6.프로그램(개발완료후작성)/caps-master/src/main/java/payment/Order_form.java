package payment;

public class Order_form {
	
    private String orderID;
    private int orderQuan;
    private String orderRent;
    private String orderName;
    private String orderEmail;
    private String orderPnum;
    private String orderAdd1;
    private String orderAdd2;
    private String orderReq;
    private String orderTotal;
    private String orderNow; // 결제한 현재 시간
    private String orderReturn; // 결제 후 orderRent에 따라 orderNow 에서부터 orderReturn 하는 날짜를 계산
    private String userEmail; // user 테이블에서 참조한 외래키
    private int lapID; // Items_laptop 에서 참조한 외래키
    private int tpID; // Items_tp 에서 참조한 외래키
	public String getOrderID() {
		return orderID;
	}
	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}
	public int getOrderQuan() {
		return orderQuan;
	}
	public void setOrderQuan(int orderQuan) {
		this.orderQuan = orderQuan;
	}
	public String getOrderRent() {
		return orderRent;
	}
	public void setOrderRent(String orderRent) {
		this.orderRent = orderRent;
	}
	public String getOrderName() {
		return orderName;
	}
	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}
	public String getOrderEmail() {
		return orderEmail;
	}
	public void setOrderEmail(String orderEmail) {
		this.orderEmail = orderEmail;
	}
	public String getOrderPnum() {
		return orderPnum;
	}
	public void setOrderPnum(String orderPnum) {
		this.orderPnum = orderPnum;
	}
	public String getOrderAdd1() {
		return orderAdd1;
	}
	public void setOrderAdd1(String orderAdd1) {
		this.orderAdd1 = orderAdd1;
	}
	public String getOrderAdd2() {
		return orderAdd2;
	}
	public void setOrderAdd2(String orderAdd2) {
		this.orderAdd2 = orderAdd2;
	}
	public String getOrderReq() {
		return orderReq;
	}
	public void setOrderReq(String orderReq) {
		this.orderReq = orderReq;
	}
	public String getOrderTotal() {
		return orderTotal;
	}
	public void setOrderTotal(String orderTotal) {
		this.orderTotal = orderTotal;
	}
	public String getOrderNow() {
		return orderNow;
	}
	public void setOrderNow(String orderNow) {
		this.orderNow = orderNow;
	}
	public String getOrderReturn() {
		return orderReturn;
	}
	public void setOrderReturn(String orderReturn) {
		this.orderReturn = orderReturn;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public int getLapID() {
		return lapID;
	}
	public void setLapID(int lapID) {
		this.lapID = lapID;
	}
	public int getTpID() {
		return tpID;
	}
	public void setTpID(int tpID) {
		this.tpID = tpID;
	}
	
	public Order_form(String orderID, int orderQuan, String orderRent, String orderName, String orderEmail,
			String orderPnum, String orderAdd1, String orderAdd2, String orderReq, String orderTotal, String orderNow,
			String orderReturn, String userEmail, int lapID, int tpID) {
		super();
		this.orderID = orderID;
		this.orderQuan = orderQuan;
		this.orderRent = orderRent;
		this.orderName = orderName;
		this.orderEmail = orderEmail;
		this.orderPnum = orderPnum;
		this.orderAdd1 = orderAdd1;
		this.orderAdd2 = orderAdd2;
		this.orderReq = orderReq;
		this.orderTotal = orderTotal;
		this.orderNow = orderNow;
		this.orderReturn = orderReturn;
		this.userEmail = userEmail;
		this.lapID = lapID;
		this.tpID = tpID;
	}
	
    // 기본 생성자
    public Order_form() {
    }
	
}

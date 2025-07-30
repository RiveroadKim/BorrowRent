package payment;

public class Order_form_lap {
	
    private String orderID;
    private int orderQuan;
    private String orderRent;
    private String orderName;
    private String orderEmail;
    private String orderPnum;
    private String orderAdd1;
    private String orderAdd2;
    private String orderReq;
    private int orderTotal;
    private String orderNow;
    private String orderReturn;
    private String userEmail;
    private int lapID;
    private String lapName;
    
    public String getLapName() {
		return lapName;
	}
	public void setLapName(String lapName) {
		this.lapName = lapName;
	}
	
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
	public int getOrderTotal() {
		return orderTotal;
	}
	public void setOrderTotal(int orderTotal) {
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
	public Order_form_lap(String orderID, int orderQuan, String orderRent, String orderName, String orderEmail,
			String orderPnum, String orderAdd1, String orderAdd2, String orderReq, int orderTotal, String orderNow,
			String orderReturn, String userEmail, int lapID) {
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
	}
	public Order_form_lap() {
		// TODO Auto-generated constructor stub
	}

}

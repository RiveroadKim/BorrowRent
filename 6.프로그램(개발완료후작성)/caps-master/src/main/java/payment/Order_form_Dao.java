package payment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

public class Order_form_Dao {
    private Connection conn;

    public Order_form_Dao() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/caps";
            String dbID = "root";
            String dbPassword = "0000";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public int uploadLaptopOrder(int orderQuan, String orderRent, String orderName, String orderEmail, String orderPnum, String orderAdd1, String orderAdd2, String orderReq, int itemPrice, String userEmail, int lapID) {
        String SQL = "INSERT INTO Order_form_lap (orderID, orderQuan, orderRent, orderName, orderEmail, orderPnum, orderAdd1, orderAdd2, orderReq, orderTotal, orderNow, orderReturn, userEmail, lapID, lapName) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = null;
        try {
            // lapID를 사용하여 lapName 가져오기
            String lapName = getLaptopNameById(lapID);
            
            pstmt = conn.prepareStatement(SQL);
            String orderID = UUID.randomUUID().toString(); // 자동 생성된 orderID
            pstmt.setString(1, orderID);
            pstmt.setInt(2, orderQuan);
            pstmt.setString(3, orderRent);
            pstmt.setString(4, orderName);
            pstmt.setString(5, orderEmail);
            pstmt.setString(6, orderPnum);
            pstmt.setString(7, orderAdd1);
            pstmt.setString(8, orderAdd2);
            pstmt.setString(9, orderReq);

            // orderTotal 계산
            int rentPeriod = Integer.parseInt(orderRent);
            int orderTotal = itemPrice * orderQuan * rentPeriod;
            pstmt.setInt(10, orderTotal);

            // orderNow와 orderReturn 계산
            Timestamp orderNow = new Timestamp(System.currentTimeMillis());
            pstmt.setTimestamp(11, orderNow);

            Calendar cal = Calendar.getInstance();
            cal.setTime(orderNow);
            cal.add(Calendar.MONTH, rentPeriod);
            Timestamp orderReturn = new Timestamp(cal.getTimeInMillis());
            pstmt.setTimestamp(12, orderReturn);

            pstmt.setString(13, userEmail);
            pstmt.setInt(14, lapID);
            pstmt.setString(15, lapName); // lapName 추가

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1; // 오류 발생 시
    }

    // lapID를 사용하여 lapName 가져오는 메서드 추가
    private String getLaptopNameById(int lapID) {
        String SQL = "SELECT lapName FROM Items_laptop WHERE lapID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, lapID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("lapName");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    public int uploadTpOrder(int orderQuan, String orderRent, String orderName, String orderEmail, String orderPnum, String orderAdd1, String orderAdd2, String orderReq, int itemPrice, String userEmail, int tpID) {
        String SQL = "INSERT INTO Order_form_tp (orderID, orderQuan, orderRent, orderName, orderEmail, orderPnum, orderAdd1, orderAdd2, orderReq, orderTotal, orderNow, orderReturn, userEmail, tpID, tpName) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = null;
        try {
            // tpID를 사용하여 tpName 가져오기
            String tpName = getTpNameById(tpID);
            
            pstmt = conn.prepareStatement(SQL);
            String orderID = UUID.randomUUID().toString(); // 자동 생성된 orderID
            pstmt.setString(1, orderID);
            pstmt.setInt(2, orderQuan);
            pstmt.setString(3, orderRent);
            pstmt.setString(4, orderName);
            pstmt.setString(5, orderEmail);
            pstmt.setString(6, orderPnum);
            pstmt.setString(7, orderAdd1);
            pstmt.setString(8, orderAdd2);
            pstmt.setString(9, orderReq);

            // orderTotal 계산
            int rentPeriod = Integer.parseInt(orderRent);
            int orderTotal = itemPrice * orderQuan * rentPeriod;
            pstmt.setInt(10, orderTotal);

            // orderNow와 orderReturn 계산
            Timestamp orderNow = new Timestamp(System.currentTimeMillis());
            pstmt.setTimestamp(11, orderNow);

            Calendar cal = Calendar.getInstance();
            cal.setTime(orderNow);
            cal.add(Calendar.MONTH, rentPeriod);
            Timestamp orderReturn = new Timestamp(cal.getTimeInMillis());
            pstmt.setTimestamp(12, orderReturn);

            pstmt.setString(13, userEmail);
            pstmt.setInt(14, tpID);
            pstmt.setString(15, tpName); // tpName 추가

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1; // 오류 발생 시
    }

    // tpID를 사용하여 tpName 가져오는 메서드 추가
    private String getTpNameById(int tpID) {
        String SQL = "SELECT tpName FROM Items_tp WHERE tpID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, tpID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("tpName");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    private String generateOrderID(String type) {
        String year = new SimpleDateFormat("yyyy").format(Calendar.getInstance().getTime());
        String randomString = UUID.randomUUID().toString().substring(0, 4).toUpperCase();
        return year + "-" + type + "-" + randomString;
    }

    public int upload(int orderQuan, String orderRent, String orderName, String orderEmail, String orderPnum, String orderAdd1, String orderAdd2, String orderReq, int itemPrice, String userEmail, int lapID, int tpID) {
        String SQL = "INSERT INTO Order_form (orderID, orderQuan, orderRent, orderName, orderEmail, orderPnum, orderAdd1, orderAdd2, orderReq, orderTotal, orderNow, orderReturn, userEmail, lapID, tpID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(SQL);
            String orderID;
            if (lapID > 0) {
                orderID = generateOrderID("lap");
            } else {
                orderID = generateOrderID("tp");
            }

            pstmt.setString(1, orderID);
            pstmt.setInt(2, orderQuan);
            pstmt.setString(3, orderRent);
            pstmt.setString(4, orderName);
            pstmt.setString(5, orderEmail);
            pstmt.setString(6, orderPnum);
            pstmt.setString(7, orderAdd1);
            pstmt.setString(8, orderAdd2);
            pstmt.setString(9, orderReq);

            // orderTotal 계산
            int rentPeriod = Integer.parseInt(orderRent);
            int orderTotal = itemPrice * orderQuan * rentPeriod;
            pstmt.setInt(10, orderTotal);

            // orderNow와 orderReturn 계산
            Timestamp orderNow = new Timestamp(System.currentTimeMillis());
            pstmt.setTimestamp(11, orderNow);

            Calendar cal = Calendar.getInstance();
            cal.setTime(orderNow);
            cal.add(Calendar.MONTH, rentPeriod);
            Timestamp orderReturn = new Timestamp(cal.getTimeInMillis());
            pstmt.setTimestamp(12, orderReturn);

            pstmt.setString(13, userEmail);
            pstmt.setInt(14, lapID);
            pstmt.setInt(15, tpID);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1; // 오류 발생 시
    }
    
    private String formatTimestamp(Timestamp timestamp) {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(timestamp);
    }

    public String getLastInsertedLaptopOrderID() {
        String SQL = "SELECT orderID FROM Order_form_lap ORDER BY orderNow DESC LIMIT 1";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getString("orderID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getLastInsertedTpOrderID() {
        String SQL = "SELECT orderID FROM Order_form_tp ORDER BY orderNow DESC LIMIT 1";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getString("orderID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Order_form_lap getLaptopOrderById(String orderID) {
        String SQL = "SELECT * FROM Order_form_lap WHERE orderID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, orderID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Order_form_lap order = new Order_form_lap();
                    order.setOrderID(rs.getString("orderID"));
                    order.setOrderQuan(rs.getInt("orderQuan"));
                    order.setOrderRent(rs.getString("orderRent"));
                    order.setOrderName(rs.getString("orderName"));
                    order.setOrderEmail(rs.getString("orderEmail"));
                    order.setOrderPnum(rs.getString("orderPnum"));
                    order.setOrderAdd1(rs.getString("orderAdd1"));
                    order.setOrderAdd2(rs.getString("orderAdd2"));
                    order.setOrderReq(rs.getString("orderReq"));
                    order.setOrderTotal(rs.getInt("orderTotal"));
                    order.setOrderNow(formatTimestamp(rs.getTimestamp("orderNow")));
                    order.setOrderReturn(formatTimestamp(rs.getTimestamp("orderReturn")));
                    order.setUserEmail(rs.getString("userEmail"));
                    order.setLapID(rs.getInt("lapID"));
                    return order;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Order_form_tp getTpOrderById(String orderID) {
        String SQL = "SELECT * FROM Order_form_tp WHERE orderID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, orderID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Order_form_tp order = new Order_form_tp();
                    order.setOrderID(rs.getString("orderID"));
                    order.setOrderQuan(rs.getInt("orderQuan"));
                    order.setOrderRent(rs.getString("orderRent"));
                    order.setOrderName(rs.getString("orderName"));
                    order.setOrderEmail(rs.getString("orderEmail"));
                    order.setOrderPnum(rs.getString("orderPnum"));
                    order.setOrderAdd1(rs.getString("orderAdd1"));
                    order.setOrderAdd2(rs.getString("orderAdd2"));
                    order.setOrderReq(rs.getString("orderReq"));
                    order.setOrderTotal(rs.getInt("orderTotal"));
                    order.setOrderNow(formatTimestamp(rs.getTimestamp("orderNow")));
                    order.setOrderReturn(formatTimestamp(rs.getTimestamp("orderReturn")));
                    order.setUserEmail(rs.getString("userEmail"));
                    order.setTpID(rs.getInt("tpID"));
                    return order;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
   

    public List<Order_form_lap> getBorrowedLaptopOrdersByUserEmail(String userEmail) {
        String SQL = "SELECT * FROM Order_form_lap WHERE userEmail = ?";
        List<Order_form_lap> list = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, userEmail);
            System.out.println("Executing query: " + pstmt); // 디버그 로그 추가
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order_form_lap order = new Order_form_lap();
                    order.setOrderID(rs.getString("orderID"));
                    order.setOrderQuan(rs.getInt("orderQuan"));
                    order.setOrderRent(rs.getString("orderRent"));
                    order.setOrderName(rs.getString("orderName"));
                    order.setOrderEmail(rs.getString("orderEmail"));
                    order.setOrderPnum(rs.getString("orderPnum"));
                    order.setOrderAdd1(rs.getString("orderAdd1"));
                    order.setOrderAdd2(rs.getString("orderAdd2"));
                    order.setOrderReq(rs.getString("orderReq"));
                    order.setOrderTotal(rs.getInt("orderTotal"));
                    order.setOrderNow(formatTimestamp(rs.getTimestamp("orderNow")));
                    order.setOrderReturn(formatTimestamp(rs.getTimestamp("orderReturn")));
                    order.setUserEmail(rs.getString("userEmail"));
                    order.setLapID(rs.getInt("lapID"));
                    list.add(order);
                }
            }
            System.out.println("Borrowed Laptop Orders: " + list.size()); // 디버그 로그 추가
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order_form_tp> getBorrowedTpOrdersByUserEmail(String userEmail) {
        String SQL = "SELECT * FROM Order_form_tp WHERE userEmail = ?";
        List<Order_form_tp> list = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, userEmail);
            System.out.println("Executing query: " + pstmt); // 디버그 로그 추가
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order_form_tp order = new Order_form_tp();
                    order.setOrderID(rs.getString("orderID"));
                    order.setOrderQuan(rs.getInt("orderQuan"));
                    order.setOrderRent(rs.getString("orderRent"));
                    order.setOrderName(rs.getString("orderName"));
                    order.setOrderEmail(rs.getString("orderEmail"));
                    order.setOrderPnum(rs.getString("orderPnum"));
                    order.setOrderAdd1(rs.getString("orderAdd1"));
                    order.setOrderAdd2(rs.getString("orderAdd2"));
                    order.setOrderReq(rs.getString("orderReq"));
                    order.setOrderTotal(rs.getInt("orderTotal"));
                    order.setOrderNow(formatTimestamp(rs.getTimestamp("orderNow")));
                    order.setOrderReturn(formatTimestamp(rs.getTimestamp("orderReturn")));
                    order.setUserEmail(rs.getString("userEmail"));
                    order.setTpID(rs.getInt("tpID"));
                    list.add(order);
                }
            }
            System.out.println("Borrowed TP Orders: " + list.size()); // 디버그 로그 추가
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    
    public List<Order_form_lap> getLentLaptopOrdersByUserEmail(String ownerEmail) {
        String SQL = "SELECT * FROM Order_form_lap WHERE lapID IN (SELECT lapID FROM Items_laptop WHERE userEmail = ?)";
        List<Order_form_lap> list = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, ownerEmail);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order_form_lap order = new Order_form_lap();
                    order.setOrderID(rs.getString("orderID"));
                    order.setOrderQuan(rs.getInt("orderQuan"));
                    order.setOrderRent(rs.getString("orderRent"));
                    order.setOrderName(rs.getString("orderName"));
                    order.setOrderEmail(rs.getString("orderEmail")); // 빌려간 사용자의 이메일
                    order.setOrderPnum(rs.getString("orderPnum"));
                    order.setOrderAdd1(rs.getString("orderAdd1"));
                    order.setOrderAdd2(rs.getString("orderAdd2"));
                    order.setOrderReq(rs.getString("orderReq"));
                    order.setOrderTotal(rs.getInt("orderTotal"));
                    order.setOrderNow(formatTimestamp(rs.getTimestamp("orderNow")));
                    order.setOrderReturn(formatTimestamp(rs.getTimestamp("orderReturn")));
                    order.setUserEmail(rs.getString("userEmail"));
                    order.setLapID(rs.getInt("lapID"));
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order_form_tp> getLentTpOrdersByUserEmail(String ownerEmail) {
        String SQL = "SELECT * FROM Order_form_tp WHERE tpID IN (SELECT tpID FROM Items_tp WHERE userEmail = ?)";
        List<Order_form_tp> list = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, ownerEmail);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order_form_tp order = new Order_form_tp();
                    order.setOrderID(rs.getString("orderID"));
                    order.setOrderQuan(rs.getInt("orderQuan"));
                    order.setOrderRent(rs.getString("orderRent"));
                    order.setOrderName(rs.getString("orderName"));
                    order.setOrderEmail(rs.getString("orderEmail")); // 빌려간 사용자의 이메일
                    order.setOrderPnum(rs.getString("orderPnum"));
                    order.setOrderAdd1(rs.getString("orderAdd1"));
                    order.setOrderAdd2(rs.getString("orderAdd2"));
                    order.setOrderReq(rs.getString("orderReq"));
                    order.setOrderTotal(rs.getInt("orderTotal"));
                    order.setOrderNow(formatTimestamp(rs.getTimestamp("orderNow")));
                    order.setOrderReturn(formatTimestamp(rs.getTimestamp("orderReturn")));
                    order.setUserEmail(rs.getString("userEmail"));
                    order.setTpID(rs.getInt("tpID"));
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Order_form_lap> getAllLaptopOrdersByUserEmail(String userEmail) {
        String SQL = "SELECT ol.*, il.lapName FROM Order_form_lap ol JOIN Items_laptop il ON ol.lapID = il.lapID WHERE ol.userEmail = ?";
        List<Order_form_lap> list = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, userEmail);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order_form_lap order = new Order_form_lap();
                    order.setOrderID(rs.getString("orderID"));
                    order.setOrderQuan(rs.getInt("orderQuan"));
                    order.setOrderRent(rs.getString("orderRent"));
                    order.setOrderName(rs.getString("orderName"));
                    order.setOrderEmail(rs.getString("orderEmail"));
                    order.setOrderPnum(rs.getString("orderPnum"));
                    order.setOrderAdd1(rs.getString("orderAdd1"));
                    order.setOrderAdd2(rs.getString("orderAdd2"));
                    order.setOrderReq(rs.getString("orderReq"));
                    order.setOrderTotal(rs.getInt("orderTotal"));
                    order.setOrderNow(formatTimestamp(rs.getTimestamp("orderNow")));
                    order.setOrderReturn(formatTimestamp(rs.getTimestamp("orderReturn")));
                    order.setUserEmail(rs.getString("userEmail"));
                    order.setLapID(rs.getInt("lapID"));
                    order.setLapName(rs.getString("lapName")); // lapName 설정
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Order_form_tp> getAllTpOrdersByUserEmail(String userEmail) {
        String SQL = "SELECT ot.*, it.tpName FROM Order_form_tp ot JOIN Items_tp it ON ot.tpID = it.tpID WHERE ot.userEmail = ?";
        List<Order_form_tp> list = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, userEmail);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order_form_tp order = new Order_form_tp();
                    order.setOrderID(rs.getString("orderID"));
                    order.setOrderQuan(rs.getInt("orderQuan"));
                    order.setOrderRent(rs.getString("orderRent"));
                    order.setOrderName(rs.getString("orderName"));
                    order.setOrderEmail(rs.getString("orderEmail"));
                    order.setOrderPnum(rs.getString("orderPnum"));
                    order.setOrderAdd1(rs.getString("orderAdd1"));
                    order.setOrderAdd2(rs.getString("orderAdd2"));
                    order.setOrderReq(rs.getString("orderReq"));
                    order.setOrderTotal(rs.getInt("orderTotal"));
                    order.setOrderNow(formatTimestamp(rs.getTimestamp("orderNow")));
                    order.setOrderReturn(formatTimestamp(rs.getTimestamp("orderReturn")));
                    order.setUserEmail(rs.getString("userEmail"));
                    order.setTpID(rs.getInt("tpID"));
                    order.setTpName(rs.getString("tpName")); // tpName 설정
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

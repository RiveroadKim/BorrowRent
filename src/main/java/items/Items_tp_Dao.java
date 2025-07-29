package items;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Items_tp_Dao {
    private Connection conn;
    private ResultSet rs;

    public Items_tp_Dao() {
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

    private void closeResources(PreparedStatement pstmt, ResultSet rs) {
        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
    }

    public int getNext() {
        String SQL = "SELECT tpID FROM Items_tp ORDER BY tpID DESC";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int write(String tpName, int tpQuan, int tpYear, int tpPrice, String tpBrand, String tpModel, String tpColor, String tpMemory, String userName, String userEmail) {
        String SQL = "INSERT INTO Items_tp VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, getNext());
            pstmt.setString(2, tpName);
            pstmt.setInt(3, tpQuan);
            pstmt.setInt(4, tpYear);
            pstmt.setInt(5, tpPrice);
            pstmt.setString(6, tpBrand);
            pstmt.setString(7, tpModel);
            pstmt.setString(8, tpColor);
            pstmt.setString(9, tpMemory);
            pstmt.setInt(10, 1); // tpAvailable
            pstmt.setString(11, userEmail);
            pstmt.setString(12, userName);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int getLastInsertedID() {
        String SQL = "SELECT tpID FROM Items_tp ORDER BY tpID DESC LIMIT 1";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<Items_tp> getItemsByUserEmail(String userEmail) {
        List<Items_tp> list = new ArrayList<>();
        String SQL = "SELECT * FROM Items_tp WHERE userEmail = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, userEmail);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Items_tp item = new Items_tp();
                    item.setTpID(rs.getInt("tpID"));
                    item.setTpName(rs.getString("tpName"));
                    item.setTpQuan(rs.getInt("tpQuan"));
                    item.setTpYear(rs.getInt("tpYear"));
                    item.setTpPrice(rs.getInt("tpPrice"));
                    item.setTpBrand(rs.getString("tpBrand"));
                    item.setTpModel(rs.getString("tpModel"));
                    item.setTpColor(rs.getString("tpColor"));
                    item.setTpMemory(rs.getString("tpMemory"));
                    item.setTpAvailable(rs.getInt("tpAvailable"));
                    item.setUserEmail(rs.getString("userEmail"));
                    item.setUserName(rs.getString("userName"));
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Items_tp getItemById(int id) {
        String SQL = "SELECT * FROM Items_tp WHERE tpID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Items_tp item = new Items_tp();
                    item.setTpID(rs.getInt("tpID"));
                    item.setTpName(rs.getString("tpName"));
                    item.setTpQuan(rs.getInt("tpQuan"));
                    item.setTpYear(rs.getInt("tpYear"));
                    item.setTpPrice(rs.getInt("tpPrice"));
                    item.setTpBrand(rs.getString("tpBrand"));
                    item.setTpModel(rs.getString("tpModel"));
                    item.setTpColor(rs.getString("tpColor"));
                    item.setTpMemory(rs.getString("tpMemory"));
                    item.setTpAvailable(rs.getInt("tpAvailable"));
                    item.setUserEmail(rs.getString("userEmail"));
                    item.setUserName(rs.getString("userName"));
                    return item;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<String> getUniqueBrands() {
        List<String> brands = new ArrayList<>();
        String SQL = "SELECT DISTINCT tpBrand FROM Items_tp";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                brands.add(rs.getString("tpBrand"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return brands;
    }

    public List<Items_tp> getAllItems() {
        List<Items_tp> list = new ArrayList<>();
        String SQL = "SELECT * FROM Items_tp";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Items_tp item = new Items_tp();
                item.setTpID(rs.getInt("tpID"));
                item.setTpName(rs.getString("tpName"));
                item.setTpQuan(rs.getInt("tpQuan"));
                item.setTpYear(rs.getInt("tpYear"));
                item.setTpPrice(rs.getInt("tpPrice"));
                item.setTpBrand(rs.getString("tpBrand"));
                item.setTpModel(rs.getString("tpModel"));
                item.setTpColor(rs.getString("tpColor"));
                item.setTpMemory(rs.getString("tpMemory"));
                item.setTpAvailable(rs.getInt("tpAvailable"));
                item.setUserEmail(rs.getString("userEmail"));
                item.setUserName(rs.getString("userName"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getImagePathByTpID(int tpID) {
        Tp_img_Dao imgDao = new Tp_img_Dao();
        Tp_img img = imgDao.getImageByTpID(tpID);
        return img != null ? "/uploads_tp/" + img.getTp_img_Name() : null;
    }

    public List<Items_tp> getItemsByBrand(String brand) {
        List<Items_tp> list = new ArrayList<>();
        String SQL = "SELECT * FROM Items_tp WHERE tpBrand = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, brand);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Items_tp item = new Items_tp();
                    item.setTpID(rs.getInt("tpID"));
                    item.setTpName(rs.getString("tpName"));
                    item.setTpQuan(rs.getInt("tpQuan"));
                    item.setTpYear(rs.getInt("tpYear"));
                    item.setTpPrice(rs.getInt("tpPrice"));
                    item.setTpBrand(rs.getString("tpBrand"));
                    item.setTpModel(rs.getString("tpModel"));
                    item.setTpColor(rs.getString("tpColor"));
                    item.setTpMemory(rs.getString("tpMemory"));
                    item.setTpAvailable(rs.getInt("tpAvailable"));
                    item.setUserEmail(rs.getString("userEmail"));
                    item.setUserName(rs.getString("userName"));
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Items_tp> searchItemsByName(String searchQuery) {
        List<Items_tp> list = new ArrayList<>();
        String SQL = "SELECT * FROM Items_tp WHERE tpName LIKE ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, "%" + searchQuery + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Items_tp item = new Items_tp();
                    item.setTpID(rs.getInt("tpID"));
                    item.setTpName(rs.getString("tpName"));
                    item.setTpQuan(rs.getInt("tpQuan"));
                    item.setTpYear(rs.getInt("tpYear"));
                    item.setTpPrice(rs.getInt("tpPrice"));
                    item.setTpBrand(rs.getString("tpBrand"));
                    item.setTpModel(rs.getString("tpModel"));
                    item.setTpColor(rs.getString("tpColor"));
                    item.setTpMemory(rs.getString("tpMemory"));
                    item.setTpAvailable(rs.getInt("tpAvailable"));
                    item.setUserEmail(rs.getString("userEmail"));
                    item.setUserName(rs.getString("userName"));
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Items_tp> getRecentItems(int limit) {
        List<Items_tp> list = new ArrayList<>();
        String SQL = "SELECT * FROM Items_tp ORDER BY tpID DESC LIMIT ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, limit);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Items_tp item = new Items_tp();
                    item.setTpID(rs.getInt("tpID"));
                    item.setTpName(rs.getString("tpName"));
                    item.setTpQuan(rs.getInt("tpQuan"));
                    item.setTpYear(rs.getInt("tpYear"));
                    item.setTpPrice(rs.getInt("tpPrice"));
                    item.setTpBrand(rs.getString("tpBrand"));
                    item.setTpModel(rs.getString("tpModel"));
                    item.setTpColor(rs.getString("tpColor"));
                    item.setTpMemory(rs.getString("tpMemory"));
                    item.setTpAvailable(rs.getInt("tpAvailable"));
                    item.setUserEmail(rs.getString("userEmail"));
                    item.setUserName(rs.getString("userName"));
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean isValidTpID(int tpID) {
        String SQL = "SELECT tpID FROM Items_tp WHERE tpID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, tpID);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateQuantity(int tpID, int newQuantity) {
        String SQL = "UPDATE Items_tp SET tpQuan = ? WHERE tpID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, newQuantity);
            pstmt.setInt(2, tpID);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    


}

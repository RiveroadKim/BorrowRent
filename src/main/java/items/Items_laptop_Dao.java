package items;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Items_laptop_Dao {
    private Connection conn;
    private ResultSet rs;

    public Items_laptop_Dao() {
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
        String SQL = "SELECT lapID FROM Items_laptop ORDER BY lapID DESC";
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

    public int write(String lapName, int lapQuan, int lapYear, int lapPrice, String lapBrand, String lapModel, String lapColor, String lapMemory, String lapGraphic, String lapOS, String lapCPU, String userName, String userEmail) {
        String SQL = "INSERT INTO Items_laptop VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, getNext());
            pstmt.setString(2, lapName);
            pstmt.setInt(3, lapQuan);
            pstmt.setInt(4, lapYear);
            pstmt.setInt(5, lapPrice);
            pstmt.setString(6, lapBrand);
            pstmt.setString(7, lapModel);
            pstmt.setString(8, lapColor);
            pstmt.setString(9, lapGraphic);
            pstmt.setString(10, lapOS);
            pstmt.setString(11, lapCPU);
            pstmt.setString(12, lapMemory);
            pstmt.setInt(13, 1); // lapAvailable
            pstmt.setString(14, userEmail);
            pstmt.setString(15, userName);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int getLastInsertedID() {
        String SQL = "SELECT lapID FROM Items_laptop ORDER BY lapID DESC LIMIT 1";
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

    public List<Items_laptop> getItemsByUserEmail(String userEmail) {
        List<Items_laptop> list = new ArrayList<>();
        String SQL = "SELECT * FROM Items_laptop WHERE userEmail = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, userEmail);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Items_laptop item = new Items_laptop();
                    setItemAttributes(item, rs);
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Items_laptop getItemById(int id) {
        String SQL = "SELECT * FROM Items_laptop WHERE lapID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Items_laptop item = new Items_laptop();
                    setItemAttributes(item, rs);
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
        String SQL = "SELECT DISTINCT lapBrand FROM Items_laptop";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                brands.add(rs.getString("lapBrand"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return brands;
    }

    public List<Items_laptop> getAllItems() {
        List<Items_laptop> list = new ArrayList<>();
        String SQL = "SELECT * FROM Items_laptop";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Items_laptop item = new Items_laptop();
                setItemAttributes(item, rs);
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getImagePathByLapID(int lapID) {
        Laptop_img_Dao imgDao = new Laptop_img_Dao();
        Laptop_img img = imgDao.getImageByLapID(lapID);
        return img != null ? "/uploads_laptop/" + img.getLap_img_Name() : null;
    }

    public List<Items_laptop> getItemsByBrand(String brand) {
        List<Items_laptop> list = new ArrayList<>();
        String SQL = "SELECT * FROM Items_laptop WHERE lapBrand = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, brand);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Items_laptop item = new Items_laptop();
                    setItemAttributes(item, rs);
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Items_laptop> searchItemsByName(String searchQuery) {
        List<Items_laptop> list = new ArrayList<>();
        String SQL = "SELECT * FROM Items_laptop WHERE lapName LIKE ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setString(1, "%" + searchQuery + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Items_laptop item = new Items_laptop();
                    setItemAttributes(item, rs);
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private void setItemAttributes(Items_laptop item, ResultSet rs) throws Exception {
        item.setLapID(rs.getInt("lapID"));
        item.setLapName(rs.getString("lapName"));
        item.setLapQuan(rs.getInt("lapQuan"));
        item.setLapYear(rs.getInt("lapYear"));
        item.setLapPrice(rs.getInt("lapPrice"));
        item.setLapBrand(rs.getString("lapBrand"));
        item.setLapModel(rs.getString("lapModel"));
        item.setLapColor(rs.getString("lapColor"));
        item.setLapGraphic(rs.getString("lapGraphic"));
        item.setLapOS(rs.getString("lapOS"));
        item.setLapCPU(rs.getString("lapCPU"));
        item.setLapMemory(rs.getString("lapMemory"));
        item.setLapAvailable(rs.getInt("lapAvailable"));
        item.setUserEmail(rs.getString("userEmail"));
        item.setUserName(rs.getString("userName"));
    }
    
    public List<Items_laptop> getRecentItems(int limit) {
        List<Items_laptop> list = new ArrayList<>();
        String SQL = "SELECT * FROM Items_laptop ORDER BY lapID DESC LIMIT ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, limit);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Items_laptop item = new Items_laptop();
                    item.setLapID(rs.getInt("lapID"));
                    item.setLapName(rs.getString("lapName"));
                    item.setLapQuan(rs.getInt("lapQuan"));
                    item.setLapYear(rs.getInt("lapYear"));
                    item.setLapPrice(rs.getInt("lapPrice"));
                    item.setLapBrand(rs.getString("lapBrand"));
                    item.setLapModel(rs.getString("lapModel"));
                    item.setLapColor(rs.getString("lapColor"));
                    item.setLapGraphic(rs.getString("lapGraphic"));
                    item.setLapOS(rs.getString("lapOS"));
                    item.setLapCPU(rs.getString("lapCPU"));
                    item.setLapMemory(rs.getString("lapMemory"));
                    item.setLapAvailable(rs.getInt("lapAvailable"));
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
    
    public boolean isValidLaptopID(int lapID) {
        String SQL = "SELECT lapID FROM Items_laptop WHERE lapID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, lapID);
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
 
    public boolean updateQuantity(int lapID, int newQuantity) {
        String SQL = "UPDATE Items_laptop SET lapQuan = ? WHERE lapID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            pstmt.setInt(1, newQuantity);
            pstmt.setInt(2, lapID);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    

}

package items;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Laptop_img_Dao {
    private Connection conn;
    private ResultSet rs;

    public Laptop_img_Dao() {
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

    public int getNext_img() {
        String SQL = "SELECT lap_img_ID FROM Laptop_img ORDER BY lap_img_ID DESC";
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
            return 1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return -1;
    }

    public int upload(String lap_img_Name, int lapID, String lap_img_Path) {
        String SQL = "INSERT INTO Laptop_img VALUES(?, ?, ?, ?)";
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext_img());
            pstmt.setString(2, lap_img_Name);
            pstmt.setInt(3, lapID);
            pstmt.setString(4, lap_img_Path);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        return -1;
    }
    
    public Laptop_img getImageByLapID(int lapID) {
        String SQL = "SELECT * FROM Laptop_img WHERE lapID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, lapID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Laptop_img img = new Laptop_img();
                img.setLap_img_Name(rs.getString("lap_img_Name"));
                img.setLap_img_path(rs.getString("lap_img_Path"));
                return img;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean updateUserName(String userEmail, String newName) {
        String SQL = "UPDATE Items_laptop SET userName = ? WHERE userEmail = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, newName);
            pstmt.setString(2, userEmail);
            int result = pstmt.executeUpdate();
            System.out.println("Update Items_laptop result: " + result);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

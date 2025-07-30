package items;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Tp_img_Dao {
    private Connection conn;
    private ResultSet rs;

    public Tp_img_Dao() {
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

    public int getNext_img() {
        String SQL = "SELECT tp_img_ID FROM Tp_img ORDER BY tp_img_ID DESC";
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
            closeResources(pstmt, rs);
        }
        return -1;
    }

    public int upload(String tp_img_Name, int tpID, String tp_img_Path) {
        String SQL = "INSERT INTO Tp_img VALUES(?, ?, ?, ?)";
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext_img());
            pstmt.setString(2, tp_img_Name);
            pstmt.setInt(3, tpID);
            pstmt.setString(4, tp_img_Path);

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(pstmt, null);
        }
        return -1;
    }

    public Tp_img getImageByTpID(int tpID) {
        String SQL = "SELECT * FROM Tp_img WHERE tpID = ?";
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, tpID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Tp_img img = new Tp_img();
                img.setTp_img_Name(rs.getString("tp_img_Name"));
                img.setTp_img_path(rs.getString("tp_img_Path"));
                return img;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(pstmt, rs);
        }
        return null;
    }

    public boolean updateUserName(String userEmail, String newName) {
        String SQL = "UPDATE Items_tp SET userName = ? WHERE userEmail = ?";
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, newName);
            pstmt.setString(2, userEmail);
            int result = pstmt.executeUpdate();
            System.out.println("Update Items_tp result: " + result);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(pstmt, null);
        }
        return false;
    }
}

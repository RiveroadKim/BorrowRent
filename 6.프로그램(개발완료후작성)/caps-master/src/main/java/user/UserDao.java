package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDao() {
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

    public int login(String userEmail, String userPassword) {
        String SQL = "SELECT userPassword FROM USER WHERE userEmail = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userEmail);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    return 1;
                } else {
                    return 0; // 비밀번호 불일치
                }
            }
            return -1; // 이메일 없음
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 데이터베이스 오류
    }

    public int join(User user) {
        String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserEmail());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserBirth());
            pstmt.setString(6, user.getUserPnum());
            pstmt.setString(7, user.getUserAddress());
            pstmt.setString(8, user.getUserStudent());

            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }

    public User getUserByEmail(String userEmail) {
        String SQL = "SELECT * FROM USER WHERE userEmail = ?";
        User user = new User();
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userEmail);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user.setUserEmail(rs.getString("userEmail"));
                user.setUserPassword(rs.getString("userPassword"));
                user.setUserName(rs.getString("userName"));
                user.setUserGender(rs.getString("userGender"));
                user.setUserBirth(rs.getString("userBirth"));
                user.setUserPnum(rs.getString("userPnum"));
                user.setUserAddress(rs.getString("userAddress"));
                user.setUserStudent(rs.getString("userStudent"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean updateUserInfo(String currentEmail, String currentPassword, String newPassword, String newName, String newBirth, String newPnum, String newAddress) {
        String SQL = "UPDATE USER SET ";
        boolean firstField = true;
        
        if (newPassword != null && !newPassword.isEmpty()) {
            SQL += "userPassword = ?";
            firstField = false;
        }
        if (newName != null && !newName.isEmpty()) {
            if (!firstField) SQL += ", ";
            SQL += "userName = ?";
            firstField = false;
        }
        if (newBirth != null && !newBirth.isEmpty()) {
            if (!firstField) SQL += ", ";
            SQL += "userBirth = ?";
            firstField = false;
        }
        if (newPnum != null && !newPnum.isEmpty()) {
            if (!firstField) SQL += ", ";
            SQL += "userPnum = ?";
            firstField = false;
        }
        if (newAddress != null && !newAddress.isEmpty()) {
            if (!firstField) SQL += ", ";
            SQL += "userAddress = ?";
        }
        
        SQL += " WHERE userEmail = ? AND userPassword = ?";
        
        try {
            pstmt = conn.prepareStatement(SQL);
            int index = 1;

            if (newPassword != null && !newPassword.isEmpty()) {
                pstmt.setString(index++, newPassword);
            }
            if (newName != null && !newName.isEmpty()) {
                pstmt.setString(index++, newName);
            }
            if (newBirth != null && !newBirth.isEmpty()) {
                pstmt.setString(index++, newBirth);
            }
            if (newPnum != null && !newPnum.isEmpty()) {
                pstmt.setString(index++, newPnum);
            }
            if (newAddress != null && !newAddress.isEmpty()) {
                pstmt.setString(index++, newAddress);
            }
            
            pstmt.setString(index++, currentEmail);
            pstmt.setString(index, currentPassword);

            int result = pstmt.executeUpdate();
            
            if (result > 0 && newName != null && !newName.isEmpty()) {
                updateItemsUserName(currentEmail, newName);
            }
            
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private void updateItemsUserName(String userEmail, String newUserName) {
        String SQL1 = "UPDATE Items_laptop SET userName = ? WHERE userEmail = ?";
        String SQL2 = "UPDATE Items_tp SET userName = ? WHERE userEmail = ?";
        try {
            pstmt = conn.prepareStatement(SQL1);
            pstmt.setString(1, newUserName);
            pstmt.setString(2, userEmail);
            pstmt.executeUpdate();

            pstmt = conn.prepareStatement(SQL2);
            pstmt.setString(1, newUserName);
            pstmt.setString(2, userEmail);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
}

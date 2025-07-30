package alarm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AlarmDao {
    private Connection conn;
    private ResultSet rs;

    public AlarmDao() {
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

    public void addAlarm(String userEmail, String title) {
        String sql = "INSERT INTO alarm (userEmail, title) VALUES (?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userEmail);
            pstmt.setString(2, title);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Alarm> getAlarmsByUserEmail(String userEmail) {
        List<Alarm> alarms = new ArrayList<>();
        String sql = "SELECT * FROM alarm WHERE userEmail = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userEmail);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Alarm alarm = new Alarm();
                alarm.setUserEmail(rs.getString("userEmail"));
                alarm.setTitle(rs.getString("title"));
                alarms.add(alarm);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return alarms;
    }

    // 모든 사용자에게 알림 추가 메서드
    public void addAlarmToAllUsers(String title) {
        String sql = "INSERT INTO alarm (userEmail, title) SELECT userEmail, ? FROM user";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, title);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

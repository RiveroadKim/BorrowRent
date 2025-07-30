package notice;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import alarm.AlarmDao;

public class NoticeDao {
    public Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public NoticeDao() {
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

    public List<Notice> getAllNotices() {
        List<Notice> notices = new ArrayList<>();
        String SQL = "SELECT * FROM notice ORDER BY date DESC";
        try {
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Notice notice = new Notice();
                notice.setUserEmail(rs.getString("userEmail"));
                notice.setTitle(rs.getString("title"));
                notice.setContent(rs.getString("content"));
                notice.setDate(rs.getString("date"));
                notices.add(notice);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return notices;
    }

    public List<Notice> getNoticesByTitle(String searchKeyword) {
        List<Notice> notices = new ArrayList<>();
        String SQL = "SELECT * FROM notice WHERE title LIKE ? ORDER BY date DESC";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, "%" + searchKeyword + "%");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Notice notice = new Notice();
                notice.setUserEmail(rs.getString("userEmail"));
                notice.setTitle(rs.getString("title"));
                notice.setContent(rs.getString("content"));
                notice.setDate(rs.getString("date"));
                notices.add(notice);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return notices;
    }

    public List<String> getAllNoticeTitles() {
        List<String> titles = new ArrayList<>();
        String SQL = "SELECT title FROM notice";
        try {
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                titles.add(rs.getString("title"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return titles;
    }

    public void addNotice(String title, String content, String userEmail) {
        String SQL = "INSERT INTO notice (userEmail, title, content, date) VALUES (?, ?, ?, NOW())";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userEmail);
            pstmt.setString(2, title);
            pstmt.setString(3, content);
            pstmt.executeUpdate();

            // 알림 추가
            AlarmDao alarmDao = new AlarmDao();
            String alarmTitle = "새로운 공지사항이 올라왔습니다: <a href='${pageContext.request.contextPath}/template/notice_detail.jsp?title=" + title + "'>" + title + "</a>";
            alarmDao.addAlarmToAllUsers(alarmTitle);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Notice getNoticeByTitle(String title) {
        Notice notice = null;
        String SQL = "SELECT * FROM notice WHERE title = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, title);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                notice = new Notice();
                notice.setUserEmail(rs.getString("userEmail"));
                notice.setTitle(rs.getString("title"));
                notice.setContent(rs.getString("content"));
                notice.setDate(rs.getString("date"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return notice;
    }
}

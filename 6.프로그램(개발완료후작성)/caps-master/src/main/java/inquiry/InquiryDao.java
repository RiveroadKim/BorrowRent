package inquiry;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class InquiryDao {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public InquiryDao() {
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

    public boolean insertInquiry(String userEmail, String title, String content, String date) {
        String SQL = "INSERT INTO inquiry (userEmail, title, content, date) VALUES (?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userEmail);
            pstmt.setString(2, title);
            pstmt.setString(3, content);
            pstmt.setString(4, date);
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Inquiry> getInquiriesByUserEmail(String userEmail) {
        List<Inquiry> inquiries = new ArrayList<>();
        String SQL = "SELECT * FROM inquiry WHERE userEmail = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userEmail);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Inquiry inquiry = new Inquiry();
                inquiry.setUserEmail(rs.getString("userEmail"));
                inquiry.setTitle(rs.getString("title"));
                inquiry.setContent(rs.getString("content"));
                inquiry.setDate(rs.getString("date"));
                inquiry.setAnswer(rs.getString("answer"));
                inquiry.setResponse(rs.getString("response"));
                inquiries.add(inquiry);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inquiries;
    }

    public Inquiry getInquiryDetail(String userEmail, String title) {
        Inquiry inquiry = null;
        String SQL = "SELECT * FROM inquiry WHERE userEmail = ? AND title = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userEmail);
            pstmt.setString(2, title);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                inquiry = new Inquiry();
                inquiry.setUserEmail(rs.getString("userEmail"));
                inquiry.setTitle(rs.getString("title"));
                inquiry.setContent(rs.getString("content"));
                inquiry.setDate(rs.getString("date"));
                inquiry.setAnswer(rs.getString("answer"));
                inquiry.setResponse(rs.getString("response"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inquiry;
    }

    public List<Inquiry> getAllInquiries() {
        List<Inquiry> inquiries = new ArrayList<>();
        String SQL = "SELECT * FROM inquiry";
        try {
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Inquiry inquiry = new Inquiry();
                inquiry.setUserEmail(rs.getString("userEmail"));
                inquiry.setTitle(rs.getString("title"));
                inquiry.setContent(rs.getString("content"));
                inquiry.setDate(rs.getString("date"));
                inquiry.setAnswer(rs.getString("answer"));
                inquiry.setResponse(rs.getString("response"));
                inquiries.add(inquiry);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inquiries;
    }

    public Inquiry getInquiryDetailForAdmin(String title) {
        Inquiry inquiry = null;
        String SQL = "SELECT * FROM inquiry WHERE title = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, title);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                inquiry = new Inquiry();
                inquiry.setUserEmail(rs.getString("userEmail"));
                inquiry.setTitle(rs.getString("title"));
                inquiry.setContent(rs.getString("content"));
                inquiry.setDate(rs.getString("date"));
                inquiry.setAnswer(rs.getString("answer"));
                inquiry.setResponse(rs.getString("response"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return inquiry;
    }

    public boolean updateInquiryResponse(String userEmail, String title, String response) {
        String SQL = "UPDATE inquiry SET response = ?, answer = '처리완료' WHERE userEmail = ? AND title = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, response);
            pstmt.setString(2, userEmail);
            pstmt.setString(3, title);
            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

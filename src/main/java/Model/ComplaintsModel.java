package Model;

import Dto.Complaints;
import Util.DataSource;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComplaintsModel {

    public boolean addComplaint(Complaints complaint) {
        String sql = "INSERT INTO complaints (user_id, subject, description, status, date_submitted) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, complaint.getUserId());
            stmt.setString(2, complaint.getSubject());
            stmt.setString(3, complaint.getDescription());
            stmt.setString(4, complaint.getStatus());
            stmt.setTimestamp(5, new Timestamp(complaint.getDate_submitted().getTime()));

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update a complaint
    public boolean updateComplaint(Complaints complaint) throws SQLException {
        String sql = "UPDATE complaints SET subject = ?, description = ? WHERE id = ?";

        try (Connection conn = DataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, complaint.getSubject());
            stmt.setString(2, complaint.getDescription());
            stmt.setInt(3, complaint.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            throw e;
        }
    }

    public boolean updateComplaintStatus(int id, String status) throws SQLException {
        String sql = "UPDATE complaints SET status = ? WHERE id = ?";

        try (Connection conn = DataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
//            stmt.setString(2, remarks);
            stmt.setInt(2, id);

            return stmt.executeUpdate() > 0;
        }
    }

    // Use this method for deleting by complaint ID
    public boolean deleteComplaint(int id) {
        String sql = "DELETE FROM complaints WHERE id = ?";
        try (Connection conn = DataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get a complaint by ID
    public Complaints getComplaintById(int id) throws SQLException {
        String sql = "SELECT * FROM complaints WHERE id = ?";
        try (Connection conn = DataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Complaints c = new Complaints();
                c.setId(rs.getInt("id"));
                c.setUserId(rs.getInt("user_id"));
                c.setSubject(rs.getString("subject"));
                c.setDescription(rs.getString("description"));
                c.setStatus(rs.getString("status"));
                c.setRemarks(rs.getString("remarks"));
                c.setDate_submitted(rs.getTimestamp("date_submitted"));

                return c;
            }

        }
        return null;
    }

    // Get all complaints for a user
    public List<Complaints> getComplaintsByUser(String userId) {
        List<Complaints> list = new ArrayList<>();
        String sql = "SELECT * FROM complaints WHERE user_id = ? ORDER BY date_submitted DESC";

        try (Connection conn = DataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Complaints c = new Complaints();
                c.setId(rs.getInt("id"));
                c.setUserId(rs.getInt("user_id"));
                c.setSubject(rs.getString("subject"));
                c.setDescription(rs.getString("description"));
                c.setStatus(rs.getString("status"));
                c.setRemarks(rs.getString("remarks"));
                c.setDate_submitted(rs.getTimestamp("date_submitted"));

                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Complaints> getAllComplaints() throws SQLException {
        List<Complaints> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaints ORDER BY date_submitted DESC";

        try (Connection conn = DataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Complaints complaint = new Complaints();
                complaint.setId(rs.getInt("id"));
                complaint.setSubject(rs.getString("subject"));
                complaint.setDescription(rs.getString("description"));
                complaint.setUserId(rs.getInt("user_id"));
                complaint.setDate_submitted(rs.getDate("date_submitted"));
                complaint.setStatus(rs.getString("status"));
                complaint.setRemarks(rs.getString("remarks"));
                complaints.add(complaint);
            }
        }

        return complaints;
    }

    public boolean deleteComplaintById(int complaintId) {
        String sql = "DELETE FROM complaints WHERE id = ?";

        try (Connection conn = DataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, complaintId);
            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateComplaintStatusAndRemarks(int id, String status, String remarks) throws SQLException {
        String sql = "UPDATE complaints SET status = ?, remarks = ? WHERE id = ?";

        try (Connection conn = DataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setString(2, remarks);
            stmt.setInt(3, id);

            return stmt.executeUpdate() > 0;
        }
    }
}
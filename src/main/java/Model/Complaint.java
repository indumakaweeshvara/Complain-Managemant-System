package Model;

public class Complaint {
    private int id;
    private String title;
    private String description;
    private String status;
    private String username;

    public Complaint() {
    }

    public Complaint(int id, String title, String description, String status, String username) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.status = status;
        this.username = username;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setUserId(int id) {
    }

    public void setRemarks(String remarks) {
    }
}
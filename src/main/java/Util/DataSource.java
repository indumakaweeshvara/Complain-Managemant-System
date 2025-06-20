package Util;

import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DataSource {
    private static BasicDataSource basicDataSource = new BasicDataSource();

    static {
        basicDataSource.setUrl("jdbc:mysql://localhost:3306/complaint_management_system");
        basicDataSource.setUsername("root");
        basicDataSource.setPassword("Ijse@1234");
        basicDataSource.setMinIdle(5);
        basicDataSource.setMaxIdle(50);
        basicDataSource.setMaxOpenPreparedStatements(100);

        basicDataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
    }

    public static Connection getConnection() throws SQLException {
        return basicDataSource.getConnection();
    }
}

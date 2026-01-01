package aos.dao;

import java.sql.*;

public class DatabaseProvider {

    static Connection connection = null;
    static String url = "jdbc:mysql://localhost:3306/";
    static String userName = "root";
    static String password = "deAlto#Crack357";

    public static Connection getConn() {
        String createDatabase = "create database if not exists construction_hub;";
        String useDatabase = "use construction_hub;";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, userName, password);
            Statement stmt = connection.createStatement();
            stmt.executeUpdate(createDatabase);
            stmt.executeUpdate(useDatabase);
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver not found: " + e.getMessage());
            e.printStackTrace();
            connection = null;
        } catch (SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("SQL State: " + e.getSQLState());
            e.printStackTrace();
            connection = null;
        }
        return connection;
    }
}

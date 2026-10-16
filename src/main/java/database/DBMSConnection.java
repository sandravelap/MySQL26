package database;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBMSConnection {

    private static final String URL_SGBD = "jdbc:mariadb://localhost:3006";
    private static final String USER = "root";
    private static final String PASSWORD = "admin";
    public Connection connect() throws SQLException {

        Connection connection  = DriverManager.getConnection(URL_SGBD,USER,PASSWORD);

        return connection;
    }

}

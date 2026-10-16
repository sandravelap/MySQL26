package database;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL_BD = "jdbc:mariadb://localhost:3006/CHRuben";
    private static final String USER = "root";
    private static final String PASSWORD = "admin";
    public Connection connect() throws SQLException {

        Connection connection  = DriverManager.getConnection(URL_BD,USER,PASSWORD);

        return connection;
    }

}

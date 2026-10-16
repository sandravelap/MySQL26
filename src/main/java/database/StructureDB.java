package database;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class StructureDB {
    public String createDB (String nameDB){
        String message ="";
        DBMSConnection dbmsConnection = new DBMSConnection();
        //try with resources -- > la conexión siempre se cerrará
        try(Connection myCon = dbmsConnection.connect()) {
            Statement stmtCreateDB = myCon.createStatement();
            stmtCreateDB.executeUpdate("CREATE DATABASE IF NOT EXISTS " + nameDB );
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return message;
    }
    public String createTables (){
        String message = "";
        DBConnection dbConnection = new DBConnection();
        try (Connection myCon = dbConnection.connect()) {

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return message;
    }
}

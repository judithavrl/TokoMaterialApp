/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package koneksi;

import com.mysql.jdbc.Driver;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author User
 */

public class koneksi_db {
    private static Connection koneksi;
    
    public static Connection getConnection() {
        Connection conn = null;
        String url = "jdbc:mysql://localhost:3306/penjualantokomaterial_db";
        String user = "root";
        String password = "";
        try {
            conn = DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            System.out.println(e);
        }
        return conn;
    }
    //public static Connection GetConnection() throws SQLException{
      //  if(koneksi==null){
        //    new Driver();
            
          //  koneksi=DriverManager.getConnection("jdbc:mysql://localhost:3306/penjualantokomaterial_db", "root", "");
        //}
        //return koneksi;
    //}
    public static void main(String args[]) { 
        try {
            Connection c = koneksi_db.getConnection();
            System.out.println(String.format("Connected to database %s " + "successfully.", c.getCatalog()));
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    
}


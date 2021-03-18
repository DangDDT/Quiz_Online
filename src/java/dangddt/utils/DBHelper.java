/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.utils;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Tam Dang
 */
public class DBHelper implements Serializable {

    public static Connection makeConnection() throws ClassNotFoundException, SQLException, NamingException{
        Context ctx = new InitialContext();
        Context envCtx = (Context) ctx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("QuizOnlineDB");
        Connection con = ds.getConnection();
        return con;
    }
}

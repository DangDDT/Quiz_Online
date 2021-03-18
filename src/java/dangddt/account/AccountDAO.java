/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.account;

import static dangddt.submission.SubmissionDAO.closeConnection;
import dangddt.submission.SubmissionDTO;
import dangddt.utils.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import javax.naming.NamingException;

/**
 *
 * @author Tam Dang
 */
public class AccountDAO implements Serializable {

    public static void closeConnection(Connection con, PreparedStatement stm, ResultSet rs) throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (stm != null) {
            stm.close();
        }
        if (con != null) {
            con.close();
        }
    }

    public static boolean registerStudent(String email, String password, String name) throws SQLException, NamingException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Insert Account Values (?,?,?,'student','new')";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, name);
                stm.setString(3, password);
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return false;
    }

    public static AccountDTO checkLogin(String email, String password)
            throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT email, name, password, role, status\n"
                        + "FROM Account\n"
                        + "WHERE email = ? AND password= ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, password);
                rs = stm.executeQuery();
                AccountDTO dto;
                if (rs.next()) {
                    dto = new AccountDTO(rs.getString("email").trim(), rs.getString("name").trim(), rs.getString("password").trim(), rs.getString("role").trim(), rs.getString("status").trim());
                    return dto;
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return null;
    }

    public static AccountDTO getStudentByEmail(String email) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<SubmissionDTO> results = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT email, name, password, role, status\n"
                        + "FROM Account\n"
                        + "WHERE email = ?";
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    stm.setString(1, email);
                    rs = stm.executeQuery();
                    if (rs != null) {
                        if (rs.next()) {
                           AccountDTO dto = new AccountDTO(rs.getString("email").trim(), rs.getString("name").trim(), rs.getString("password").trim(), rs.getString("role").trim(), rs.getString("status").trim());
                           return dto;
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return null;
    }
}

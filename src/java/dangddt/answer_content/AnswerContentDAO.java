/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.answer_content;

import dangddt.utils.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;
import javax.naming.NamingException;

/**
 *
 * @author Tam Dang
 */
public class AnswerContentDAO implements Serializable {

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

    public static Vector<AnswerContentDTO> getAnswersByQuestion(String questionID)
            throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<AnswerContentDTO> results = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT answer_ID, answer_content, isCorrect\n"
                        + "FROM Answer_Content\n"
                        + "WHERE questionID = ?";
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    stm.setString(1, questionID);
                    rs = stm.executeQuery();
                    if (rs != null) {
                        results = new Vector();
                        while (rs.next()) {
                            results.add(new AnswerContentDTO(rs.getString("answer_ID"), rs.getString("answer_content"), rs.getBoolean("isCorrect")));
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return results;
    }
    public static AnswerContentDTO getAnswersByAnswerID(String answerID)
            throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        AnswerContentDTO results = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT answer_ID, answer_content, isCorrect\n"
                        + "FROM Answer_Content\n"
                        + "WHERE answer_ID = ?";
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    stm.setString(1, answerID);
                    rs = stm.executeQuery();
                    if (rs != null) {
                        if (rs.next()) {
                            results = new AnswerContentDTO(rs.getString("answer_ID"), rs.getString("answer_content"), rs.getBoolean("isCorrect"));
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return results;
    }

    public static String convertToAnswerID(String str, String questionID) {
        String answerID = null;
        answerID = 'A' + questionID.substring(1) + "_" + str;
        return answerID;
    }

    public static void insert(AnswerContentDTO answer, String questionID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT Answer_Content VALUES(?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, convertToAnswerID(answer.getAnswerID(), questionID));
                stm.setString(2, answer.getAnswer_content());
                stm.setString(3, questionID);
                stm.setInt(4, (answer.isIsCorrect()) ? 1 : 0);
                if (stm != null) {
                    stm.executeUpdate();
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
    }

    /*public static int resetDefault(String questionID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int row = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE Answer_Content SET isCorrect = 0 WHERE questionID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, questionID);
                if (stm != null) {
                    row = stm.executeUpdate();
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return row;
    }*/

    public static int update(AnswerContentDTO answer, String questionID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int row = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE Answer_Content SET answer_content=?, isCorrect=? WHERE answer_ID=?";
                stm = con.prepareStatement(sql);
                stm.setString(3, answer.getAnswerID());
                stm.setString(1, answer.getAnswer_content());
                stm.setInt(2, (answer.isIsCorrect()) ? 1 : 0);
                if (stm != null) {
                    row = stm.executeUpdate();
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return row;
    }
}

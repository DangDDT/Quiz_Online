/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.question;

import dangddt.answer_content.AnswerContentDAO;
import dangddt.answer_content.AnswerContentDTO;
import dangddt.utils.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import javax.naming.NamingException;

/**
 *
 * @author Tam Dang
 */
public class QuestionDAO implements Serializable {

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

    public static int countQuestions(String keyword, int status, String subjectID) throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int count = -1;
        String sql = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                if (keyword != null && subjectID == null && status == -1) {
                    sql = "SELECT COUNT(questionID)\n"
                            + "FROM Question\n"
                            + "WHERE question_content LIKE ?";
                    stm = con.prepareStatement(sql);
                    if (stm != null) {
                        stm.setString(1, "%" + keyword + "%");
                        rs = stm.executeQuery();
                        if (rs != null) {
                            if (rs.next()) {
                                count = rs.getInt(1);
                            }
                        }
                    }
                } else if (keyword == null && subjectID == null && status != -1) {
                    sql = "SELECT COUNT(questionID)\n"
                            + "FROM Question\n"
                            + "WHERE status = ?";
                    stm = con.prepareStatement(sql);
                    if (stm != null) {
                        stm.setInt(1, status);
                        rs = stm.executeQuery();
                        if (rs != null) {
                            if (rs.next()) {
                                count = rs.getInt(1);
                            }
                        }
                    }
                } else if (keyword == null && status == -1 && subjectID != null) {
                    sql = "SELECT COUNT (questionID)\n"
                            + "FROM Question\n"
                            + "WHERE subjectID = ?";
                    stm = con.prepareStatement(sql);
                    if (stm != null) {
                        stm.setString(1, subjectID);
                        rs = stm.executeQuery();
                        if (rs != null) {
                            if (rs.next()) {
                                count = rs.getInt(1);
                            }
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return count;
    }
    public static String getQuestionContentByQuestionID(String questionID) throws SQLException, ClassNotFoundException, NamingException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String question_content = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT question_content\n"
                        + "FROM Question\n"
                        + "WHERE questionID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, questionID);
                if (stm != null) {
                    rs = stm.executeQuery();
                    if (rs != null) {
                        if (rs.next()) {
                            question_content = rs.getString(1);
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return question_content;
    }
    public static Vector<QuestionDTO> getQuestionsByName(String keyword, String subjectID, int pageIndex, int maxRowInPage)
            throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<QuestionDTO> results = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT questionID, question_content, created_date, subjectID, status, isUsed\n"
                        + "FROM Question\n"
                        + "WHERE question_content LIKE ? AND subjectID = ?\n"
                        + "ORDER BY question_content ASC\n"
                        + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    stm.setString(1, "%" + keyword + "%");
                    stm.setString(2, subjectID);
                    stm.setInt(3, (pageIndex - 1) * maxRowInPage);
                    stm.setInt(4, maxRowInPage);
                    rs = stm.executeQuery();
                    if (rs != null) {
                        results = new Vector();
                        while (rs.next()) {
                            Vector<AnswerContentDTO> answersOfQuestion = AnswerContentDAO.getAnswersByQuestion(rs.getString("questionID"));
                            results.add(new QuestionDTO(rs.getString("questionID"), rs.getString("question_content"), answersOfQuestion, rs.getDate("created_date"),
                                    rs.getString("subjectID"), rs.getBoolean("status"), rs.getBoolean("isUsed")));
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return results;
    }

    public static Vector<QuestionDTO> getQuestionsByStatus(boolean status, String subjectID, int pageIndex, int maxRowInPage)
            throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<QuestionDTO> results = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT questionID, question_content, created_date, subjectID, status, isUsed\n"
                        + "FROM Question\n"
                        + "WHERE status = ? AND subjectID = ?\n"
                        + "ORDER BY question_content ASC\n"
                        + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    stm.setInt(1, (status) ? 1 : 0);
                    stm.setString(2, subjectID);
                    stm.setInt(3, (pageIndex - 1) * maxRowInPage);
                    stm.setInt(4, maxRowInPage);
                    rs = stm.executeQuery();
                    if (rs != null) {
                        results = new Vector();
                        while (rs.next()) {
                            Vector<AnswerContentDTO> answersOfQuestion = AnswerContentDAO.getAnswersByQuestion(rs.getString("questionID"));
                            results.add(new QuestionDTO(rs.getString("questionID"), rs.getString("question_content"), answersOfQuestion, rs.getDate("created_date"),
                                    rs.getString("subjectID"), rs.getBoolean("status"), rs.getBoolean("isUsed")));
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return results;
    }

    public static Vector<QuestionDTO> getQuestionsBySubject(String subjectID, int pageIndex, int maxRowInPage)
            throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<QuestionDTO> results = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT questionID, question_content, created_date, subjectID, status, isUsed\n"
                        + "FROM Question\n"
                        + "WHERE subjectID = ?\n"
                        + "ORDER BY question_content ASC\n"
                        + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";;
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    stm.setString(1, subjectID);
                    stm.setInt(2, (pageIndex - 1) * maxRowInPage);
                    stm.setInt(3, maxRowInPage);
                    rs = stm.executeQuery();
                    if (rs != null) {
                        results = new Vector();
                        while (rs.next()) {
                            Vector<AnswerContentDTO> answersOfQuestion = AnswerContentDAO.getAnswersByQuestion(rs.getString("questionID"));
                            results.add(new QuestionDTO(rs.getString("questionID"), rs.getString("question_content"), answersOfQuestion, rs.getDate("created_date"),
                                    rs.getString("subjectID"), rs.getBoolean("status"), rs.getBoolean("isUsed")));
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return results;
    }

    public static String getNewQuestionID() throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String newID = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT CONCAT('Q',SUBSTRING('000000',1,6-LEN(CAST(SUBSTRING(MAX(questionID),2,6) AS INT)+1)),CAST(SUBSTRING(MAX(questionID),2,6) AS INT)+1)\n"
                        + "FROM Question";
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    rs = stm.executeQuery();
                    if (rs != null) {
                        if (rs.next()) {
                            newID = rs.getString(1);
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return newID;
    }

    /**
     *
     * @param question_content
     * @param subjectID
     * @param answers
     * @param correctAnswer
     * @return
     * @throws SQLException
     * @throws ClassNotFoundException
     * @throws NamingException
     */
    public static String insert(String question_content, String subjectID, Vector<AnswerContentDTO> answers) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String questionID = getNewQuestionID();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql_insert_question = "INSERT Question VALUES (?,?,GETDATE(),?,1,0)";
                stm = con.prepareStatement(sql_insert_question);
                stm.setString(1, questionID);
                stm.setString(2, question_content);
                stm.setString(3, subjectID);
                if (stm != null) {
                    int row = stm.executeUpdate();
                    if (row > 0) {
                        for (AnswerContentDTO answer : answers) {
                            AnswerContentDAO.insert(answer, questionID);
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return questionID;
    }

    public static String update(String questionID, String question_content, String subjectID, Vector<AnswerContentDTO> answers) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql_update_question = "UPDATE Question SET question_content = ?, subjectID = ? where questionID = ? ";
                stm = con.prepareStatement(sql_update_question);
                stm.setString(3, questionID);
                stm.setString(1, question_content);
                stm.setString(2, subjectID);
                if (stm != null) {
                    int row = stm.executeUpdate();
                    if (row > 0) {
                        for (AnswerContentDTO answer : answers) {
                            AnswerContentDAO.update(answer, questionID);
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return questionID;
    }

    public static String delete(String questionID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql_delete_question = "UPDATE Question SET status = 0 where questionID = ? ";
                stm = con.prepareStatement(sql_delete_question);
                stm.setString(1, questionID);
                if (stm != null) {
                    int row = stm.executeUpdate();
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return questionID;
    }

    public static String restore(String questionID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql_restore_question = "UPDATE Question SET status = 1 where questionID = ? ";
                stm = con.prepareStatement(sql_restore_question);
                stm.setString(1, questionID);
                if (stm != null) {
                    int row = stm.executeUpdate();
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return questionID;
    }

    public static Vector<QuestionDTO> loadQuestionForQuiz(String subjectID, int num_of_question)
            throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<QuestionDTO> results = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT questionID, question_content, created_date, subjectID, status, isUsed\n"
                        + "FROM Question\n"
                        + "WHERE subjectID = ? and status = 1\n"
                        + "ORDER BY NEWID()\n"
                        + "OFFSET 0 ROWS FETCH NEXT ? ROWS ONLY";
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    stm.setString(1, subjectID);
                    stm.setInt(2, num_of_question);
                    rs = stm.executeQuery();
                    if (rs != null) {
                        results = new Vector();
                        while (rs.next()) {
                            Vector<AnswerContentDTO> answersOfQuestion = AnswerContentDAO.getAnswersByQuestion(rs.getString("questionID"));
                            results.add(new QuestionDTO(rs.getString("questionID"), rs.getString("question_content"), answersOfQuestion, rs.getDate("created_date"),
                                    rs.getString("subjectID"), rs.getBoolean("status"), rs.getBoolean("isUsed")));
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return results;
    }
    public static void setIsUsedQuestion(String questionID) throws SQLException, ClassNotFoundException, NamingException{
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql_setIsUsed_question = "UPDATE Question SET isUsed = 1 where questionID = ? ";
                stm = con.prepareStatement(sql_setIsUsed_question);
                stm.setString(1, questionID);
                if (stm != null) {
                    int row = stm.executeUpdate();
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
    }
}

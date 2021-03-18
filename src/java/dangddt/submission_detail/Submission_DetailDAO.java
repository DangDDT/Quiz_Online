/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.submission_detail;

import dangddt.answer_content.AnswerContentDAO;
import dangddt.answer_content.AnswerContentDTO;
import dangddt.utils.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;

/**
 *
 * @author Tam Dang
 */
public class Submission_DetailDAO implements Serializable {

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

    public static void saveSubmission_Detail(String submissionID, String questionID, String question_content, String answers) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql_save_submission = "INSERT Submission_Detail VALUES (?,?,?,?)";
                stm = con.prepareStatement(sql_save_submission);
                stm.setString(1, submissionID);
                stm.setString(2, questionID);
                stm.setString(3, question_content);
                stm.setString(4, answers);
                if (stm != null) {
                    int row = stm.executeUpdate();
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
    }

    public static Vector<Submission_DetailDTO> getSubmissionDetailBySubmissionID(String submissionID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<Submission_DetailDTO> results = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT submissionID, questionID, question_content, answers\n"
                        + "FROM Submission_Detail\n"
                        + "WHERE submissionID = ?\n"
                        + "ORDER BY questionID ASC";
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    stm.setString(1, submissionID);
                    rs = stm.executeQuery();
                    if (rs != null) {
                        results = new Vector();
                        while (rs.next()) {
                            Vector<AnswerContentDTO> list_answer = new Vector<>();
                            Map<String, Vector<AnswerContentDTO>> map = new HashMap<>();
                            String answers = rs.getString("answers");
                            String[] answer = answers.split("-");
                            for (String string : answer) {
                                if (!string.equals("")){
                                    list_answer.add(AnswerContentDAO.getAnswersByAnswerID(string));
                                }
                            }
                            map.put(rs.getString("questionID"), list_answer);
                            results.add(new Submission_DetailDTO(rs.getString("submissionID"),rs.getString("questionID"),map,rs.getString("question_content")));
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return results;
    }
}

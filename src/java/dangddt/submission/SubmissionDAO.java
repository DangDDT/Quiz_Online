/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.submission;

import dangddt.question.QuestionDAO;
import dangddt.submission_detail.Submission_DetailDAO;
import dangddt.submission_detail.Submission_DetailDTO;
import dangddt.utils.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Map;
import java.util.Set;
import java.util.Vector;
import javax.naming.NamingException;

/**
 *
 * @author Tam Dang
 */
public class SubmissionDAO implements Serializable {

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

    public static String getNewSubmissionID() throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String newID = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT CONCAT('S',SUBSTRING('000000',1,6-LEN(CAST(SUBSTRING(MAX(submissionID),2,6) AS INT)+1)),CAST(SUBSTRING(MAX(submissionID),2,6) AS INT)+1)\n"
                        + "FROM Submission";
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

    public static void saveSubmission(float score, String subjectID, String student_email, int total_answer_correct_exam, int total_answer_correct_submit, Map<String, Vector<String>> submission) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String submissionID = getNewSubmissionID();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql_save_submission = "INSERT Submission VALUES (?,?,?,?,?,?,CONVERT (datetime,CURRENT_TIMESTAMP))";
                stm = con.prepareStatement(sql_save_submission);
                stm.setString(1, submissionID);
                stm.setFloat(2, score);
                stm.setString(3, subjectID);
                stm.setString(4, student_email);
                stm.setInt(5, total_answer_correct_exam);
                stm.setInt(6, total_answer_correct_submit);
                if (stm != null) {
                    int row = stm.executeUpdate();
                    if (row > 0) {
                        Set<String> questionIDs = submission.keySet();
                        for (String questionID : questionIDs) {
                            String answers = "";
                            for (String answer : submission.get(questionID)) {
                                if (!answer.equals("")) {
                                    answers = answers + "-" + answer;
                                }
                            }
                            Submission_DetailDAO.saveSubmission_Detail(submissionID, questionID, QuestionDAO.getQuestionContentByQuestionID(questionID), answers);
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
    }

    public static int countSubmissionByStudentEmail(String student_email, String subjectID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<SubmissionDTO> results = null;
        int count = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT COUNT(submissionID)\n"
                        + "FROM Submission\n"
                        + "WHERE student_email = ? AND subjectID = ?";
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    stm.setString(1, student_email);
                    stm.setString(2, subjectID);
                    rs = stm.executeQuery();
                    if (rs != null) {
                        if (rs.next()) {
                            count = rs.getInt(1);
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return count;
    }

    public static Vector<SubmissionDTO> getSubmisssionByStudentEmail(String student_email, int pageIndex, int maxRowInPage, String subjectID)
            throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<SubmissionDTO> results = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT submissionID, score, subjectID, student_email, total_answers_correct_exam, total_answers_correct_submit, time\n"
                        + "FROM Submission\n"
                        + "WHERE student_email = ? AND subjectID = ?\n"
                        + "ORDER BY submissionID\n"
                        + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    stm.setString(1, student_email);
                    stm.setString(2, subjectID);
                    stm.setInt(3, (pageIndex - 1) * maxRowInPage);
                    stm.setInt(4, maxRowInPage);
                    rs = stm.executeQuery();
                    if (rs != null) {
                        results = new Vector();
                        while (rs.next()) {
                            results.add(new SubmissionDTO(rs.getString("submissionID"), rs.getFloat("score"), rs.getString("subjectID"), rs.getString("student_email"), rs.getInt("total_answers_correct_exam"), rs.getInt("total_answers_correct_submit"), rs.getTimestamp("time")));
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return results;
    }

    public static int countSubmissionByKeyword(String keyword) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<SubmissionDTO> results = null;
        int count = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT COUNT(submissionID)\n"
                        + "FROM Submission\n"
                        + "WHERE student_email LIKE ?";
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
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return count;
    }

    public static Vector<SubmissionDTO> getSubmisssionByKeyword(String keyword, int pageIndex, int maxRowInPage)
            throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<SubmissionDTO> results = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT submissionID, score, subjectID, student_email, total_answers_correct_exam, total_answers_correct_submit, time\n"
                        + "FROM Submission\n"
                        + "WHERE student_email LIKE ?\n"
                        + "ORDER BY submissionID DESC\n"
                        + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    stm.setString(1, "%" + keyword + "%");
                    stm.setInt(2, (pageIndex - 1) * maxRowInPage);
                    stm.setInt(3, maxRowInPage);
                    rs = stm.executeQuery();
                    if (rs != null) {
                        results = new Vector();
                        while (rs.next()) {
                            results.add(new SubmissionDTO(rs.getString("submissionID"), rs.getFloat("score"), rs.getString("subjectID"), rs.getString("student_email"), rs.getInt("total_answers_correct_exam"), rs.getInt("total_answers_correct_submit"), rs.getTimestamp("time")));
                        }
                    }
                }
            }
        } finally {
            closeConnection(con, stm, rs);
        }
        return results;
    }

    public static int countSubmissionBySubjectID(String subjectID) throws SQLException, ClassNotFoundException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<SubmissionDTO> results = null;
        int count = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT COUNT(submissionID)\n"
                        + "FROM Submission\n"
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
        } finally {
            closeConnection(con, stm, rs);
        }
        return count;
    }

    public static Vector<SubmissionDTO> getSubmisssionBySubjectID(String subjectID, int pageIndex, int maxRowInPage)
            throws ClassNotFoundException, SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<SubmissionDTO> results = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT submissionID, score, subjectID, student_email, total_answers_correct_exam, total_answers_correct_submit, time\n"
                        + "FROM Submission\n"
                        + "WHERE subjectID = ?\n"
                        + "ORDER BY submissionID DESC\n"
                        + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = con.prepareStatement(sql);
                if (stm != null) {
                    stm.setString(1, subjectID);
                    stm.setInt(2, (pageIndex - 1) * maxRowInPage);
                    stm.setInt(3, maxRowInPage);
                    rs = stm.executeQuery();
                    if (rs != null) {
                        results = new Vector();
                        while (rs.next()) {
                            results.add(new SubmissionDTO(rs.getString("submissionID"), rs.getFloat("score"), rs.getString("subjectID"), rs.getString("student_email"), rs.getInt("total_answers_correct_exam"), rs.getInt("total_answers_correct_submit"), rs.getTimestamp("time")));
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

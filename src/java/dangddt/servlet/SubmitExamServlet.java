/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.servlet;

import dangddt.account.AccountDTO;
import dangddt.answer_content.AnswerContentDTO;
import dangddt.question.QuestionDAO;
import dangddt.question.QuestionDTO;
import dangddt.submission.SubmissionDAO;
import dangddt.submission_detail.Submission_DetailDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Map;
import java.util.Set;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tam Dang
 */
@WebServlet(name = "SubmitExamServlet", urlPatterns = {"/SubmitExamServlet"})
public class SubmitExamServlet extends HttpServlet {

    private static final String SUBMIT_FAILED = "error";
    private static final String SUBMIT_SUCCESS = "result_page";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Map<String, String> page_constant = (Map<String, String>) request.getServletContext().getAttribute("PAGE_CONSTANT");
        PrintWriter out = response.getWriter();
        String url = page_constant.get(SUBMIT_FAILED);
        HttpSession session = null;
        try {
            session = request.getSession();
            if (session != null) {
                int total_correct_answer = 0;
                float score = 0;
                Map<String, Vector<String>> submission;
                submission = (Map<String, Vector<String>>) session.getAttribute("LIST_ANSWER_CHOOSEN");
                Vector<QuestionDTO> exam = (Vector<QuestionDTO>) session.getAttribute("EXAM");
                Set<String> questionIDs = submission.keySet();
                Vector<String> answers_submission = new Vector<>();
                Vector<String> answers_correct = new Vector<>();
                for (String questionID : questionIDs) {
                    answers_submission.addAll(submission.get(questionID));
                }
                for (QuestionDTO questionDTO : exam) {
                    for (AnswerContentDTO answer : questionDTO.getAnswers()) {
                        if (answer.isIsCorrect()) {
                            answers_correct.add(answer.getAnswerID().trim());
                        }
                    }
                }
                for (String answerID_submission : answers_submission) {
                    for (String answerID_correct : answers_correct) {
                        if (answerID_submission.equals(answerID_correct)) {
                            total_correct_answer++;
                        }
                    }
                }
                for (QuestionDTO questionDTO : exam) {
                    QuestionDAO.setIsUsedQuestion(questionDTO.getQuestionID().trim());
                }
                score = ((float)total_correct_answer / (float)answers_correct.size()) * 10;
                SubmissionDAO.saveSubmission(score, exam.get(0).getSubjectID(), ((AccountDTO)session.getAttribute("ACCOUNT")).getEmail(), answers_correct.size(), total_correct_answer, submission);
                request.setAttribute("SUBJECT", exam.get(0).getSubjectID());
                request.setAttribute("NUM_CORRECT_ANSWER", total_correct_answer);
                request.setAttribute("NUM_EXAM_ANSWER", answers_correct.size());
                request.setAttribute("SCORE", score);
                session.removeAttribute("EXAM");
                session.removeAttribute("LIST_ANSWER_CHOOSEN");
                url = page_constant.get(SUBMIT_SUCCESS);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubmitExamServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SubmitExamServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(SubmitExamServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

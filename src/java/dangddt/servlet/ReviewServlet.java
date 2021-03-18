/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.servlet;

import dangddt.answer_content.AnswerContentDAO;
import dangddt.answer_content.AnswerContentDTO;
import dangddt.submission_detail.Submission_DetailDAO;
import dangddt.submission_detail.Submission_DetailDTO;
import dangddt.tool.Config;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Tam Dang
 */
@WebServlet(name = "ReviewServlet", urlPatterns = {"/ReviewServlet"})
public class ReviewServlet extends HttpServlet {
    private static final String REVIEW_FAILED = "error";
    private static final String REVIEW_SUCCESS = "history_detail_page";

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
        String url = page_constant.get(REVIEW_FAILED);
        Vector<Submission_DetailDTO> submission = null;
        Vector<AnswerContentDTO> answers = null;
        Map<String, Vector<AnswerContentDTO>> answersOfquestion= null;
        try {
            String submissionID = request.getParameter("submissionID").trim();
            if (submissionID != null && !submissionID.isEmpty()) {
                answersOfquestion = new HashMap();
                submission = Submission_DetailDAO.getSubmissionDetailBySubmissionID(submissionID);
                for (Submission_DetailDTO submission_DetailDTO : submission) {
                    answers = AnswerContentDAO.getAnswersByQuestion(submission_DetailDTO.getQuestionID());
                    answersOfquestion.put(submission_DetailDTO.getQuestionID(), answers);
                }
                request.setAttribute("ANSWER", answersOfquestion);
                request.setAttribute("REVIEW", submission);
                url = page_constant.get(REVIEW_SUCCESS);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReviewServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReviewServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(ReviewServlet.class.getName()).log(Level.SEVERE, null, ex);
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

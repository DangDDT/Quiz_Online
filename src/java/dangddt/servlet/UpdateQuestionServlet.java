/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.servlet;

import dangddt.answer_content.AnswerContentDTO;
import dangddt.question.QuestionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
@WebServlet(name = "UpdateQuestionServlet", urlPatterns = {"/UpdateQuestionServlet"})
public class UpdateQuestionServlet extends HttpServlet {

    private static final String ERROR_PAGE = "error";

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
        Vector<AnswerContentDTO> answers = null;
        String url = page_constant.get(ERROR_PAGE);
        try {
            String current_page = request.getParameter("current_page").trim();
            String questionID = request.getParameter("questionID").trim();
            String question_content = request.getParameter("question_content");
            String subjectID = request.getParameter("subjectID");
            String[] answerID_content;
            answerID_content = request.getParameterValues("answerID_content");
            String[] correct_answer;
            correct_answer = request.getParameterValues("correct_answer");
            if (questionID != null && question_content != null && answerID_content != null && correct_answer != null) {
                answers = new Vector();
                for (int i = 0; i < answerID_content.length; i++) {
                    String[] part = answerID_content[i].split("-");
                    String answerID = part[0].trim();
                    String answer_content = part[1].trim();
                    boolean isCorrect = false;
                    for (int j = 0; j < correct_answer.length; j++) {
                        if (answerID.equals(correct_answer[j].trim())) {
                            isCorrect = true;
                        }
                    }
                    answers.add(new AnswerContentDTO(answerID, answer_content, isCorrect));
                }
                if (answers != null) {
                    String updated_questionID = QuestionDAO.update(questionID, question_content, subjectID, answers);
                    if (updated_questionID != null) {
                        url = page_constant.get(current_page);
                    }
                }
            }
            if (!current_page.equals("admin_page")) {
                response.sendRedirect(current_page);
            } else {
                request.getRequestDispatcher(url).forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UpdateQuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdateQuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(UpdateQuestionServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {

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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.servlet;

import dangddt.question.QuestionDAO;
import dangddt.question.QuestionDTO;
import dangddt.subject.SubjectDAO;
import dangddt.subject.SubjectDTO;
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
@WebServlet(name = "SearchBySubjectServlet", urlPatterns = {"/SearchBySubjectServlet"})
public class SearchBySubjectServlet extends HttpServlet {

    private static final int MAX_ROW_IN_PAGE = Config.MAX_ROW_IN_SUBJECT;
    private static final String SEARCH_FAILED = "error";
    private static final String SEARCH_SUCCESS = "admin_page";

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
        String url = page_constant.get(SEARCH_FAILED);
        Integer pageIndexInteger = -1;
        int num_page = 0;
        try {
            String subjectID = request.getParameter("subjectID").trim();
            String pageIndex = request.getParameter("pageIndex").trim();
            if (pageIndex.trim().length() > 0) {
                pageIndexInteger = Integer.parseInt(pageIndex);
            }
            if (subjectID.trim().length() > 0) {
                Vector<QuestionDTO> list_question = QuestionDAO.getQuestionsBySubject(subjectID, pageIndexInteger, MAX_ROW_IN_PAGE);
                num_page = (int) Math.ceil((double) QuestionDAO.countQuestions(null, -1, subjectID) / MAX_ROW_IN_PAGE);
                request.setAttribute("NUM_PAGE", num_page);
                request.setAttribute("LIST_QUESTION", list_question);
                if (subjectID.isEmpty()) {
                    url = "search_by_subject?subjectID=" + subjectID + "&pageIndex=" + pageIndex;
                    response.sendRedirect(url);
                } else {
                    url = page_constant.get(SEARCH_SUCCESS);
                    request.getRequestDispatcher(url).forward(request, response);
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SearchBySubjectServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SearchBySubjectServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(SearchBySubjectServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
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

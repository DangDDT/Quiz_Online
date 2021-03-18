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
@WebServlet(name = "SearchByStatusServlet", urlPatterns = {"/SearchByStatusServlet"})
public class SearchByStatusServlet extends HttpServlet {

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
        Map<String, Vector<QuestionDTO>> questionsOfSubject = null;
        int num_page = 0;
        try {
            String statusString = request.getParameter("status").trim();
            String pageIndex = request.getParameter("pageIndex").trim();
            if (pageIndex.trim().length() > 0) {
                pageIndexInteger = Integer.parseInt(pageIndex);
            }
            if (statusString.trim().length() > 0) {
                SubjectDAO subDao = new SubjectDAO();
                subDao.getSubjects();
                Vector<SubjectDTO> list_subject = subDao.getListSubject();
                questionsOfSubject = new HashMap<>();
                for (SubjectDTO subjectDTO : list_subject) {
                    Vector<QuestionDTO> list_question = QuestionDAO.getQuestionsByStatus((statusString.equals("active")), subjectDTO.getSubjectID(), pageIndexInteger, MAX_ROW_IN_PAGE);
                    if (list_question != null && !list_question.isEmpty()) {
                        questionsOfSubject.put(subjectDTO.getSubjectID(), list_question);
                    }
                }
                num_page = (int) Math.ceil((double) QuestionDAO.countQuestions(null, (statusString.equals("active")) ? 1 : 0, null) / MAX_ROW_IN_PAGE);
                if (questionsOfSubject.size() > 0) {
                    if (num_page == 0) {
                        num_page = 1;
                    }
                }
                request.setAttribute("NUM_PAGE", num_page);
                request.setAttribute("LIST_QUESTION", questionsOfSubject);
                if (statusString.isEmpty()) {
                    url = "search_by_status?status=" + statusString + "&pageIndex=" + pageIndex;
                    response.sendRedirect(url);
                } else {
                    url = page_constant.get(SEARCH_SUCCESS);
                    request.getRequestDispatcher(url).forward(request, response);
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SearchByStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(SearchByStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(SearchByStatusServlet.class.getName()).log(Level.SEVERE, null, ex);
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

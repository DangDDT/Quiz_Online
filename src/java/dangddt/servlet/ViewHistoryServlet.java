/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.servlet;

import dangddt.account.AccountDAO;
import dangddt.account.AccountDTO;
import dangddt.question.QuestionDAO;
import dangddt.submission.SubmissionDAO;
import dangddt.submission.SubmissionDTO;
import dangddt.tool.Config;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Map;
import java.util.TreeSet;
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
@WebServlet(name = "ViewHistoryServlet", urlPatterns = {"/ViewHistoryServlet"})
public class ViewHistoryServlet extends HttpServlet {

    private static final int MAX_ROW_IN_PAGE = Config.MAX_ROW_IN_PAGE_HISTORY;
    private static final String LOAD_HISTORY_FAILED = "error";
    private static final String LOAD_HISTORY_STUDENT_SUCCESS = "student_page";
    private static final String LOAD_HISTORY_ADMIN_SUCCESS = "admin_history_page";

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
        HttpSession session = null;
        String url = page_constant.get(LOAD_HISTORY_FAILED);
        int num_page = 0;
        try {
            String page = request.getParameter("page");
            if (page.equals("student")) {
                session = request.getSession(false);
                String student_email = ((AccountDTO) session.getAttribute("ACCOUNT")).getEmail().trim();
                String subjectID = request.getParameter("subjectID");
                int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
                if (student_email != null && subjectID != null) {
                    Vector<SubmissionDTO> list_submission = SubmissionDAO.getSubmisssionByStudentEmail(student_email, pageIndex, MAX_ROW_IN_PAGE, subjectID);
                    num_page = (int) Math.ceil((double) SubmissionDAO.countSubmissionByStudentEmail(student_email, subjectID) / MAX_ROW_IN_PAGE);
                    if (list_submission.size() > 0) {
                        if (num_page == 0) {
                            num_page = 1;
                        }
                    }
                    request.setAttribute("NUM_PAGE", num_page);
                    request.setAttribute("HISTORY", list_submission);
                    url = page_constant.get(LOAD_HISTORY_STUDENT_SUCCESS);
                }
            } else if (page.equals("admin")) {
                String search_by = request.getParameter("search_by");
                if (search_by.equals("name")) {
                    String keyword = request.getParameter("txtSearch");
                    int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
                    if (keyword != null) {
                        Vector<SubmissionDTO> list_submission = SubmissionDAO.getSubmisssionByKeyword(keyword, pageIndex, MAX_ROW_IN_PAGE);
                        num_page = (int) Math.ceil((double) SubmissionDAO.countSubmissionByKeyword(keyword) / MAX_ROW_IN_PAGE);
                        if (list_submission.size() > 0) {
                            if (num_page == 0) {
                                num_page = 1;
                            }
                        }
                        HashSet<AccountDTO> list_student = new HashSet<>();
                        for (SubmissionDTO submissionDTO : list_submission) {
                            AccountDTO dto = AccountDAO.getStudentByEmail(submissionDTO.getStudent_email().trim());
                            list_student.add(dto);
                        }
                        request.setAttribute("LIST_STUDENT", list_student);
                        request.setAttribute("NUM_PAGE", num_page);
                        request.setAttribute("HISTORY", list_submission);
                        url = page_constant.get(LOAD_HISTORY_ADMIN_SUCCESS);
                    }
                } else if (search_by.equals("subject")) {
                    String subjectID = request.getParameter("subjectID");
                    int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
                    if (subjectID != null) {
                        Vector<SubmissionDTO> list_submission = SubmissionDAO.getSubmisssionBySubjectID(subjectID, pageIndex, MAX_ROW_IN_PAGE);
                        num_page = (int) Math.ceil((double) SubmissionDAO.countSubmissionBySubjectID(subjectID) / MAX_ROW_IN_PAGE);
                        if (list_submission.size() > 0) {
                            if (num_page == 0) {
                                num_page = 1;
                            }
                        }
                        HashSet<AccountDTO> list_student = new HashSet<>();
                        for (SubmissionDTO submissionDTO : list_submission) {
                            AccountDTO dto = AccountDAO.getStudentByEmail(submissionDTO.getStudent_email().trim());
                            list_student.add(dto);
                        }
                        request.setAttribute("LIST_STUDENT", list_student);
                        request.setAttribute("NUM_PAGE", num_page);
                        request.setAttribute("HISTORY", list_submission);
                        url = page_constant.get(LOAD_HISTORY_ADMIN_SUCCESS);
                    }
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ViewHistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ViewHistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(ViewHistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
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

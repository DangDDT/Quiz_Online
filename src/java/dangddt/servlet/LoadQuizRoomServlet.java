/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.servlet;

import dangddt.answer_content.AnswerContentDTO;
import dangddt.question.QuestionDAO;
import dangddt.question.QuestionDTO;
import dangddt.subject.SubjectDTO;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tam Dang
 */
@WebServlet(name = "LoadQuizRoomServlet", urlPatterns = {"/LoadQuizRoomServlet"})
public class LoadQuizRoomServlet extends HttpServlet {

    private static final String LOAD_FAILED = "error";
    private static final String LOAD_SUCCESS = "quiz_room_page";

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
        String url = page_constant.get(LOAD_FAILED);
        Vector<String> list_answer_choosen = null;
        HttpSession session = null;
        try {
            String subjectID = request.getParameter("subjectID");
            int question_exam = 0;
            Vector<SubjectDTO> temp = (Vector<SubjectDTO>) request.getServletContext().getAttribute("SUBJECT_STUDENT");
            for (SubjectDTO subjectDTO : temp) {
                if (subjectDTO.getSubjectID().trim().equals(subjectID)) question_exam = subjectDTO.getQuestion_exam();
            }
            String question_numberString = request.getParameter("question_number");
            String questionID = request.getParameter("questionID");
            String answer_choosen = request.getParameter("answers_choosen");
            String[] part = answer_choosen.split("-");
            if (part.length > 1) {
                list_answer_choosen = new Vector<>();
                for (String string : part) {
                    list_answer_choosen.add(string);
                }
            }
            int question_numberInt = Integer.parseInt(question_numberString);
            session = request.getSession(false);
            if (session != null) {
                Vector<QuestionDTO> exam = (Vector<QuestionDTO>) session.getAttribute("EXAM");
                if (exam==null || request.getParameter("reset").equals("true")) {
                    session.removeAttribute("LIST_ANSWER_CHOOSEN");
                    session.removeAttribute("EXAM");
                    exam = QuestionDAO.loadQuestionForQuiz(subjectID, question_exam);
                    session.setAttribute("EXAM", exam);
                } 
                Map<String, Vector<String>> list_choosen_of_question = (Map<String, Vector<String>>) session.getAttribute("LIST_ANSWER_CHOOSEN");
                if (list_choosen_of_question == null) {
                    list_choosen_of_question = new HashMap<>();
                    session.setAttribute("LIST_ANSWER_CHOOSEN", list_choosen_of_question);
                }
                if (list_answer_choosen != null) {
                    list_choosen_of_question.put(questionID, list_answer_choosen);
                    session.setAttribute("LIST_ANSWER_CHOOSEN", list_choosen_of_question);
                }
                int count_answer_correct = 0;
                for (AnswerContentDTO answerContentDTO : exam.get(question_numberInt).getAnswers()) {
                    if (answerContentDTO.isIsCorrect()) count_answer_correct++;
                }
                if (count_answer_correct==1){
                    request.setAttribute("QUESTION_1", true);
                }else{
                    request.setAttribute("QUESTION_1", false);
                }
                request.setAttribute("QUESTION", exam.get(question_numberInt));
                url = page_constant.get(LOAD_SUCCESS);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoadQuizRoomServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(LoadQuizRoomServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(LoadQuizRoomServlet.class.getName()).log(Level.SEVERE, null, ex);
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

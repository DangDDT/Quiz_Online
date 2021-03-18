package dangddt.servlet;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import dangddt.account.AccountDAO;
import dangddt.account.AccountDTO;
import dangddt.tool.Tool;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Map;
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
@WebServlet(urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    private final static String REGISTER_SUCCESS = "login_page";
    private final static String REGISTER_FAILED = "error";
    private final static String REGISTER_EXITED = "register_page";

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
        String url = page_constant.get(REGISTER_FAILED);
        try {
            /* TODO output your page here. You may use following sample code. */
            String email = request.getParameter("txtEmail").trim();
            String name = request.getParameter("txtName").trim();
            String password = request.getParameter("txtPassword").trim();
            String encrypted_password = Tool.encryptSHA256(password);
            if (!email.isEmpty() && !name.isEmpty() && !encrypted_password.isEmpty()) {
                AccountDTO checkExisted = AccountDAO.getStudentByEmail(email);
                if (checkExisted != null) {
                    url = page_constant.get(REGISTER_EXITED);
                    String message = "User is existed, please choose the other.";
                    request.setAttribute("MESSAGE", message);
                } else {
                    if (AccountDAO.registerStudent(email, encrypted_password, name)) {
                        url = page_constant.get(REGISTER_SUCCESS);
                        String message = "Sign up successfully, please login !!!";
                        request.setAttribute("MESSAGE", message);
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
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

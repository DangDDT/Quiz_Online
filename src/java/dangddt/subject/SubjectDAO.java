/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.subject;

import dangddt.utils.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 *
 * @author Tam Dang
 */
public class SubjectDAO implements Serializable, ServletContextListener {

    private Vector<SubjectDTO> listSubject;
    private Vector<SubjectDTO> listSubjectStudent;

    public SubjectDAO() {
        listSubject = new Vector<>();
        listSubjectStudent = new Vector();
    }

    public Vector<SubjectDTO> getListSubjectStudent() {
        return listSubjectStudent;
    }

    public void setListSubjectStudent(Vector<SubjectDTO> listSubjectStudent) {
        this.listSubjectStudent = listSubjectStudent;
    }
    
    public Vector<SubjectDTO> getListSubject() {
        return listSubject;
    }

    public void setListSubject(Vector<SubjectDTO> listCategory) {
        this.listSubject = listCategory;
    }

    private static void closeConnection(Connection con, PreparedStatement stm, ResultSet rs) throws SQLException {
        if (con != null) {
            con.close();
        }
        if (stm != null) {
            stm.close();
        }
        if (rs != null) {
            rs.close();
        }
    }

    public void getSubjects() {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT subjectID, name\n"
                        + "FROM Subject\n"
                        + "WHERE status = 1";
                stm = con.prepareStatement(sql);
                if (null != stm) {
                    rs = stm.executeQuery();
                    if (rs != null) {
                        listSubject = new Vector<>();
                        while (rs.next()) {
                            listSubject.add(new SubjectDTO(rs.getString("subjectID"), rs.getString("name")));
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                closeConnection(con, stm, rs);
            } catch (SQLException ex) {
                Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    public void getSubjectsStudent() {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT subjectID, name, image, description, question_exam, time_exam\n"
                        + "FROM Subject\n"
                        + "WHERE status = 1";
                stm = con.prepareStatement(sql);
                if (null != stm) {
                    rs = stm.executeQuery();
                    if (rs != null) {
                        listSubjectStudent = new Vector<>();
                        while (rs.next()) {
                            listSubjectStudent.add(new SubjectDTO(rs.getString("subjectID"), rs.getString("name"), rs.getString("description"), rs.getString("image"), rs.getInt("question_exam"), rs.getInt("time_exam")));
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                closeConnection(con, stm, rs);
            } catch (SQLException ex) {
                Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        getSubjects();
        getSubjectsStudent();
        sce.getServletContext().setAttribute("SUBJECT", listSubject);
        sce.getServletContext().setAttribute("SUBJECT_STUDENT", listSubjectStudent);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        sce.getServletContext().removeAttribute("SUBJECT");
        sce.getServletContext().removeAttribute("SUBJECT_STUDENT");
    }

}

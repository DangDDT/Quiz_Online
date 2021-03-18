/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dangddt.tool;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 *
 * @author Tam Dang
 */
public class PageConstant implements ServletContextListener{
    private Map<String, String> page_constant;
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String DATA = sce.getServletContext().getRealPath("/WEB-INF/page_constant.txt");
        FileReader fr = null;
        try {
            page_constant = new HashMap<String, String>();
            File f = new File(DATA);
            fr = new FileReader(f);
            BufferedReader br = new BufferedReader(fr);
            while (br.ready()) {
                String line = br.readLine();
                String[] part = line.split("=");
                page_constant.put(part[0], part[1]);
            }
            sce.getServletContext().setAttribute("PAGE_CONSTANT", page_constant);
        } catch (FileNotFoundException ex) {
            Logger.getLogger(PageConstant.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(PageConstant.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (fr!=null) fr.close();
            } catch (IOException ex) {
                Logger.getLogger(PageConstant.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        sce.getServletContext().removeAttribute("PAGE_CONSTANT");
    }
    
}

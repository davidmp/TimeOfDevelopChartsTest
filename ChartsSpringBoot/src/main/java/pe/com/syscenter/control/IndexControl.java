/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.com.syscenter.control;


import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import pe.com.syscenter.service.Data2Service;
/**
 *
 * @author LAB REDES
 */
@Controller
public class IndexControl {    
    
    @Autowired
    Data2Service data2Service;
    
    protected final Log logger = LogFactory.getLog(getClass());

    @RequestMapping(value = "/", method = RequestMethod.GET)    
    public ModelAndView inicio(){           
        Map<String,Object> model=new HashMap<>();
        model.put("saludo", "Mundo Redondo"); 
        return new ModelAndView("index", model);
    }     
    
    @RequestMapping(value = {"/bar" }, method = RequestMethod.GET)    
    public ModelAndView inicioBar(){             
        Map<String,Object> model=new HashMap<>();       
        model.put("saludo", "Mundo Redondo");         
        return new ModelAndView("barchart", model);
    }     
          
    
    @RequestMapping(value = {"/pie" }, method = RequestMethod.GET)    
    public ModelAndView inicioPrueba(){     
        Map<String,Object> model=new HashMap<>();        
        model.put("saludo", "Mundo Redondo");      
        return new ModelAndView("piechart", model);
    }    
   
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jfreechart;

import java.awt.BasicStroke;
import java.awt.Color;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;

/**
 *
 * @author LAB REDES
 */
@WebServlet(name = "JFChartPieChart", urlPatterns = {"/JFChartPieChart"})
public class JFChartPieChart extends HttpServlet {

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
		response.setContentType("image/png");
                long TInicio, TFin, tiempo;           //Para determinar el tiempo
                TInicio = System.currentTimeMillis(); //de ejecución %>                
		OutputStream outputStream = response.getOutputStream();

		JFreeChart chart = getChart();
		int width = 500;
		int height = 350;
		request.getSession().setAttribute("TInicio", "Holas");
                ChartUtils.writeChartAsPNG(outputStream, chart, width, height);
                
                TFin = System.currentTimeMillis();
                tiempo = TFin - TInicio;
                System.out.println("TI:"+TInicio);      
                System.out.println("TF:"+TFin);      
                System.out.println("Tiempo:"+tiempo); 
               
    }
    
	public JFreeChart getChart() {
            JFreeChart chart=null;
            String query="SELECT * FROM data1 WHERE tipo='Internacional'";
            try{
            PreparedStatement stmt = conexionDB().prepareStatement(query);
            ResultSet rs = stmt.executeQuery(); 
            
            DefaultPieDataset dataset = new DefaultPieDataset();
            while(rs.next()){
            dataset.setValue(rs.getString("mes"),rs.getDouble("cantidad"));        
            }
            boolean legend = true;
            boolean tooltips = false;
            boolean urls = false;

            chart = ChartFactory.createPieChart("Afluencia de Turistas po Meses", dataset, legend, tooltips, urls);

            chart.setBorderPaint(Color.GREEN);
            chart.setBorderStroke(new BasicStroke(5.0f));
            chart.setBorderVisible(true);            
            
            
            
            } catch (SQLException sqle) { 
            System.out.println("Error en la ejecución:" + sqle.getErrorCode() + " " + sqle.getMessage());    
            }

		return chart;
	}    

        public Connection conexionDB(){
            Connection con = null;
            try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            
            String sURL = "jdbc:mysql://localhost:3306/echartstag";
            con = DriverManager.getConnection(sURL,"root","");
            if(con!=null){ System.out.println("si hay conexion!!"); } 
            } catch (Exception e) {
            }            
            return con;
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

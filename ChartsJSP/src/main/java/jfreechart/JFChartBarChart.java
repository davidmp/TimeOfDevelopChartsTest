/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jfreechart;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;

/**
 *
 * @author LAB REDES
 */
@WebServlet(name = "JFChartBarChart", urlPatterns = {"/JFChartBarChart"})
public class JFChartBarChart extends HttpServlet {

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
        long TInicio, TFin, tiempo;           //Para determinar el tiempo
                TInicio = System.currentTimeMillis(); //de ejecución %> 
      String query="SELECT CAST(YEAR(CURRENT_DATE())-2 AS CHAR) AS anho, r.*  FROM ( SELECT d.*, d2.cantidad2, d3.cantidad3, d4.cantidad4 FROM ( SELECT Data2.zona, Data2.tipo, Data2.cantidad FROM Data2 WHERE anho=YEAR(NOW())-2 ) AS d LEFT JOIN ( SELECT Data2.zona, Data2.tipo, Data2.cantidad AS cantidad2 FROM Data2 WHERE anho=YEAR(NOW())-3) AS d2 USING (zona, tipo) LEFT JOIN ( SELECT Data2.zona, Data2.tipo, Data2.cantidad AS cantidad3 FROM Data2 WHERE anho=YEAR(NOW())-4) AS d3 USING (zona, tipo) LEFT JOIN ( SELECT Data2.zona, Data2.tipo, Data2.cantidad AS cantidad4 FROM Data2 WHERE anho=YEAR(NOW())-5) AS d4 USING (zona, tipo)) AS r WHERE r.tipo = 'Ingreso' ";
      final DefaultCategoryDataset dataset = new DefaultCategoryDataset();
      
        try{
            PreparedStatement stmt = conexionDB().prepareStatement(query);
            ResultSet rs = stmt.executeQuery();             
            while(rs.next()){
             dataset.addValue( rs.getDouble("cantidad") , rs.getString("anho") , rs.getString("zona") );
             dataset.addValue( rs.getDouble("cantidad2") , String.valueOf(Integer.parseInt(rs.getString("anho"))-1) , rs.getString("zona") );
             dataset.addValue( rs.getDouble("cantidad3") , String.valueOf(Integer.parseInt(rs.getString("anho"))-2) , rs.getString("zona") );
             dataset.addValue( rs.getDouble("cantidad4") , String.valueOf(Integer.parseInt(rs.getString("anho"))-3), rs.getString("zona") );
            }                       
        } catch (SQLException sqle) { 
        System.out.println("Error en la ejecución:" + sqle.getErrorCode() + " " + sqle.getMessage());    
        }
        JFreeChart barChart = ChartFactory.createBarChart(
         "Salida de turistas Peruanos a distintas Zonas", 
         "Zona", "Cantidad", 
         dataset,PlotOrientation.VERTICAL, 
         true, true, false);
         
      int width = 800;    /* Width of the image */
      int height = 600;   /* Height of the image */ 
      OutputStream outputStream = response.getOutputStream();
      ChartUtils.writeChartAsPNG(outputStream, barChart, width, height);      
    TFin = System.currentTimeMillis();
     tiempo = TFin - TInicio;
     System.out.println("TI:"+TInicio);      
     System.out.println("TF:"+TFin);      
     System.out.println("Tiempo:"+tiempo);      
        
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

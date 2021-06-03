<%-- 
    Document   : pie
    Created on : 01/04/2021, 08:57:18 AM
    Author     : LAB REDES
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Test Generate Charts</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.0.2/chart.min.js" integrity="sha512-dnUg2JxjlVoXHVdSMWDYm2Y5xcIrJg1N+juOuRi0yLVkku/g26rwHwysJDAMwahaDfRpr1AxFz43ktuMPr/l1A==" crossorigin="anonymous"></script>
    </head>
    <body>
        <h1>Hello World!</h1>
         <%  long TInicio, TFin, tiempo;           //Para determinar el tiempo
    TInicio = System.currentTimeMillis(); //de ejecución %>  
        <div style="height: 300px; width: 300px">
            <canvas id="mychart" width="400" height="400"></canvas>  
        </div>    
        <%
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        Connection con = null;
        String sURL = "jdbc:mysql://localhost:3306/echartstag";
        con = DriverManager.getConnection(sURL,"root","");
        if(con!=null){ System.out.println("si hay conexion!!"); } 
        String query="SELECT * FROM data1 WHERE tipo='Internacional'";
        String colores="'rgb(242, 215, 213 )',"
                + " 'rgb(250, 219, 216)',"
                + "'rgb(235, 222, 240)',"
                + "'rgb(232, 218, 239)',"
                + "'rgb(212, 230, 241)',"
                + "'rgb(209, 242, 235)',"
                + "'rgb(212, 239, 223)',"
                + "'rgb(213, 245, 227)',"
                + "'rgb(252, 243, 207)',"
                + "'rgb(253, 235, 208)',"
                + "'rgb(250, 229, 211)',"
                + "'rgb(246, 221, 204)',  ";
        String data="";
        String labeles="";
        try{
        PreparedStatement stmt = con.prepareStatement(query);
        ResultSet rs = stmt.executeQuery(); 
        while(rs.next()){
        labeles+="'"+rs.getString("mes")+"',";
        data+=rs.getDouble("cantidad")+",";        
        }        
        } catch (SQLException sqle) { 
        System.out.println("Error en la ejecución:" + sqle.getErrorCode() + " " + sqle.getMessage());    
        }
        

        %>
        
        
        <script type="text/javascript">
            
        var ctx=document.getElementById('mychart').getContext('2d');
        const data = {
          labels: [
           <%=labeles%>
          ],
          datasets: [{
            label: 'Afluencia de Turistas por Meses',
            data: [<%=data%>],
            backgroundColor: [
              <%=colores%>
            ],
            hoverOffset: 4
          }]
        };          
        
        
        var myChart = new Chart(ctx,{
          type: 'pie',
          data: data,
        }); 
        </script>
<%
  TFin = System.currentTimeMillis();
  tiempo = TFin - TInicio;
  System.err.println(tiempo);
%>
<p>TI:<%=TInicio%></p>          
<p>TF:<%=TFin%></p>          
<p>T:<%=tiempo%></p>          
    </body>
</html>

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
        <div style="height: 300px; width: 600px">
            <canvas id="mychart" width="600" height="400"></canvas>  
        </div>  
        <%
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        Connection con = null;
        String sURL = "jdbc:mysql://localhost:3306/echartstag";
        con = DriverManager.getConnection(sURL,"root","");
        if(con!=null){ System.out.println("si hay conexion!!"); } 
        String query="SELECT CAST(YEAR(CURRENT_DATE())-2 AS CHAR) AS anho, r.*  FROM ( SELECT d.*, d2.cantidad2, d3.cantidad3, d4.cantidad4 FROM ( SELECT Data2.zona, Data2.tipo, Data2.cantidad FROM Data2 WHERE anho=YEAR(NOW())-2 ) AS d LEFT JOIN ( SELECT Data2.zona, Data2.tipo, Data2.cantidad AS cantidad2 FROM Data2 WHERE anho=YEAR(NOW())-3) AS d2 USING (zona, tipo) LEFT JOIN ( SELECT Data2.zona, Data2.tipo, Data2.cantidad AS cantidad3 FROM Data2 WHERE anho=YEAR(NOW())-4) AS d3 USING (zona, tipo) LEFT JOIN ( SELECT Data2.zona, Data2.tipo, Data2.cantidad AS cantidad4 FROM Data2 WHERE anho=YEAR(NOW())-5) AS d4 USING (zona, tipo)) AS r WHERE r.tipo = 'Ingreso' ";
        String labels="";
        String colores="'rgba(255, 99, 132, 0.2)', "
                + "'rgba(255, 159, 64, 0.2)',"
                + "'rgba(255, 205, 86, 0.2)', "
                + "'rgba(75, 192, 192, 0.2)',";
        double[][] data=null;
        String[] etiquetas=new String[4];
        try{
        PreparedStatement stmt = con.prepareStatement(query);        
        ResultSet rs = stmt.executeQuery(); 
        int tamanho=0;
        while(rs.next()){tamanho++;}        
        data=new double[4][tamanho];
        
        
        rs = stmt.executeQuery(); 
        int contador=0;
        while(rs.next()){
        labels+="'"+rs.getString("zona")+"',";
            if(contador==0){
            etiquetas[0]=rs.getString("anho");
            etiquetas[1]=String.valueOf(Integer.parseInt(rs.getString("anho"))-1);
            etiquetas[2]=String.valueOf(Integer.parseInt(rs.getString("anho"))-2);
            etiquetas[3]=String.valueOf(Integer.parseInt(rs.getString("anho"))-3);
            }
        
        data[0][contador]=rs.getDouble("cantidad");
        data[1][contador]=rs.getDouble("cantidad");
        data[2][contador]=rs.getDouble("cantidad");
        data[3][contador]=rs.getDouble("cantidad");    
        contador++;
        }        
        } catch (SQLException sqle) { 
        System.out.println("Error en la ejecución:" + sqle.getErrorCode() + " " + sqle.getMessage());    
        }

        
        %>
        <script type="text/javascript">
            var ctx=document.getElementById('mychart').getContext('2d');
            
            const data = {
              labels: [<%=labels%>],
              datasets: [
              <% 
                int x=0;  
                while(x<data.length){   %>
               {
                label: '<%=etiquetas[x]%>',
                data: [                    
                <% for(int n=0;n<data[0].length;n++){ %>
                    <%=data[x][n]%>,     
                <% } %>
            
                    ],
                backgroundColor: [
                  <%=colores%>
                ],
                borderWidth: 1
              },
           
              <% x++;}  %>
              ]
            };            
            
            var myBarChart = new Chart(ctx, {
                type: 'bar',
                data: data,
                 options: {
                    scales: {
                      y: {
                        beginAtZero: true
                      }
                    }
                  },
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

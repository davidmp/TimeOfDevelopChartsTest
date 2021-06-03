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
        <link href="../Styles/ChartSampleStyleSheet.css" rel="stylesheet" />
        <script type="text/javascript" src="//cdn.fusioncharts.com/fusioncharts/latest/fusioncharts.js"></script>
        <script type="text/javascript" src="//cdn.fusioncharts.com/fusioncharts/latest/themes/fusioncharts.theme.fusion.js"></script>        
    </head>
    <body>
        <h1>Hello World!</h1>
 <%  long TInicio, TFin, tiempo;           //Para determinar el tiempo
    TInicio = System.currentTimeMillis(); //de ejecución %>        
        <%
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        Connection con = null;
        String sURL = "jdbc:mysql://localhost:3306/echartstag";
        con = DriverManager.getConnection(sURL,"root","");
        if(con!=null){ System.out.println("si hay conexion!!"); } 
        String query="SELECT CAST(YEAR(CURRENT_DATE())-2 AS CHAR) AS anho, r.*  FROM ( SELECT d.*, d2.cantidad2, d3.cantidad3, d4.cantidad4 FROM ( SELECT Data2.zona, Data2.tipo, Data2.cantidad FROM Data2 WHERE anho=YEAR(NOW())-2 ) AS d LEFT JOIN ( SELECT Data2.zona, Data2.tipo, Data2.cantidad AS cantidad2 FROM Data2 WHERE anho=YEAR(NOW())-3) AS d2 USING (zona, tipo) LEFT JOIN ( SELECT Data2.zona, Data2.tipo, Data2.cantidad AS cantidad3 FROM Data2 WHERE anho=YEAR(NOW())-4) AS d3 USING (zona, tipo) LEFT JOIN ( SELECT Data2.zona, Data2.tipo, Data2.cantidad AS cantidad4 FROM Data2 WHERE anho=YEAR(NOW())-5) AS d4 USING (zona, tipo)) AS r WHERE r.tipo = 'Ingreso' ";
        String caption="Salida de turistas peruanos a distintas zonas";
        String categoria="";
        String[] data={"","","", ""};
        int tamanho=0;
        int contador=0;
        try{
        PreparedStatement stmt = con.prepareStatement(query);
        ResultSet rs = stmt.executeQuery(); 
        while(rs.next()){tamanho++;}
        rs = stmt.executeQuery(); 
        while(rs.next()){
            if(contador==0){
            data[0]=data[0]+"{ seriesname: '"+rs.getString("anho")+"', data: [";
            data[1]=data[1]+"{ seriesname: '"+String.valueOf(Integer.parseInt(rs.getString("anho"))-1)+"', data: [";
            data[2]=data[2]+"{ seriesname: '"+String.valueOf(Integer.parseInt(rs.getString("anho"))-2)+"', data: [";
            data[3]=data[3]+"{ seriesname: '"+String.valueOf(Integer.parseInt(rs.getString("anho"))-3)+"', data: [";
            }
            categoria+="{label: '"+rs.getString("zona")+"'},";
            data[0]+="{ value: '"+rs.getDouble("cantidad")+"'},";
            data[1]+="{ value: '"+rs.getDouble("cantidad2")+"'},";
            data[2]+="{ value: '"+rs.getDouble("cantidad3")+"'},";
            data[3]+="{ value: '"+rs.getDouble("cantidad4")+"'},";
            contador++;
            if(contador==tamanho){
            data[0]+="]},";
            data[1]+="]},";
            data[2]+="]},";
            data[3]+="]},";
            }
        }
        } catch (SQLException sqle) { 
        System.out.println("Error en la ejecución:" + sqle.getErrorCode() + " " + sqle.getMessage());    
        }
        %>
        
        <div id="chart-container"></div>
        <script type="text/javascript">
            
        const dataSource = {
          chart: {
            caption: "<%=caption%>",
            subcaption: "Datos INEI",
            xaxisname: "Zonas",
            yaxisname: "Cantidad",
            formatnumberscale: "1",
            plottooltext:
              "<b>$dataValue</b> apps were available on <b>$seriesName</b> in $label",
            theme: "fusion"
          },
          categories: [
            {
              category: [
                <%=categoria%>
              ]
            }
          ],
          dataset: [
          <%
          int x=0;
          while(x<data.length){
          %>
            <%=data[x] %>
           <% x++; } %>
          ]
        };

        FusionCharts.ready(function() {
          var myChart = new FusionCharts({
            type: "mscolumn3d",
            renderAt: "chart-container",
            width: "600",
            height: "500",
            dataFormat: "json",
            dataSource
          }).render();
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


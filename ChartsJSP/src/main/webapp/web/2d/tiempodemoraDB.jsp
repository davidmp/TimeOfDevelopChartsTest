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
    </head>
    <body>
        <h1>Hello World!</h1>
        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
        <script src="https://code.highcharts.com/modules/export-data.js"></script>
        <script src="https://code.highcharts.com/modules/accessibility.js"></script>
         <%  long TInicio, TFin, tiempo;           //Para determinar el tiempo
    TInicio = System.currentTimeMillis(); //de ejecución %>  
        <figure class="highcharts-figure">
            <div id="container"></div>           
        </figure> 
        
        <%
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        Connection con = null;
        String sURL = "jdbc:mysql://localhost:3306/echartstag";
        con = DriverManager.getConnection(sURL,"root","");
        if(con!=null){ System.out.println("si hay conexion!!"); } 
       
        String query="SELECT CAST(YEAR(CURRENT_DATE())-2 AS CHAR) AS anho, r.*  FROM ( SELECT d.*, d2.cantidad2, d3.cantidad3, d4.cantidad4 FROM ( SELECT Data2.zona, Data2.tipo, Data2.cantidad FROM Data2 WHERE anho=YEAR(NOW())-2 ) AS d LEFT JOIN ( SELECT Data2.zona, Data2.tipo, Data2.cantidad AS cantidad2 FROM Data2 WHERE anho=YEAR(NOW())-3) AS d2 USING (zona, tipo) LEFT JOIN ( SELECT Data2.zona, Data2.tipo, Data2.cantidad AS cantidad3 FROM Data2 WHERE anho=YEAR(NOW())-4) AS d3 USING (zona, tipo) LEFT JOIN ( SELECT Data2.zona, Data2.tipo, Data2.cantidad AS cantidad4 FROM Data2 WHERE anho=YEAR(NOW())-5) AS d4 USING (zona, tipo)) AS r WHERE r.tipo = 'Ingreso' ";
        String labels="";
        String[] etiquetas=new String[4];
        double[][] data=null;
        try{
        PreparedStatement stmt = con.prepareStatement(query);
        ResultSet rs = stmt.executeQuery(); 
        int tamanho=0;
        while(rs.next()){tamanho++;}
        data=new double[4][tamanho];
        rs = stmt.executeQuery(); 
        int contador=0;
        while(rs.next()){
          if(contador==0){
          etiquetas[0]=rs.getString("anho");
          etiquetas[1]=String.valueOf(Integer.parseInt(rs.getString("anho"))-1);
          etiquetas[2]=String.valueOf(Integer.parseInt(rs.getString("anho"))-2);
          etiquetas[3]=String.valueOf(Integer.parseInt(rs.getString("anho"))-3);
          }  
          
        labels+="'"+rs.getString("zona")+"',";
        data[0][contador]=rs.getDouble("cantidad");
        data[1][contador]=rs.getDouble("cantidad2");
        data[2][contador]=rs.getDouble("cantidad3");
        data[3][contador]=rs.getDouble("cantidad4");
                
                
        contador++;
        }
        
        } catch (SQLException sqle) { 
        System.out.println("Error en la ejecución:" + sqle.getErrorCode() + " " + sqle.getMessage());    
        }

        %>
        
        
        <style>
.highcharts-figure, .highcharts-data-table table {
    min-width: 310px; 
    max-width: 800px;
    margin: 1em auto;
}

#container {
    height: 400px;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}
            
        </style>
        
<script type="text/javascript">
Highcharts.chart('container', {
    chart: {
        type: 'column'
    },
    title: {
        text: 'Salida de Turistas Peruanos a distintas zonas'
    },
    subtitle: {
        text: 'Peru 2016-2019'
    },
    xAxis: {
        categories: [
            <%=labels%>
        ],
        crosshair: true
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Cantidad'
        }
    },
    tooltip: {
        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
        footerFormat: '</table>',
        shared: true,
        useHTML: true
    },
    plotOptions: {
        column: {
            pointPadding: 0.2,
            borderWidth: 0
        }
    },
    series: [
    <% for(int n=0; n<data.length; n++){ %>
            {
                name: '<%=etiquetas[n] %>',
                data: [
            <% for(int m=0; m<data[0].length;m++){ %>
                <%=data[n][m]%>,
            <% } %>
            ]

            }, 
    <% } %>

    ]
});
</script>
<%
  TFin = System.currentTimeMillis();
  tiempo = TFin - TInicio;
  System.err.println(tiempo);
%>
<p>TI:<%=TInicio%></p>          
<p>TF:<%=TFin%></p>          
<p>T.Demora. Coneecion DB:<%=tiempo%></p>         
    </body>
</html>

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
     String query="SELECT * FROM data1 WHERE tipo='Internacional'"; 
     String data="";
    try{
    PreparedStatement stmt = con.prepareStatement(query);
    ResultSet rs = stmt.executeQuery(); 
    while(rs.next()){
        data+="{name: '"+rs.getString("mes")+"', y: "+rs.getDouble("cantidad") +" },";
    }
    
    } catch (SQLException sqle) { 
    System.out.println("Error en la ejecución:" + sqle.getErrorCode() + " " + sqle.getMessage());    
    }

        %>
        
        <style>
        .highcharts-figure, .highcharts-data-table table {
            min-width: 320px; 
            max-width: 800px;
            margin: 1em auto;
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


        input[type="number"] {
                min-width: 50px;
        }            
        </style>
        <script type="text/javascript">
            Highcharts.chart('container', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: 'Afluencia de Turistas por Meses'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                },
                accessibility: {
                    point: {
                        valueSuffix: '%'
                    }
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                        }
                    }
                },
                series: [{
                    name: 'Brands',
                    colorByPoint: true,
                    data: [
                    <%=data%>
                    ]
                }]
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

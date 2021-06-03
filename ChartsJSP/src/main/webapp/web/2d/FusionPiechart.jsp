<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*" %>
<%@page import="fusioncharts.FusionCharts" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title>FusionCharts | Pie 3D Chart</title>
<link href="../Styles/ChartSampleStyleSheet.css" rel="stylesheet" />
<script type="text/javascript" src="//cdn.fusioncharts.com/fusioncharts/latest/fusioncharts.js"></script>
<script type="text/javascript" src="//cdn.fusioncharts.com/fusioncharts/latest/themes/fusioncharts.theme.fusion.js"></script>

</head>
<body>
 <h3>Pie 3D Chart</h3>
 <%  long TInicio, TFin, tiempo;           //Para determinar el tiempo
    TInicio = System.currentTimeMillis(); //de ejecución %>
<div id="pie3d_chart"></div>
<div><span><a href="../Index.jsp">Go Back</a></span></div>
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
        rs = stmt.executeQuery();        
        while(rs.next()){
        data+="{'label': '"+rs.getString("mes")+"','value': '"+rs.getDouble("cantidad")+"'},";
        }
        } catch (SQLException sqle) { 
        System.out.println("Error en la ejecución:" + sqle.getErrorCode() + " " + sqle.getMessage());    
        }
        
    
        
        String jsonData;
        jsonData = "{      'chart': {       "
                + " 'caption': 'Afluencia de Turistas por Meses',        "
                + "'subCaption' : 'Hacia Perú',       "
                + " 'showValues':'1',        "
                + "'showPercentInTooltip' : '0',        "
                + "'numberPrefix' : '$',        "
                + "'enableMultiSlicing':'1',        "
                + "'theme': 'fusion'      },     "
                + " 'data': [ "+data+" ]    }";

        FusionCharts column_chart = new FusionCharts(
      			  "pie3d",
     		      "piechart",
     		      "400",
     		      "400",
     		      "pie3d_chart",
     		      "json",
     		      jsonData
      			);
        %>

		<%=column_chart.render()%>
                
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
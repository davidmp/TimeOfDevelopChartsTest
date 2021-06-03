<%-- 
    Document   : pie
    Created on : 01/04/2021, 08:57:18 AM
    Author     : LAB REDES
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.syscenterlife.com/echarts" prefix="echar" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Page</title>
<echar:echartHeaderScript  />
</head>
<body>
    
<%  long TInicio, TFin, tiempo;           //Para determinar el tiempo
    TInicio = System.currentTimeMillis(); //de ejecución %>
<%     
        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
        Connection con = null;
        String sURL = "jdbc:mysql://localhost:3306/echartstag";
        con = DriverManager.getConnection(sURL,"root","");
        if(con!=null){ System.out.println("si hay conexion!!"); } 
        String query="SELECT * FROM data1 WHERE tipo='Internacional'"; 
        int tamanho=0;
        Object[][] dataValuesX=null;
        try{
        PreparedStatement stmt = con.prepareStatement(query);
        ResultSet rs = stmt.executeQuery(); 
        while(rs.next()){ tamanho++;}
        dataValuesX=new Object[tamanho][2];
        rs = stmt.executeQuery(); 
        int contador=0;
        while(rs.next()){               
               dataValuesX[contador][0]=rs.getDouble("cantidad");
               dataValuesX[contador][1]=rs.getString("mes");
               contador++;
        }                
        } catch (SQLException sqle) { 
        System.out.println("Error en la ejecución:" + sqle.getErrorCode() + " " + sqle.getMessage());    
        }
        String chartTitle="Afluencia de turistas por paises hacia el Perú";
        String[] serieRadiusMinMax={"20%", "70%"};
        String[] serieCenterXY={"50%", "50%"};
        boolean roseType=false;

        String roseTypeValue="radius";/*radius, area*/ 

%>
<echar:echartPie idCharts="main" chartTitle="<%=chartTitle%>" dataValues="<%=dataValuesX%>"/>
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
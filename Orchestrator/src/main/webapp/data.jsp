<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Orchestrator Result</title>
</head>
<body>

<%
    String title, content;
    Date date;
    String fName;
    String filePath;
%>

<%
    request.setCharacterEncoding("UTF-8");
 
    // 이름 값 가져오기
    String name = request.getParameter("name");
    out.println("Name : "+ name + "<br/>");
    
    //프로젝트 명 가져오기
    String project = request.getParameter("project");
    out.println("Project : "+ project + "<br/>");
    
    //날짜 값 가져오기
    String date_radio = request.getParameter("show");
    
    String result = null;
    
    switch(date_radio) {
       case "minutes":
    	  String minute = request.getParameter("minute");
    	  result ="0 0/"+ minute +" * * * ?";
    	  break;
       case "hourly":
    	  String hour = request.getParameter("hour");
    	  String min = request.getParameter("min");
    	  result ="0 0/"+ min+ " 0/" + hour+" * * ?";
    	  break;
       case "daily":
    	  String hour_daily = request.getParameter("hour_daily");
    	  String min_daily = request.getParameter("min_daily");
    	  result = "0 "+ min_daily + " " + hour_daily+ " ? * *";
    	  break;
       case "weekly":
    	   String week[] = request.getParameterValues("week");
    	   String hour_weekly = request.getParameter("hour_weekly");
    	   String min_weekly = request.getParameter("min_weekly");
    	   String result_week = null;
    	   for(String str_week: week){
    		   result_week =  result_week + "," + str_week;
    	   }
    	   result = "0 "+ min_weekly + " " + hour_weekly + " ? * "+ result_week.substring(5);
    	   break;
       case "monthly":
    	   String month = request.getParameter("month");
    	   String week_monthly[] = request.getParameterValues("week_monthly");
    	   String hour_month = request.getParameter("hour_month");
    	   String min_month = request.getParameter("min_month");
    	   String result_monthly = null;
    	   for(String str_week: week_monthly){
    		   result_monthly =  result_monthly + "," + str_week;
    	   }
    	   result = "0 "+ min_month + " " + hour_month + " ? "+ month+ " "+ result_monthly.substring(5);
    	   break;
    }
    
    out.println("Cron : "+ result + "<br/>");
    
    //파일 저장하기
    date = new Date();
    long time =date.getTime();
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yy_MM_dd");
    String formattime = simpleDateFormat.format(time);
    fName = formattime + ".txt";
	String rltv = "C:/Users/Hansol/Documents/Orchestrator/result/";
	filePath = rltv+fName;
    
    
    File f = new File(filePath);

    
    if(name.isEmpty() || project.isEmpty() || result.isEmpty()) {
    	response.sendRedirect("orche.html?result=fail");
    } else {
    	FileWriter fw = null;
    	try{
    		out.println(rltv+fName+"<br>"+f);
    		fw = new FileWriter(f, true);
    		fw.write(name+"[^]"+result+"[^]"+project+"\n");

    		out.println("저장되었습니다.<br>");
    	}catch(IOException e){
    		out.println("저장 실패 : 파일에 데이터를 쓸 수 없습니다.");
    	}finally
    	{
    		try{
    			fw.close();
    		}catch(Exception e){
    			
    		}
    	}
    }
    
    //txt 읽어와서 확인하기
 /*   try{
    	FileReader file_reader = new FileReader(f);
    	int cur =0;
    	while((cur = file_reader.read()) != -1){
    		out.println((char)cur);
    	}
    	file_reader.close();
    }catch(FileNotFoundException e){
    	e.getStackTrace();
    	}catch(IOException e){
    		e.getStackTrace();
    	}
*/
%>

</body>
</html>
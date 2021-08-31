<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Notice" %>
<%@ page import="com.springboot.service.OtherService" %>
<%@ page import="org.mockito.internal.matchers.Not" %>
<%@ page contentType="text/html; charset=utf-8" %>

<html>
<link href="../../static/css/news/style.css" rel="stylesheet" type="text/css">
<head>
    <meta charset="utf-8"/>
    <title>gonggao</title>
</head>

<body >

<%
    Notice notice=(Notice)request.getSession().getAttribute("noticeid");
    if(notice==null){

    }else{

%>
<br><br><br><br>
<font font-family="Microsoft Yahei" font-size="5" font-weight="bold">
    <center ><h1><%=notice.getNoticetitle()%></h1><br/></center>
</font>
<center>
    <div class="news_detail" style="width:80%;text-align:left;">
        <font font-family="宋体" font-size="4" font-weight="normal">
            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<%=notice.getNoticecontent()%>
        </font>
    </div>
    <br>
    <FORM>
    <INPUT class="green-int" TYPE='BUTTON'  VALUE='关闭' onClick='window.close()'>
</FORM>
</center>
<%}%>

</body>
</html>

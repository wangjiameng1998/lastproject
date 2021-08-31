<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Picture" %>
<%@ page import="java.io.Console" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="../../static/js/jquery-2.1.1.min.js"></script>
    <link href="../../static/css/news/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
    List l=(List)request.getSession().getAttribute("addpicture");
    if(l==null){
%><br><br><br><center><h3>暂时无已上传图片</h3><br><a href="upload.jsp" class="yellow-int">继续上传</a></center><%
}
    if(l!=null){
%><center><br><br><br><h3>已上传图片<%=l.size()%>张</h3><br>

    <%
        for(int i=0;i<l.size();i++){
            Picture picture=(Picture) l.get(i);
            String s="../../static/img/upload/"+picture.getPath();
            System.out.println(s);
            %><img src="<%=s%>" width="150px;" height="150px"/><br><br><%
        }
    %>
    <br><br>
    <a href="upload.jsp" class="yellow-int">继续上传</a></center>
<%
    }
%>
</body>


</html>

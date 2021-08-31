<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Manager" %>
<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
<%@ page import="com.springboot.dataObject.Help" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../static/css/news/style.css" rel="stylesheet" type="text/css">
</head>

<body >
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 消息管理  > 我的消息</div>
        <%
            String pages=request.getParameter("page");
            int p = Integer.parseInt(pages);
            List m=(List)request.getSession().getAttribute("usermsg");
            if(m==null){
        %>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>编号</th>
                    <th>管理员ID</th>
                    <th>操作</th>
                </tr>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第1 / 1页,每页10条，共 0条记录</div>
            <div class="xt-fenye-right">
                <a href="http://localhost:8080/myhelp.jsp?page=1">首页</a>
                <a href="http://localhost:8080/myhelp.jsp?page=1">上一步</a>
                <a href="http://localhost:8080/myhelp.jsp?page=1">下一步</a>
                <a href="http://localhost:8080/myhelp.jsp?page=1">尾页</a>
                <input type="text" name="text" />
                <a href="http://localhost:8080/myhelp.jsp?page=1" class="xt-link">跳转</a>
            </div>
        </div>
        <%}else{%>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>编号</th>
                    <th>管理员ID</th>
                    <th>操作</th>
                </tr>
                <%
                    Integer totalpages=(m.size()-(m.size()%10))/10+1;
                    for(int i=0;i<((m.size()-10*(p-1))<10?(m.size()-10*(p-1)):10);i++){
                        Integer mid=(Integer) m.get(i+(p-1)*10);
                %>
                <tr class="xt-bg">
                    <td><%=i+(p-1)*10+1%></td>
                    <td><%=mid%></td>
                    <td>
                        <a href="javascript:void (0);"  onclick="respondbyid(<%=mid%>);" class="green-xt">聊天详情</a>
                    </td>
                </tr>
                <%}%>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第<%=pages%> /<%=totalpages%> 页,每页10条，共 <%=m.size()%>条记录</div>
            <div class="xt-fenye-right">
                <a href="myhelp.jsp?page=1">首页</a>
                <a href="http://localhost:8080/myhelp.jsp?page=<%if(p==1){%><%=1%><%}else{%><%=p-1%><%}%>">上一步</a>
                <a href= "javascript:void (0);" onclick="next();">下一步</a>
                <a href="myhelp.jsp?page=<%=totalpages%>">尾页</a>
                <input type="text" id="nlink1" name="text" />
                <a href="javascript:void (0);" onclick="jumpto();"  class="xt-link">跳转</a>
            </div>
        </div>


    </div>
</div>
<script type="text/javascript">
    function next(){
        window.location.href="http://localhost:8080manager/myhelp.jsp?page=<%if(p>=totalpages){%><%=totalpages%><%}else{%><%=p+1%><%}%>";
    }
</script>
<script type="text/javascript">
    function jumpto(){
        var jumpto=document.getElementById("nlink1").value;
        if (jumpto >=<%=totalpages%>){
            jumpto=<%=totalpages%>;
        } else if (jumpto<=1){
            jumpto=1;
        }
        window.location.href="http://localhost:8080/myhelp.jsp?page="+jumpto;
    }
</script>
<% }%>
<script src="../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function respondbyid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/userhelp",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.location.href="http://localhost:8080/userhelp.jsp?mid="+id;
            }
        )
    }
</script>
</body>
</html>
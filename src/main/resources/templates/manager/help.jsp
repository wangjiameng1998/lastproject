<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Manager" %>
<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
<%@ page import="com.springboot.dataObject.Help" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../static/css/news/style.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../../static/css/style.css" media="all" />
    <link rel="stylesheet" href="../../static/css/base.css" />
    <link rel="stylesheet" type="text/css" href="../../static/css/jquery.dialog.css" />
    <link rel="stylesheet" href="../../static/css/index.css" />

</head>
<%
    String string=request.getParameter("uid");
    Integer uid=Integer.parseInt(string);
%>
<body >
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 消息管理  > 用户消息</div>
        <%
            List list=(List)request.getSession().getAttribute("help");
            if(list==null||list.size()==0){
        %>无消息。
        <br><div class="xt-input"><input type="text" id="huifuu" placeholder="请输入" />
        <input type="button"  onclick="huifu2(<%=uid%>)" value="发送" class="green-int" /></div>
        <script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            function huifu2(id) {
                jQuery.support.cors = true;
                $.post("http://localhost:8080/huifu",
                    //发送给后端的数据
                    {"id":id, "content":document.getElementById("huifuu").value
                    },
                    //回调函数
                    function(data){
                        reloadhelp(<%=uid%>);
                    }
                )
            }
        </script>
        <%}else{
        %> <div class="xt-input"><%
        for(int i=0;i<list.size();i++){
            Help help=(Help)list.get(i);
            if(help.getHelpsend()==0){
    %>

        <br> <img style="vertical-align: middle;" src="../../static/img/images/IDnum.png"/><span>ID为<%=help.getHelpuser()%>的用户：<%=help.getHelpques()%></span>

        <%
        }
        else{
        %>
        <br><img style="vertical-align: middle;" src="../../static/img/images/reason.png"/><span>回复：<%=help.getHelpques()%></span>

        <%
            }
        %>
        <% }%></div><%
        Help help1=(Help)list.get(0);
    %>  <br><div class="xt-input"><input type="text" placeholder="请输入" id="huifu"/>
        <input type="button" id="button" onclick="huifu(<%=help1.getHelpuser()%>)" value="发送" class="green-int" /></div>

    </div></div>
<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
function huifu(id) {
    jQuery.support.cors = true;
    $.post("http://localhost:8080/huifu",
        //发送给后端的数据
        {"id":id, "content":document.getElementById("huifu").value
        },
        //回调函数
        function(data){
            reloadhelp(<%=help1.getHelpuser()%>);
}
    )
}
</script>
<script type="text/javascript">
    function reloadhelp(id) {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/reloadmhelp",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.location.href = "help.jsp?uid="+id;
            }
        )
    }
</script>
<%  }%>
</body>
</html>
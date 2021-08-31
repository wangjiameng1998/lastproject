<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
<%@ page import="com.springboot.dataObject.Manager" %>
<%@ page import="com.springboot.dataObject.User" %>
<%@ page import="com.springboot.controller.viewobject.UserVO" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../static/css/news/style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../static/js/jquery-2.1.1.min.js"></script>
    <style type="text/css">
        .bbD{font-size: 20px;}
    </style>
</head>
<body>
<%
        UserVO user=(UserVO)request.getSession().getAttribute("user");
        %>
<div class="xt-center">
    <div id="xt-right">
    <div class="xt-bt">功能导航> 账号管理 > 用户账号</div>
</div></div>
<div class="xt-left">

    <center><br><br><br>
        <div class="bbD"><img style="width: 100px;height: 100px;" src="../static/img/picture/fileinput.jpg"></div><br>
        <div class="bbD"><span>电话：<%=user.getUsertele()%></span></div><br>
        <div class="bbD"><span>用户名：<%=user.getUsername()%></span></div><br>
        <div class="bbD"><span>性别：<%=user.getUsersex()%></span></div><br>
        <div class="bbD"><span>地址：<%=user.getUseraddress()%></span></div><br>
        <div class="bbD"><span>邮箱：<%=user.getUsermail()%></span></div><br>
        <div class="bbD">
            <p class="bbDP">
                <input type="button" id="button3" onclick="mqueding()" value="确 定" class="green-int" />
                <input type="button" id="button4" onclick="mcancel()" value="修改" class="yellow-int" />
            </p>
        </div>
    </center>
</div>

<script src="../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function mqueding(){
        window.history.go(-1);
    }
</script>
<script type="text/javascript">
    function mcancel(){
        window.location.href="userchange.jsp";
    }
</script>
</body>
</html>

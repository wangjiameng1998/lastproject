<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
<%@ page import="com.springboot.dataObject.Manager" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../../static/css/news/style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../../static/js/jquery-2.1.1.min.js"></script>
    <style type="text/css">
        .bbD{font-size: 20px;}
    </style>
</head>
<body>
<%
    ManagerVO managerVO=(ManagerVO) request.getSession().getAttribute("manager");
    if(managerVO == null){
        pageContext.forward("http://localhost:8080/error.jsp");
    }else{
        Manager manager=(Manager)request.getSession().getAttribute("getlowmanager");
String s;
if(manager.getmanagerpower()==0){
    s = "员工权限";
}
else if(manager.getmanagerpower()/10==2){
    s = "员工账号被冻结，点击解冻";
}
else{
    s = "此员工不存在";
}
%>
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 账号管理 > 员工账号</div>
    </div>
</div>
<div class="xt-left">

    <center><br><br><br>
        <div class="bbD"><span>中介员工号：<%=manager.getManagerid()%></span></div><br>
        <div class="bbD"><span>用户名：<%=manager.getManagername()%></span></div><br>
        <div class="bbD"><span>性别：<%=manager.getManagersex()%></span></div><br>
        <div class="bbD"><span>权限：<%=s%></span></div><br>
        <div class="bbD">
            <p class="bbDP">
                <input type="button" id="button3" onclick="mqueding()" value="确 定" class="green-int" />
                <input type="button" id="button4" onclick="mcancel()" value="返回首页" class="yellow-int" />
            </p>
        </div>
    </center>
</div>
<%}%>
<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function mcancel(){
        document.location.href = "http://localhost:8080/manager/home.jsp";
    }
</script>
<script type="text/javascript">
    function mqueding(){
        window.history.go(-1);
    }
</script>
</body>
</html>
<body>
</body>
</html>

<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
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
    if(managerVO==null){
        pageContext.forward("http://localhost:8080/error.jsp");
    }else{
%>
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 账号管理 > 个人账号</div>
    </div>
</div>
<div class="xt-left">

    <center><br><br><br>
                <div class="bbD"><span>管理员员工号：<%=managerVO.getManagerid()%></span></div><br>
                <div class="bbD"><span>管理员用户名：<%=managerVO.getManagername()%></span></div><br>
                <div class="bbD"><span>管理员性别：<%=managerVO.getManagersex()%></span></div><br>
                <div class="bbD"><span>输入旧密码：</span><input type="password" class="input3" id="pass" /></div><br>
                <div class="bbD"><span>输入新密码：</span><input type="password" class="input3" id="pass2" /> </div><br>
                <div class="bbD"><span>再次确认密码：</span><input type="password" class="input3" id="pass3" /></div><br>
                <div class="bbD">
                    <p class="bbDP">
                        <input type="button" id="button3" onclick="mqueding()" value="确 定" class="green-int" />
                        <input type="button" id="button4" onclick="mcancel()" value="取消" class="yellow-int" />
                    </p>
                </div>
    </center>
</div>
<%}%>
</body>
</html>
<script type="text/javascript">
    function mqueding(){
if (document.getElementById("pass").value==""||document.getElementById("pass2").value==""||document.getElementById("pass3").value=="")
{
    alert("密码字段不能为空");
}  else{
    if (document.getElementById("pass2").value!=document.getElementById("pass3").value) {
        alert("两次密码不相同");
    }else{
    jQuery.support.cors = true;
    $.post("http://localhost:8080/updatemanager",
        //发送给后端的数据
        {"pass":document.getElementById("pass").value,
            "pass2":document.getElementById("pass2").value
        },
        //回调函数
        function(data){
            if (data.result.trim()=="2"){
                window.location.href="http://localhost:8080/error.jsp";
            }else{
                if (data.result.trim()=="1") {
                    window.location.reload();
                }
                else{
                    alert(data.result);
                }
            }
        }
    )
}  }

    }
</script>
<script type="text/javascript">
    function mcancel(){
document.location.href = "http://localhost:8080/manager/manager.jsp";
    }
</script>
<body>


</body>
</html>

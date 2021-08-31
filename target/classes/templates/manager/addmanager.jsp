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
        <div class="xt-bt">功能导航> 账号管理 > 添加员工或管理员</div>
    </div>
    <center><br><br><br>
        <div class="xt-input">
            <%--<span>账号/邮箱</span><input type="text" class="int-text" />--%>
            <span>添加员工</span>
            <select id="mselect"  class="int-text"name="mselect">
                <option value="0" id="0" >中介</option>
                <option value="1" id="1">管理员</option>
            </select>
        </div>
                <div class="bbD"><span>姓名：</span><input type="text" class="input3" id="mname" /></div><br>
                <div class="bbD"><span>性别：&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="text" class="input3" id="msex" /></div><br>
                <div class="bbD"><span>输入密码：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="password" class="input3" id="pass" /> </div><br>
                <div class="bbD"><span>确认密码：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><input type="password" class="input3" id="pass2" /></div><br>
                <div class="bbD">
                    <p class="bbDP">
                        <input type="button" id="button3" onclick="mqueding()" value="确 定" class="green-int" />&nbsp;&nbsp;&nbsp;&nbsp;
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
        if (document.getElementById("mname").value==""||document.getElementById("msex").value=="") {
            alert("用户名与性别不能为空");
        }else{
if (document.getElementById("pass").value==""||document.getElementById("pass2").value=="")
{
    alert("密码字段不能为空");
}  else{
    if (document.getElementById("pass2").value!=document.getElementById("pass").value) {
        alert("两次密码不相同");
    }else{
    jQuery.support.cors = true;
    $.post("http://localhost:8080/addmanager",
        //发送给后端的数据
        {"mpass":document.getElementById("pass").value,
            "mname":document.getElementById("mname").value,
            "mselect":document.getElementById("mselect").value,
            "msex":document.getElementById("msex").value
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
    }
</script>
<script type="text/javascript">
    function mcancel(){
document.location.href = "http://localhost:8080/manager/addmanager.jsp";
    }
</script>
<body>
</body>
</html>

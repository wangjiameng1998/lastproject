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
    if(user!=null){
%>
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 个人账号管理 > 修改密码</div>
    </div>
</div>
<div class="xt-left">

    <center><br><br><br>
        <div class="bbD"><span>电话：<%=user.getUsertele()%></span></div><br>
        <div class="bbD"><span>用户名：<%=user.getUsername()%></span></div><br>
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
<script src="../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function mcancel(){
        document.location.reload();
    }
</script>
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
                $.post("http://localhost:8080/userchangepass",
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
                                window.parent.location.href="http://localhost:8080/userreload";
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
</body>
</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>登录</title>

    <script type="text/javascript" src="../static/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="../static/js/login.js"></script>
    <link rel="stylesheet" type="text/css"  href="../static/css/tanchucss/style.css"/>

</head>
<body>

<%
String i=(String)request.getParameter("id");
Integer id=Integer.parseInt(i);
%>
<center>
<div class="login-input-content">
    <div class="login-input">
        <label>投诉管理员ID：</label>
        <input type="text" placeholder="<%=id%>" name="mid" id="mid" class="list-input"/>
    </div>
    <div class="login-input">
        <label>投诉理由：</label>
        <input type="text" placeholder="请输入" id="pass" class="list-input"/>
    </div>
</div>
</center>
<div class="login-button"><a href="javascript:void(0);" onclick="com(<%=id%>)">投诉</a></div>

</body>
<script>
    function com(id) {
        jQuery.support.cors = true;
        if(window.document.getElementById("pass").value==""){
            alert("投诉理由不能为空！");
        }else{
            $.post("http://localhost:8080/addcom",
                //发送给后端的数据
                {"id":id,"content":window.document.getElementById("pass").value,
                },
                //回调函数
                function(data){
                if (data.result.trim()=="1"){
                    window.location.href="http://localhost:8080/mycom.jsp?mcpage=1";
                } else{
                    alert(data.result);
                    window.location.href="http://localhost:8080/mycom.jsp?mcpage=1";
                }

                }
            )
        }
    }
</script>
</html>
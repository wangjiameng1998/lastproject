<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录</title>
    <style type="text/css">
        .center{text-align: center;}
        .login-page {
            width: 360px;
            padding: 8% 0 0;
            margin: auto;
        }
        .form {
            position: relative;
            z-index: 1;
            background: #FFFFFF;
            max-width: 360px;
            margin: 0 auto 100px;
            padding: 45px;
            text-align: center;
            box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
        }
        .form input {
            font-family: "Roboto", sans-serif;
            outline: 0;
            background: #f2f2f2;
            width: 100%;
            border: 0;
            margin: 0 0 15px;
            padding: 15px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .form button {
            font-family: "Microsoft YaHei","Roboto", sans-serif;
            text-transform: uppercase;
            outline: 0;
            background: #79bbe5;
            width: 100%;
            border: 0;
            padding: 15px;
            color: #FFFFFF;
            font-size: 14px;
            -webkit-transition: all 0.3 ease;
            transition: all 0.3 ease;
            cursor: pointer;
        }
        .form button:hover,.form button:active,.form button:focus {
            background: #79bbe5;
        }
        .form .message {
            margin: 15px 0 0;
            color: #b3b3b3;
            font-size: 14px;
        }
        .form .message a {
            color: #79bbe5;
            text-decoration: none;
        }
        .form .register-form {
            display: none;
        }
        .container {
            position: relative;
            z-index: 1;
            max-width: 300px;
            margin: 0 auto;
        }
        .container:before, .container:after {
            content: "";
            display: block;
            clear: both;
        }
        .container .info {
            margin: 50px auto;
            text-align: center;
        }
        .container .info h1 {
            margin: 0 0 15px;
            padding: 0;
            font-size: 36px;
            font-weight: 300;
            color: #1a1a1a;
        }
        .container .info span {
            color: #4d4d4d;
            font-size: 12px;
        }
        .container .info span a {
            color: #000000;
            text-decoration: none;
        }
        .container .info span .fa {
            color: #EF3B3A;
        }
        body {
            background: url("../../static/img/back2.jpg")no-repeat ;
            background-size:cover;
            background-color: #79bbe5;
            -webkit-animation-duration: 1s;
            animation-duration: 1s;
        }

        p.center{
            color: #fff;font-family: "Microsoft YaHei";
        }
    </style>
<% if(request.getSession().getAttribute("manager")!=null){
    request.getSession().removeAttribute("manager");
}
%>
</head>
<body>
<div class="htmleaf-container">
    <div id="wrapper" class="login-page">
        <div id="login_form" class="form">
            <form class="login-form">
                <input type="text" required placeholder="员工号" required="required" name="managerid" id="managerid"/>
                <input type="password" required placeholder="密码" required="required" id="mpassword" name="mpassword"/>
                <button type="button"  id="tologin">登录</button>
            </form>
        </div>
    </div>
</div>

<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    $("#tologin").click(function(){
        if($("#managerid").val()==null || $("#mpassword").val()==null || $("#managerid").val()==="" ||$("#mpassword").val()==="")
        {
            alert("员工号和密码不能为空！");

        }
        jQuery.support.cors = true;
        $.post("http://localhost:8080/managerget",
            //发送给后端的数据
            {
                "managerid":document.getElementById("managerid").value,
                "mpassword":document.getElementById("mpassword").value
            },
            //回调函数
            function(data){
            if (data.result.trim()=="高级管理员登录成功") {
                alert("登录成功");
                window.location.href="http://localhost:8080/manager/mindex.jsp";
            }
            else if(data.result.trim()=="低级管理员登录成功") {
                alert("登录成功");
                    window.location.href="http://localhost:8080/manager/agentindex.jsp";
                }
               else {
                alert(data.result);
            }
            }
        )
    })
</script>

</body>
</html>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册</title>

    <style type="text/css">
        .center{text-align: center;}
        .login-page {
            width: 360px;
            padding: 8% 0 0;
            margin: auto;
        }

        .form button:hover,.form button:active,.form button:focus {
            background: #43A047;
        }
        .innerTab .message {
            margin: 15px 0 0;
            color: #b3b3b3;
            font-size: 12px;
        }
        .innerTab .message a {
            color:  #79bbe5;
            text-decoration: none;
        }
        .innerTab .register-form {
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
            background: url("../static/img/back2.jpg")no-repeat ;
            background-size:cover;
            background-color: #79bbe5;

        }

        /*register.css*/
        /* 重置样式 */
        body,html,ul,ol,li,h1,h2,h3,h4,h5,h6,p {
            padding: 0;
            margin: 0;
            font: 12px Arial,Helvetica,sans-serif;
        }
        h1, h2, h3, h4, h5, h6 {
            font-weight: normal;
        }
        li {
            list-style: none;
        }
        a {
            text-decoration: none;
        }
        img {
            vertical-align: top;
            color:#999;
            font-size:14px;
        }
        .fl {
            float: left;
        }
        .fr {
            float: right;
        }
        .clear:after{
            content: '';
            display: block;
            clear: both;
        }
        #secTab {
            padding-top: 26px;
        }
        .innerTab {
            width: 330px;
            position: relative;
            z-index: 1;
            background: #FFFFFF;
            max-width: 360px;
            margin: 0 auto 100px;
            padding: 45px;
            text-align: center;
            box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
        }
        .innerTab>h2 {
            text-align: center;
            font: bold 24px/50px "microsoft yahei";


        }
        .tableItem {
            position: relative;
            z-index: 100;
            height: 24px;
            margin-bottom: 10px;
            padding: 14px 0;
            border: 1px solid #dedede;
            background: #FFF;
            line-height: 24px;
        }
        .tableItem span {
            position: absolute;
            left: 20px;
            top: 0;
            display: none;
            height: 50px;
            font: 14px/50px "sisum";
            color: #666;
        }

        .onlyItem {
            width: 192px!important;
        }
        .tableText {
            display: inline-block;
            /*position: relative;*/
            /*z-index: 2;*/
            width: 126px;
            height: 50px;
            margin-left: 10px;
            text-align: center;
            background-color: #57565f;
            font: bold 12px/52px "sisum";
            color: #fff;
            cursor: default;
            border-radius: 2px;
            font-size: 14px;
        }
        .tableItem input {
            vertical-align: middle;
            width: 100%;
            height: 24px;
            padding: 0 20px;
            border: 0 none;
            line-height: 24px;
            vertical-align: middle;
            font-family: "Microsoft YaHei";
            font-size: 14px;
            outline: none;
            box-sizing: border-box;
        }
        .clickRegist {
            height: 35px;
            line-height: 35px;
            color: #666;
            text-indent: 1em;
        }
        .clickRegist a {
            color: #06c;
        }
        /*按钮*/
        .tableBtn {
            width: 330px;
            height: 52px;
            border: 0 none;
            border-radius: 3px;
            background: #79bbe5;
            font-size: 16px;
            color:#FFFFFF;
            cursor: pointer;
            text-shadow: 1px 1px 1px #ff7373;
            font-family: "Microsoft YaHei";
            line-height: 52px;
        }
    </style>

    <script type="text/javascript">
        function getverify() {
            var tele=$("#telephone").valueOf();
            $.ajax({
                url:"/usergetOtp",
                type:"get",
                contentType: "application/json;charset=utf-8",
                data:{},
                traditional : true,
                async : false,
                //注意序列化的值一定要放在最前面,并且不需要头部变量,不然获取的值得格式会有问题
                success:function (data) {
                    alert("验证码为"+data.result);
                }
            })
        }
    </script>

</head>
<body>
<div id="wrapper" class="login-page">
<section id="secTab">
    <div  id="innerTab"  class="innerTab">
        <form>
            <div class="tableItem">
                <span class="userPhone">手机号</span>
                <input type="text" required placeholder="手机号" id="telephone" name="telephone"/>
            </div>
            <div class="clear">
                <div class="tableItem onlyItem fl">
                    <span class="userPhone">验证码</span>
                    <input  type="text" required placeholder="验证码" id="check" name="check"/>
                </div>
                <button class="tableText fr" onclick="getverify()" >获取验证码</button>
            </div>
            <div class="tableItem">
                <span class="setPass">设置密码</span>
                <input type="password" required placeholder="密码" id="r_password" name="r_password"/>
            </div>
            <div class="tableItem">
                <span class="turePass">确认密码</span>
                <input type="password" required placeholder="确认密码" id="r_password2" name="r_password2"/>
            </div>
            <button type="button" class="tableBtn" id="toregister">注册</button>
            <p class="message">已经有了一个账户? <a href="login.jsp">立刻登录</a></p>
        </form>
    </div>
</section>
</div>
<script src="../static/js/jquery-2.1.1.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    $("#toregister").click(function(){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/usertoregister",
            //发送给后端的数据
            {
                "telephone":$("#telephone").val(),
                "r_password":$("#r_password").val(),
                "r_password2":$("#r_password2").val(),
                "check":$("#check").val()
            },
            //回调函数
            function(data){
                if (data.result.trim()=="注册成功") {
                    alert(data.result);
                    window.location.href="http://localhost:8080/index.jsp";
                }
                else{
                    alert(data.result);
                }
            }
        )
    })
</script>

</body>
</html>
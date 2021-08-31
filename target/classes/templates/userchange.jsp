<%@ page import="com.springboot.dataObject.User" %>
<%@ page import="com.springboot.controller.viewobject.UserVO" %>
<html>
<head><%@ page contentType="text/html; charset=utf-8" %>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="../static/js/address.js"></script>
    <link href="../static/css/news/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<%
    UserVO user=(UserVO)request.getSession().getAttribute("user");
    %>
<%--地址定位--%>
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 个人账户管理 > 更新个人信息</div>
        <div class="xt-input">
            <%--<span>账号/邮箱</span><input type="text" class="int-text" />--%>
            <span>用户名：</span><input type="text" id="name" value="<%=user.getUsername()%>" class="int-text" />
        </div>
        <div class="xt-input">
            <%--<span>账号/邮箱</span><input type="text" class="int-text" />--%>
            <span>电话：</span><input type="text" id="tele" value="<%=user.getUsertele()%>" class="int-text" />
        </div>
        <div class="xt-input">
            <span>性别</span><input type="text" id="sex" value="<%=user.getUsersex()%>" class="int-text" />
        </div>
        <div class="xt-input">
            <%--<span>账号/邮箱</span><input type="text" class="int-text" />--%>
            <span>居中地址:<%=user.getUseraddress()%></span>
            <select  class="int-text" id="cmbProvince" name="cmbProvince"></select>
            <select  class="int-text" id="cmbCity" name="cmbCity"></select>
            <select  class="int-text" id="cmbArea" name="cmbArea"></select>
            <span>详细地址：</span><input type="text" id="address" value="" class="int-text" />
        </div>
        <div class="xt-input">
            <span>邮箱</span><input type="text" id="mail" placeholder="选填" value="<%=user.getUsermail()%>" class="int-text" />
        </div>

        <center>
            <input type="button" id="button1" onclick="submithto(<%=user.getUserid()%>)" value="提交" class="green-int" />
            <input type="button" id="button2" onclick="tocancel()" value="取消" class="yellow-int" /></center>
    </div>
</div>
<script src="../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function submithto(id){
        jQuery.support.cors = true;
        var address=document.getElementById("cmbProvince").value+document.getElementById("cmbCity").value+document.getElementById("cmbArea").value+document.getElementById("address").value;
        $.post("http://localhost:8080/userupdate",
            //发送给后端的数据
            {"address":address,
                "id":id,
                "name":document.getElementById("name").value,
                "tele":document.getElementById("tele").value,
                "sex":document.getElementById("sex").value,
                "mail":document.getElementById("mail").value
            },
            //回调函数
            function(data){
                window.parent.location.href="http://localhost:8080/userreload";
            }
        )
    }
</script>
<script type="text/javascript">
    function tocancel() {
        window.location.reload();
    }
</script>
<script type="text/javascript">
    addressInit('cmbProvince', 'cmbCity', 'cmbArea');
</script>
</body>
</html>


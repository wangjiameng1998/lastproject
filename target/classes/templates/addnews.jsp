<%@ page contentType="text/html; charset=utf-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>添加公告</title>
    <link href=".././static/css/news/style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../static/js/jquery-2.1.1.min.js"></script>
    <style type="text/css">
        .add-text1{width:100%; height:20px}
        .add-text2{text-align:left;box-sizing:border-box;width:100%; height:280px;font-family: "宋体"}
    </style>
</head>
<body>
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 发布管理 > 添加发布</div>
    </div>
        <div class="xt-input">
            <%--<span>账号/邮箱</span><input type="text" class="int-text" />--%>
            <span>发布类型</span>
            <select id="addselect"  class="int-text"name="addselect">
                <option value="1" id="1">页面公告</option>
                <option value="2" id="2">热门百科</option>
                <option value="3" id="3" >相关链接</option>
                <option value="4" id="4" >首页帮助</option>
                <option value="5" id="5" >关于我们</option>
            </select>
    </div>
        <div class="add-input">
            <span>标题</span><textarea id="addtitle" required="required" class="add-text1"></textarea><br><br>
            <span>内容</span><textarea id="addcontent" required="required" class="add-text2"></textarea>
            <center>
                <input type="button" id="button2" onclick="queding();" value="确 定" class="green-int" />
                <input type="button" id="button3" onclick="cancel()" value="取消" class="yellow-int" />
            </center>

        </div>
</div>
</body>
</html>
<script src="../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function queding(){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/addnews",
            //发送给后端的数据
            {"addtitle":document.getElementById("addtitle").value,
            "addcontent":document.getElementById("addcontent").value,
                "addselect":document.getElementById("addselect").value
            },
            //回调函数
            function(data){
            if (data.result.trim()=="2"){
                window.location.href="http://localhost:8080/error.jsp";
            }else{
                window.location.reload();
            }
            }
        )
    }
</script>
<script type="text/javascript">
    function cancel(){
document.location.href = "http://localhost:8080/news.jsp";
    }
</script>
<body>


</body>
</html>

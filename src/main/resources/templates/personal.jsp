<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
<%@ page import="com.springboot.controller.viewobject.UserVO" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../static/css/bootstrap.min.css" media="all" />
    <link rel="stylesheet" type="text/css" href="../static/vendors/bootstrap-select/bootstrap-select.min.css" media="all" />
    <link rel="stylesheet" type="text/css" href="../static/vendors/flexslider/css/flexslider.css" media="all" />
    <link rel="stylesheet" type="text/css" href="../static/vendors/owl-carousel/owl.carousel.css" media="all" />
    <link rel="stylesheet" href="../static/vendors/linearicons/Linearicons.css">
    <link rel="stylesheet" href="../static/vendors/font-awesome/css/font-awesome.min.css">
    <link href="../static/css/news/style.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../static/css/style.css" media="all" />
    <link rel="stylesheet" href="../static/css/base.css" />
    <link rel="stylesheet" type="text/css" href="../static/css/jquery.dialog.css" />
    <link rel="stylesheet" href="../static/css/index.css" />
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>毕设二手房交易网站</title>
</head>
<%
    UserVO userVO=new UserVO();
    userVO=(UserVO) request.getSession().getAttribute("user");
    if(userVO!=null){
%>

<body>
<header class="header_top_section row">
    <div class="container coustome-container">
        <div class="row top_header">
            <a href="http://localhost:8080/index"></i> 首页</a>
            <a href="http://localhost:8080/personal.jsp">个人中心</a>
                <ul>
                <li><a href="http://localhost:8080/reload"><%=userVO.getUsertele()%>，欢迎您！</a></li>
                <li><a href="#">帮助</a></li>
                    <li><a  href="http://localhost:8080/exit">退出</a></li>

            </ul>
        </div>
    </div>
</header>
<div id="container">
    <div id="hd">

        <div id="bd">
            <div class="wrap ue-clear">
                <div class="sidebar">
                    <h2 class="sidebar-header"><p>功能导航</p></h2>
                    <ul class="nav">
                        <li class="gongwen">
                            <div class="nav-header">
                                <a href="javascript:void (0);" onclick="myorder();" class="ue-clear"><span>我的订单</span><i class="icon"></i></a></div>
                        </li>
                        <li class="agency">
                            <div class="nav-header"><a href="javascript:;" class="ue-clear"><span>账号管理</span><i class="icon"></i></a></div>
                            <ul class="subnav">
                                <li><em><a href="javascript:void (0);" onclick="my()">个人账号管理</a></em></li>
                                <li><em><a href="javascript:void (0);" onclick="change()">修改密码</a></em></li>
                            </ul>
                        </li>
                        <li class="email">
                            <div class="nav-header"><a href="javascript:void (0);" id="com" onclick="mycom()" class="ue-clear"><span>我的投诉</span><i class="icon"></i></a></div>
                        </li>
                        <li class="system">
                            <div class="nav-header"><a href="javascript:;" onclick="help()" class="ue-clear"><span>消息管理</span><i class="icon"></i></a></div>
                        </li>
                        <li class="nav-info">
                            <div class="nav-header"><a href="javascript:;" onclick="like()"  id="like" class="ue-clear"><span>我的关注</span><i class="icon"></i></a></div>
                        </li>
                    </ul>
                </div>
                <div  id="inner" class="content">
                    <iframe src="userorder.jsp" id="iframe" width="100%" height="100%" frameborder="0"></iframe>
                </div>
            </div>
        </div>
        <div id="ft" class="ue-clear">
            <div class="ft-left">
                <span>二手房交易后台管理系统</span>
                <em>Manage&nbsp;System</em>
            </div>
            <div class="ft-right">
                <span>Automation</span>
                <em>&nbsp;2019</em>
            </div>
        </div>
    </div>

</div>
<script type="text/javascript" src="../static/js/jquery.min.js"></script>
<script type="text/javascript" src="../static/js/common.js"></script>
<script type="text/javascript" src="../static/js/core.js"></script>
<script type="text/javascript" src="../static/js/jquery.dialog.js"></script>
<script type="text/javascript" src="../static/js/index.js"></script>
<script src="../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script>
    function my() {
        document.getElementById("iframe").src="http://localhost:8080/user.jsp";
    }
</script>
<script>
    function change() {
        document.getElementById("iframe").src="http://localhost:8080/passchange.jsp";
    }
</script>
<script>
    function like() {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/mylike",
            //发送给后端的数据
            {"id":1},
            //回调函数
            function(data) {
                document.getElementById("iframe").src = "http://localhost:8080/userlike.jsp";
            }
        )
    }
</script>
<script>
    function help() {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/mymsg",
            //发送给后端的数据
            {"id":1},
            //回调函数
            function(data){
                document.getElementById("iframe").src="http://localhost:8080/myhelp.jsp?page=1";
            }
        )
    }
</script>
<script type="text/javascript">
    function mycom(){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/mycom",
            //发送给后端的数据
            {"id":1},
            //回调函数
            function(data){
                document.getElementById("iframe").src="http://localhost:8080/mycom.jsp?mcpage=1";
            }
        )
    }
</script>

<script type="text/javascript">
    function myorder(){
        document.getElementById("iframe").src="http://localhost:8080/userorder.jsp";
    }
</script>
</body>
<%}
else{
    pageContext.forward("uerror.jsp");
}
%>
</html>


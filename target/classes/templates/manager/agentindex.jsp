<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../../static/css/base.css" />
    <link rel="stylesheet" type="text/css" href="../../static/css/jquery.dialog.css" />
    <link rel="stylesheet" href="../../static/css/index.css" />
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>毕设二手房交易网站</title>
</head>
<%
    ManagerVO managerVO=new ManagerVO();
    managerVO=(ManagerVO) request.getSession().getAttribute("manager");
    if(managerVO==null){
        pageContext.forward("http://localhost:8080/error.jsp");
    }else{
%>
<body>
<div id="container">
    <div id="hd">
        <div class="hd-wrap ue-clear">
            <div class="top-light"></div>
            <div class="login-info ue-clear">
                <div class="welcome ue-clear"><span>欢迎您,员工</span>
                    <%
                        if(managerVO!=null){
                    %>
                    <a href="javascript:;" class="user-name"><%=managerVO.getManagername()%>！</a>
                    <%
                    }else{
                    %><a href="http://localhost:8080/manager/mlogin.jsp" class="user-name">，请先登录！</a><%
                        }
                    %>
                </div>
                <div class="login-msg ue-clear">
                    <a href="javascript:;" class="msg-txt">通知</a>
                    <a href="javascript:;" class="msg-num">13</a>
                </div>
            </div>
            <div class="toolbar ue-clear">
                <div class="nav-header"><a href="agentindex.jsp" id="index" class="home-btn">首页</a>&nbsp;
                    <a href="http://localhost:8080/manager/mlogin.jsp" onclick="exit()"  class="quit-btn exit">退出</a>
                    <script>
                        function exit() {sessionStorage.clear();   //清除所有session值
                        }
                    </script>
                </div>
            </div>
        </div>
        <div id="bd">
            <div class="wrap ue-clear">
                <div class="sidebar">

                    <h2 class="sidebar-header"><p>功能导航</p></h2>
                    <ul class="nav">
                        <li class="gongwen">
                            <div class="nav-header">
                                <a href="javascript:void (0);" onclick="news();" class="ue-clear"><span>查看公告</span><i class="icon"></i></a></div>
                        </li>
                        <li class="nav-info">
                            <div class="nav-header"><a href="javascript:;" class="ue-clear"><span>账号管理</span><i class="icon"></i></a></div>
                            <ul class="subnav">
                                <li><em><a href="javascript:void (0);" onclick="managerp();">个人账号管理</a></em></li>
                            </ul>
                        </li>
                        <li class="agency">
                            <div class="nav-header"><a href="javascript:;" class="ue-clear"><span>交易管理</span><i class="icon"></i></a></div>
                            <ul class="subnav">
                                <li><em><a href="javascript:void (0);" id="state2" onclick="lookmyorder(2);" >正在交易</a></em></li>
                                <li><em><a href="javascript:void (0);"  id="state1" onclick="lookmyorder(1);" >已完成交易</a></em></li>
                                <li><em><a href="javascript:void (0);"  id="state0" onclick="lookmyorder(0);" >所有交易</a></em></li>
                            </ul>
                        </li>
                        <li class="system">
                            <div class="nav-header"><a href="javascript:;" class="ue-clear"><span>房源管理</span><i class="icon"></i></a></div>
                            <ul class="subnav">
                                <li><em><a href="javascript:void (0);" onclick="addhouse()" >上传房源</a></em></li>
                                <li><em><a href="javascript:void (0);" id="myaddhouse" onclick="myaddhouse()">我的房源</a></em></li>
                            </ul>
                        </li>
                        <li class="email">
                            <div class="nav-header"><a href="javascript:;" class="ue-clear"><span>消息管理</span><i class="icon"></i></a></div>
                            <ul class="subnav">
                                <li><em><a href="javascript:void (0);" onclick="getallhelp()" id="allhelp">所有记录</a></em></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div  id="inner" class="content">
                    <iframe src="home.jsp" id="iframe" width="100%" height="100%" frameborder="0"></iframe>
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
<script type="text/javascript" src="../../static/js/jquery.min.js"></script>
<script type="text/javascript" src="../../static/js/common.js"></script>
<script type="text/javascript" src="../../static/js/core.js"></script>
<script type="text/javascript" src="../../static/js/jquery.dialog.js"></script>
<script type="text/javascript" src="../../static/js/index.js"></script>
<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>

<script type="text/javascript">
    function mmanager(){
        jQuery.support.cors = true;
        document.getElementById("iframe").src="http://localhost:8080/manager/listmanager.jsp?mpage=1";}
</script>
<script type="text/javascript">
    function managerp(){
        jQuery.support.cors = true;
        document.getElementById("iframe").src="http://localhost:8080/manager/manager.jsp";}
</script>
<script type="text/javascript">
    function getallhelp(){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/getallhelp",
            //发送给后端的数据
            {"id":1},
            //回调函数
            function(data){
                document.getElementById("iframe").src="http://localhost:8080/manager/allhelp.jsp?page=1";
            }
        )
    }
</script>
<script type="text/javascript">
    function news(){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/getallnews",
            //发送给后端的数据
            {"manager":1},
            //回调函数
            function(data){
                document.getElementById("iframe").src="http://localhost:8080/manager/news.jsp?page=1";
            }
        )
    }
</script>
<script type="text/javascript">
    function lookmyorder(state){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/getmyorder",
            //发送给后端的数据
            {"state":state},
            //回调函数
            function(data){
                document.getElementById("iframe").src="http://localhost:8080/manager/myorder.jsp?orderpage=1&&state="+state;
            }
        )
    }
</script>

<script type="text/javascript">
    function myaddhouse(){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/myaddhouse",
            //发送给后端的数据
            {"id":1},
            //回调函数
            function(data){
                document.getElementById("iframe").src="http://localhost:8080/manager/myaddhouse.jsp?page=1";
            }
        )
    }
</script>
<script type="text/javascript">
    function addhouse(){
        jQuery.support.cors = true;
        document.getElementById("iframe").src="http://localhost:8080/manager/housesell.jsp";}
</script>

<%}%>
</body>
</html>


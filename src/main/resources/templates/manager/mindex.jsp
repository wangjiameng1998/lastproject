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
%>
<script>
    function exit() {
        sessionStorage.clear();  //清除所有session值
        window.location.href="http://localhost:8080/manager/mlogin.jsp";
    }
</script>
<body>
<div id="container">
    <div id="hd">
        <div class="hd-wrap ue-clear">
            <div class="top-light"></div>
            <div class="login-info ue-clear">
                <div class="welcome ue-clear"><span>欢迎您,管理员</span>
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
                <div class="nav-header"><a href="mindex.jsp" id="index" class="home-btn">首页</a>&nbsp;
                    <a href="http://localhost:8080/manager/mlogin.jsp"  class="quit-btn exit">退出</a>
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
                                <a href="javascript:;" class="ue-clear"><span>发布管理</span><i class="icon"></i></a></div>
                            <ul class="subnav">
                                        <li><em><a href="javascript:void (0);" id="notice"  onclick="news();">所有发布</a></em></li>
                                        <li><em><a href="javascript:void (0);" onclick="addnews();">添加发布</a></em></li>
                            </ul>
                        </li>
                        <li class="nav-info">
                            <div class="nav-header"><a href="javascript:;" class="ue-clear"><span>账号管理</span><i class="icon"></i></a></div>
                            <ul class="subnav">
                                <li><em><a href="javascript:void (0);" onclick="managerp();">个人账号管理</a></em></li>
                                <li><em><a href="javascript:void (0);" onclick="addmanager();">添加中介或管理员</a></em></li>
                                <li><em><a href="javascript:void (0);" onclick="mmanager();">员工管理</a></em></li>
                            </ul>
                        </li>
                      <li class="agency">
                          <div class="nav-header"><a href="javascript:;" class="ue-clear"><span>交易管理</span><i class="icon"></i></a></div>
                          <ul class="subnav">
                              <li><em><a href="javascript:void (0);" onclick="lookorder();" >所有交易</a></em></li>
                          </ul>
                      </li>

                        <li class="email"><div class="nav-header"><a href="javascript:;" class="ue-clear"><span>投诉处理</span><i class="icon"></i></a></div>
                            <ul class="subnav">
                                <li><em><a href="javascript:void (0);" onclick="newcom()">最新投诉</a></em></li>
                                <li><em><a href="javascript:void (0);" onclick="mycom()">我的处理</a></em></li>
                            </ul>
                        </li>

                        <li class="system">
                            <div class="nav-header"><a href="javascript:;" class="ue-clear"><span>用户管理</span><i class="icon"></i></a></div>
                            <ul class="subnav">
                                <li><em><a href="javascript:void (0);" onclick="alluser()">用户管理</a></em></li>
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
    function addnews(){
        jQuery.support.cors = true;
        document.getElementById("iframe").src="http://localhost:8080/addnews.jsp";}
</script>
<script type="text/javascript">
    function mycom(){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/getmycom",
            //发送给后端的数据
            {"manager":1},
            //回调函数
            function(data){
                document.getElementById("iframe").src="http://localhost:8080/manager/mycomplaint.jsp?mcpage=1";
            }
        )
    }
</script>
<script type="text/javascript">
        function newcom(){
            jQuery.support.cors = true;
            $.post("http://localhost:8080/getallcom",
                //发送给后端的数据
                {"manager":1},
                //回调函数
                function(data){
                    document.getElementById("iframe").src="http://localhost:8080/manager/complaint.jsp?cpage=1";
                }
            )
        }
</script>
<script type="text/javascript">
    function addmanager(){
        jQuery.support.cors = true;
        document.getElementById("iframe").src="http://localhost:8080/manager/addmanager.jsp";}
</script>
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
    function news(){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/getallnews",
            //发送给后端的数据
            {"manager":1},
            //回调函数
            function(data){
                document.getElementById("iframe").src="http://localhost:8080/news.jsp?page=1";
            }
        )
    }
</script>
<script type="text/javascript">
    function lookorder(){
                document.getElementById("iframe").src="http://localhost:8080/manager/orders.jsp?orderpage=1";
    }
</script>
<script type="text/javascript">
    function alluser(){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/getalluser",
            //发送给后端的数据
            {"manager":1},
            //回调函数
            function(data){
                document.getElementById("iframe").src="http://localhost:8080/manager/alluser.jsp?upage=1";
            }
        )
    }
</script>
</body>
</html>


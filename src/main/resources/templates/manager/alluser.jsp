<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Manager" %>
<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
<%@ page import="com.springboot.dataObject.User" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../static/css/news/style.css" rel="stylesheet" type="text/css">
</head>

<body >
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 账号管理 > 员工管理</div>
        <div class="xt-input">
            <%--<span>账号/邮箱</span><input type="text" class="int-text" />--%>
            <span>查找类型</span>
            <select id="select"  class="int-text" name="select">
                <option value="0" id="0">所有用户</option>
                <option value="1" id="1" >用户ID</option>
                <option value="2" id="2">用户姓名</option>
                <option value="3" id="3">用户电话</option>
            </select>
            <span>关键字：</span><input type="text" id="content" required="required" class="int-text" />
            <input type="button" id="button1" onclick="searchuser()" value="确 定" class="green-int" />
        </div>
        <%

            ManagerVO managerVO=(ManagerVO) request.getSession().getAttribute("manager");
            if(managerVO==null){
                pageContext.forward("http://localhost:8080/error.jsp");
            }else{

            String pages=request.getParameter("upage");
            int p = Integer.parseInt(pages);
            List list=(List)request.getSession().getAttribute("userlist");
            if(list==null){
        %>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>编号</th>
                    <th>用户ID</th>
                    <th>员工姓名</th>
                    <th>员工性别</th>
                    <th>用户电话</th>
                    <th>操作</th>
                </tr>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第1 / 1页,每页10条，共 0条记录</div>
            <div class="xt-fenye-right">
                <a href="http://localhost:8080/manager/alluser.jsp?upage=1">首页</a>
                <a href="http://localhost:8080/manager/alluser.jsp?upage=1">上一步</a>
                <a href="http://localhost:8080/manager/alluser.jsp?upage=1">下一步</a>
                <a href="http://localhost:8080/manager/alluser.jsp?upage=1">尾页</a>
                <input type="text" name="text" />
                <a href="http://localhost:8080/manager/alluser.jsp?upage=1" class="xt-link">跳转</a>
            </div>
        </div>
        <%}else{%>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>编号</th>
                    <th>用户ID</th>
                    <th>员工姓名</th>
                    <th>员工性别</th>
                    <th>用户电话</th>
                    <th>操作</th>
                </tr>
                <%
                    Integer totalpages=(list.size()-(list.size()%10))/10+1;
                    for(int i=0;i<((list.size()-10*(p-1))<10?(list.size()-10*(p-1)):10);i++){
                        User user=(User) list.get(i+(p-1)*10);
                        String s;
                        if(user.getUserpower()==0){
                            s = "正常，点击冻结此用户";
                        }
                        else if(user.getUserpower()==1){
                            s = "冻结，点击解冻此用户";
                        }else{
                            s = "此员工已被删除";
                        }
                %>
                     <tr class="xt-bg">
                         <td><%=i+(p-1)*10+1%></td>
                         <td><%=user.getUserid()%></td>
                         <td><%=user.getUsername()%></td>
                         <td><%=user.getUsersex()%></td>
                         <td><%=user.getUsertele()%></td>
                         <%if(user.getUserpower()==0){%>
                         <td><a href="javascript:void (0);" onclick="freezebyuserid(<%=user.getUserid()%>);" class="blue-xt"><%=s%></a><%}else if(user.getUserpower()==1){%>
                         <td><a href="javascript:void (0);" onclick="nofreezebyuserid(<%=user.getUserid()%>);" class="yellow-xt"><%=s%></a><%}else{%>
                         <td><a href="javascript:;" class="yellow-xt"><%=s%></a><%}%></td>
                         <%request.getSession().setAttribute("oneuser",user);%>
                         <td><a href="javascript:void (0);" onclick="getuser(<%=user.getUserid()%>);" class="green-xt">详情</a></td>
                     </tr>
                <%}%>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第<%=pages%> /<%=totalpages%> 页,每页10条，共 <%=list.size()%>条记录</div>
            <div class="xt-fenye-right">
                <a href="alluser.jsp?upage=1">首页</a>
                <a href="http://localhost:8080/manager/alluser.jsp?upage=<%if(p==1){%><%=1%><%}else{%><%=p-1%><%}%>">上一步</a>
                <a href= "javascript:void (0);" onclick="next();">下一步</a>
                <a href="alluser.jsp?upage=<%=totalpages%>">尾页</a>
                <input type="text" id="nlink1" name="nlink1" />
                <a href= "javascript:void (0);" onclick="jump();" class="xt-link">跳转</a>
            </div>
        </div>

    </div>
</div>
<script type="text/javascript">
    function next(){
        window.location.href="http://localhost:8080/manager/alluser.jsp?upage=<%if(p>=totalpages){%><%=totalpages%><%}else{%><%=p+1%><%}%>";
    }
</script>
<script type="text/javascript">
    function jump(){
        var jumpto=document.getElementById("nlink1").value;
        if (jumpto >=<%=totalpages%>){
            jumpto=<%=totalpages%>;
        } else if (jumpto<=1){
            jumpto=1;
        }
        window.location.href="http://localhost:8080/manager/alluser.jsp?upage="+jumpto;
    }
</script>


<% }}%>
<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function getuser(uid){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/getuserbyid",
            //发送给后端的数据
            {"id":uid
            },
            //回调函数
            function(data){
            if (data.result=="1") {
                window.location.href="http://localhost:8080/manager/getuser.jsp";
            }else{
                window.location.href="http://localhost:8080/error.jsp";
            }
            }
        )
    }
</script>
<script type="text/javascript">
    function deletebyuserid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/deletebyuserid",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.document.getElementById("button1").click();
            }
        )
    }
</script>
<script type="text/javascript">
    function freezebyuserid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/freezebyuserid",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.document.getElementById("button1").click();
            }
        )
    }
</script>
<script type="text/javascript">
    function nofreezebyuserid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/nofreezebyuserid",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.document.getElementById("button1").click();
            }
        )
    }
</script>
<script type="text/javascript">
    function searchuser(){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/searchuser",
            //发送给后端的数据
            {"select":document.getElementById("select").value,
            "content":document.getElementById("content").value,
            },
            //回调函数
            function(data){
            if (data.result.trim()!="1"){
                alert(data.result);
            } else{
                window.location.reload();
            }
            }
        )
    }
</script>
</body>
</html>
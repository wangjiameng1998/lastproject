<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Manager" %>
<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
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
            <select id="select5"  class="int-text" name="select5">
                <option value="0" id="0">所有员工</option>
                <option value="1" id="1" >员工号</option>
                <option value="2" id="2">员工姓名</option>
            </select>
            <span>关键字：</span><input type="text" id="content5" required="required" class="int-text" />
            <input type="button" id="button1" onclick="searchm()" value="确 定" class="green-int" />
        </div>
        <%

            ManagerVO managerVO=(ManagerVO) request.getSession().getAttribute("manager");
            if(managerVO==null){
                pageContext.forward("http://localhost:8080/error.jsp");
            }else{

            String pages=request.getParameter("mpage");
            int p = Integer.parseInt(pages);
            List list=(List)request.getSession().getAttribute("lowmanager2");
            if(list==null){
        %>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>编号</th>
                    <th>员工ID</th>
                    <th>员工姓名</th>
                    <th>员工性别</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第1 / 1页,每页10条，共 0条记录</div>
            <div class="xt-fenye-right">
                <a href="http://localhost:8080/manager/listmanager.jsp?mpage=1">首页</a>
                <a href="http://localhost:8080/manager/listmanager.jsp?mpage=1">上一步</a>
                <a href="http://localhost:8080/manager/listmanager.jsp?mpage=1">下一步</a>
                <a href="http://localhost:8080/manager/listmanager.jsp?mpage=1">尾页</a>
                <input type="text" name="text" />
                <a href="http://localhost:8080/manager/listmanager.jsp?mpage=1" class="xt-link">跳转</a>
            </div>
        </div>
        <%}else{%>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>编号</th>
                    <th>员工ID</th>
                    <th>员工姓名</th>
                    <th>员工性别</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                <%
                    Integer totalpages=(list.size()-(list.size()%10))/10+1;
                    for(int i=0;i<((list.size()-10*(p-1))<10?(list.size()-10*(p-1)):10);i++){
                        Manager manager=(Manager) list.get(i+(p-1)*10);
                        String s;
                        if(manager.getmanagerpower()==0||manager.getmanagerpower()==1){
                            s = "正常，点击冻结此员工";
                        }
                        else if(manager.getmanagerpower()/10==2){
                            s = "冻结，点击解冻此员工";
                        }else{
                            s = "此员工已被删除";
                        }
                %>
                     <tr class="xt-bg">
                         <td><%=i+(p-1)*10+1%></td>
                         <td><%=manager.getManagerid()%></td>
                         <td><%=manager.getManagername()%></td>
                         <td><%=manager.getManagersex()%></td>
                         <%if(manager.getmanagerpower()==0||manager.getmanagerpower()==1){%>
                         <td><a href="javascript:void (0);" onclick="freezebymid(<%=manager.getManagerid()%>);" class="blue-xt"><%=s%></a><%}else if(manager.getmanagerpower()/10==2){%>
                         <td><a href="javascript:void (0);" onclick="nofreezebymid(<%=manager.getManagerid()%>);" class="yellow-xt"><%=s%></a><%}else{%>
                         <td><a href="javascript:;" class="yellow-xt"><%=s%></a><%}%></td>
                         <%request.getSession().setAttribute("getlowmanager",manager);%>
                         <td><a href="http://localhost:8080/manager/lowmanager.jsp" class="blue-xt">详情</a></td>
                         <td><a href="javascript:void (0);" onclick="deletebymid(<%=manager.getManagerid()%>);" class="yellow-xt">删除此员工</a></td>
                     </tr>
                <%}%>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第<%=pages%> /<%=totalpages%> 页,每页10条，共 <%=list.size()%>条记录</div>
            <div class="xt-fenye-right">
                <a href="listmanager.jsp?mpage=1">首页</a>
                <a href="http://localhost:8080/manager/listmanager.jsp?mpage=<%if(p==1){%><%=1%><%}else{%><%=p-1%><%}%>">上一步</a>
                <a href= "javascript:void (0);" onclick="next();">下一步</a>
                <a href="listmanager.jsp?mpage=<%=totalpages%>">尾页</a>
                <input type="text" id="nlink" name="nlink" />
                <a href= "javascript:void (0);" onclick="jump();" class="xt-link">跳转</a>
            </div>
        </div>

    </div>
</div>
<script type="text/javascript">
    function next(){
        window.location.href="http://localhost:8080/manager/listmanager.jsp?mpage=<%if(p>=totalpages){%><%=totalpages%><%}else{%><%=p+1%><%}%>";
    }
</script>
<script type="text/javascript">
    function jump(){
        var jumpto=document.getElementById("nlink").value;
        if (jumpto >=<%=totalpages%>){
            jumpto=<%=totalpages%>;
        } else if (jumpto<=1){
            jumpto=1;
        }
        window.location.href="http://localhost:8080/manager/listmanager.jsp?mpage="+jumpto;
    }
</script>


<% }}%>
<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function deletebymid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/deletebymid",
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
    function freezebymid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/freezebymid",
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
    function nofreezebymid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/nofreezebymid",
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
    function searchm(){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/searchm",
            //发送给后端的数据
            {"select5":document.getElementById("select5").value,
            "content5":document.getElementById("content5").value,
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
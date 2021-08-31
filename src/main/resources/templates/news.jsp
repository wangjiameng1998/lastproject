<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Notice" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href=".././static/css/news/style.css" rel="stylesheet" type="text/css">
</head>

<body >
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 发布管理 > 所有发布</div>
        <div class="xt-input">
            <%--<span>账号/邮箱</span><input type="text" class="int-text" />--%>
            <span>查找类型</span>
            <select id="select"  class="int-text"name="select">
                <option value="0" id="0" >查找所有</option>
                <option value="1" id="1">页面公告</option>
                <option value="2" id="2">热门百科</option>
                <option value="3" id="3" >相关链接</option>
                <option value="4" id="4" >首页帮助</option>
                <option value="5" id="5" >关于我们</option>
            </select>
            <span>关键字</span><input type="text" id="content" required="required" class="int-text" />
            <input type="button" id="button1" onclick="searchnews()" value="确 定" class="green-int" />
        </div>
        <%
            String pages=request.getParameter("page");
            int p = Integer.parseInt(pages);
            List list=(List)request.getSession().getAttribute("result");
            if(list==null){
        %>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>编号</th>
                    <th>类型</th>
                    <th>标题</th>
                    <th>发布时间</th>
                    <th>发布人</th>
                </tr>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第1 / 1页,每页10条，共 0条记录</div>
            <div class="xt-fenye-right">
                <a href="http://localhost:8080/news.jsp?page=1">首页</a>
                <a href="http://localhost:8080/news.jsp?page=1">上一步</a>
                <a href="http://localhost:8080/news.jsp?page=1">下一步</a>
                <a href="http://localhost:8080/news.jsp?page=1">尾页</a>
                <input type="text" name="text" />
                <a href="http://localhost:8080/news.jsp?page=1" class="xt-link">跳转</a>
            </div>
        </div>
        <%}else{%>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>编号</th>
                    <th>类型</th>
                    <th>标题</th>
                    <th>发布时间</th>
                    <th>发布员工</th>
                    <th>操作</th>
                </tr>
                <%
                    Integer totalpages=(list.size()-(list.size()%10))/10+1;
                    for(int i=0;i<((list.size()-10*(p-1))<10?(list.size()-10*(p-1)):10);i++){
                        Notice notice=(Notice)list.get(i+(p-1)*10);String s;
                        if(notice.getField2()==0){
                            s = "页面公告";
                        }else if(notice.getField2()==1){
                            s = "热门百科";
                        }else if(notice.getField2()==2){
                            s = "相关链接";
                        }else if(notice.getField2()==3){
                            s = "首页帮助";
                        }else if(notice.getField2()==4){
                            s = "关于我们";
                        }else{
                            s = "热门百科";
                        }
                %>
                     <tr class="xt-bg">
                         <td><%=i+(p-1)*10+1%></td>
                         <td><%=s%></td>
                         <td><%=notice.getNoticetitle()%></td>
                         <td><%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(notice.getNoticetime())%></td>
                         <td><%=notice.getNoticemanager()%></td>
                         <td><a href="javascript:void (0);" onclick="getnbyid(<%=notice.getNoticeid()%>);" class="yellow-xt">详情</a><a href= "javascript:void (0);" onclick="deletenbyid(<%=notice.getNoticeid()%>);" class="blue-xt">删除</a></td>
                     </tr>
                <%}%>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第<%=pages%> /<%=totalpages%> 页,每页10条，共 <%=list.size()%>条记录</div>
            <div class="xt-fenye-right">
                <a href="news.jsp?page=1">首页</a>
                <a href="http://localhost:8080/news.jsp?page=<%if(p==1){%><%=1%><%}else{%><%=p-1%><%}%>">上一步</a>
                <a href= "javascript:void (0);" onclick="next();">下一步</a>
                <a href="news.jsp?page=<%=totalpages%>">尾页</a>
                <input type="text" id="nlink1" name="text" />
                <a href="javascript:void (0);" onclick="jump();"  class="xt-link">跳转</a>
            </div>
        </div>


    </div>
</div>
<script type="text/javascript">
    function next(){
        window.location.href="http://localhost:8080/news.jsp?page=<%if(p>=totalpages){%><%=totalpages%><%}else{%><%=p+1%><%}%>";
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
        window.location.href="http://localhost:8080/news.jsp?page="+jumpto;
    }
</script>
<% }%>
<script src="../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function getnbyid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/getbyid",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.location.href="http://localhost:8080/newsdetail.jsp";
            }
        )
    }
</script>
<script type="text/javascript">
    function deletenbyid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/deletenbyid",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.parent.document.getElementById("notice").click();
            }
        )
    }
</script>
<script type="text/javascript">
    function searchnews(){
        var select=document.getElementById("select").value;
        var content=document.getElementById("content").value;
        jQuery.support.cors = true;
        $.post("http://localhost:8080/search",
            //发送给后端的数据
            {"select":document.getElementById("select").value,
            "content":document.getElementById("content").value,
            },
            //回调函数
            function(data){
            window.location.reload();
            }
        )
    }
</script>
</body>
</html>
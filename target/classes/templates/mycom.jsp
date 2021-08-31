<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Manager" %>
<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
<%@ page import="com.springboot.dataObject.Complaint" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.springboot.controller.viewobject.UserVO" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../static/css/news/style.css" rel="stylesheet" type="text/css">
</head>

<body >
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 投诉处理 > 我的投诉</div>
        <%
            UserVO user=(UserVO)request.getSession().getAttribute("user");
            if(user==null){
                pageContext.forward("http://localhost:8080/uerror.jsp");
            }else{
            String pages=request.getParameter("mcpage");
            int p = Integer.parseInt(pages);
            List list=(List)request.getSession().getAttribute("usercom");
            if(list==null){
        %>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>编号</th>
                    <th>用户ID</th>
                    <th>投诉时间</th>
                    <th>投诉对象</th>
                    <th>投诉理由</th>
                    <th>操作</th>
                </tr>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第1 / 1页,每页10条，共 0条记录</div>
            <div class="xt-fenye-right">
                <a href="http://localhost:8080/manager/mycom.jsp?mcpage=1">首页</a>
                <a href="http://localhost:8080/manager/mycom.jsp?mcpage=1">上一步</a>
                <a href="http://localhost:8080/manager/mycom.jsp?mcpage=1">下一步</a>
                <a href="http://localhost:8080/manager/mycom.jsp?mcpage=1">尾页</a>
                <input type="text" name="text" />
                <a href="http://localhost:8080/manager/mycom.jsp?mcpage=1" class="xt-link">跳转</a>
            </div>
        </div>
        <%}else{%>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>编号</th>
                    <th>用户ID</th>
                    <th>投诉时间</th>
                    <th>投诉对象</th>
                    <th>投诉理由</th>
                    <th>结果</th>
                </tr>
                <%
                    Integer totalpages=(list.size()-(list.size()%10))/10+1;
                    for(int i=0;i<((list.size()-10*(p-1))<10?(list.size()-10*(p-1)):10);i++){
                        Complaint complaint=(Complaint) list.get(i+(p-1)*10);String s;
                        if(complaint.getComstate()==1){
                            s = "投诉通过";
                        }
                       else if(complaint.getComstate()==2){
                            s = "投诉未通过";
                        }       else if(complaint.getComstate()==3){
                            s = "投诉已撤销";
                        }
                        else{
                            s = "投诉未处理";
                        }
                %>
                     <tr class="xt-bg">
                         <td><%=i+(p-1)*10+1%></td>
                         <td><%=complaint.getUserid1()%></td>
                         <td><%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(complaint.getComtime())%></td>
                         <td><%=complaint.getManagerid2()%></td>
                         <td><%=complaint.getComreason()%></td>
                         <td><%if(complaint.getComstate()==1||complaint.getComstate()==2||complaint.getComstate()==3){%><%=s%><%}if(complaint.getComstate()==0){%><a href="javascript:;" onclick="cancelcom(<%=complaint.getComid()%>)" class="yellow-xt">撤销投诉</a><%}%></td>
                     </tr>
                <%}%>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第<%=pages%> /<%=totalpages%> 页,每页10条，共 <%=list.size()%>条记录</div>
            <div class="xt-fenye-right">
                <a href="mycom.jsp?mcpage=1">首页</a>
                <a href="http://localhost:8080/mycom.jsp?mcpage=<%if(p==1){%><%=1%><%}else{%><%=p-1%><%}%>">上一步</a>
                <a href= "javascript:void (0);" onclick="next();">下一步</a>
                <a href="mycom.jsp?mcpage=<%=totalpages%>">尾页</a>
                <input type="text" id="nlink" name="nlink" />
                <a href= "javascript:void (0);" onclick="jump();" class="xt-link">跳转</a>
            </div>
        </div>

    </div>
</div>
<script type="text/javascript">
    function next(){
        window.location.href="http://localhost:8080/mycom.jsp?mcpage=<%if(p>=totalpages){%><%=totalpages%><%}else{%><%=p+1%><%}%>";
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
        window.location.href="http://localhost:8080/mycom.jsp?mcpage="+jumpto;
    }
</script>


<% }}%>
<script src="../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function cancelcom(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/cancelcom",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.parent.document.getElementById("com").click();
            }
        )
    }
</script>

</body>
</html>
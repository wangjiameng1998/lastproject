<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Notice" %>
<%@ page import="com.springboot.dataObject.House" %>
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
        <div class="xt-bt">功能导航> 房源管理  > 我的房源</div>
        <%
            String pages=request.getParameter("page");
            int p = Integer.parseInt(pages);
            List list=(List)request.getSession().getAttribute("myaddhouse");
            if(list==null){
        %>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>编号</th>
                    <th>房屋ID</th>
                    <th>房屋面积</th>
                    <th>房屋单价</th>
                    <th>房屋地址</th>
                    <th>房屋年龄</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第1 / 1页,每页10条，共 0条记录</div>
            <div class="xt-fenye-right">
                <a href="http://localhost:8080/myaddhouse.jsp?page=1">首页</a>
                <a href="http://localhost:8080/myaddhouse.jsp?page=1">上一步</a>
                <a href="http://localhost:8080/myaddhouse.jsp?page=1">下一步</a>
                <a href="http://localhost:8080/myaddhouse.jsp?page=1">尾页</a>
                <input type="text" name="text" />
                <a href="http://localhost:8080/myaddhouse.jsp?page=1" class="xt-link">跳转</a>
            </div>
        </div>
        <%}else{%>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>编号</th>
                    <th>房屋ID</th>
                    <th>房屋面积</th>
                    <th>房屋单价</th>
                    <th>房屋地址</th>
                    <th>房屋年龄</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                <%
                    Integer totalpages=(list.size()-(list.size()%10))/10+1;
                    for(int i=0;i<((list.size()-10*(p-1))<10?(list.size()-10*(p-1)):10);i++){
                        House  house=(House)list.get(i+(p-1)*10);String s;
                        if(house.getHousestate()==0){
                            s = "等待售出";
                        }else if(house.getHousestate()==1){
                            s = "已有订单";
                        }
                        else if(house.getHousestate()==3){
                            s = "已售出";
                        }
                        else{
                            s = "已下架";
                        }
                %>
                     <tr class="xt-bg">
                         <td><%=i+(p-1)*10+1%></td>
                         <td><%=house.getHouseid()%></td>
                         <td><%=house.getHousearea()%></td>
                         <td><%=house.getHouseprice()%></td>
                         <td><%=house.getHouseaddress()%></td>
                         <td><%=house.getHouseage()%></td>
                         <td><%=s%></td>
                         <td><a href="javascript:void (0);" onclick="gethbyid(<%=house.getHouseid()%>);" class="yellow-xt">详情</a>
                         <%if(house.getHousestate()==2){
                                 %>
                         <a href= "javascript:void (0);" onclick="nodeletehbyid(<%=house.getHouseid()%>);" class="blue-xt">撤销下架</a><%
                             }else if(house.getHousestate()==0){
                                 %><a href= "javascript:void (0);" onclick="deletehbyid(<%=house.getHouseid()%>);" class="blue-xt">下架</a>
                             <a href="javascript:void (0);" onclick="updatehbyid(<%=house.getHouseid()%>);" class="green-xt">修改</a><%
                             }else{
                                 %><%
                             }%>
                             </td>
                     </tr>
                <%}%>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第<%=pages%> /<%=totalpages%> 页,每页10条，共 <%=list.size()%>条记录</div>
            <div class="xt-fenye-right">
                <a href="myaddhouse.jsp?page=1">首页</a>
                <a href="http://localhost:8080/manager/myaddhouse.jsp?page=<%if(p==1){%><%=1%><%}else{%><%=p-1%><%}%>">上一步</a>
                <a href= "javascript:void (0);" onclick="next();">下一步</a>
                <a href="myaddhouse.jsp?page=<%=totalpages%>">尾页</a>
                <input type="text" id="nlink1" name="text" />
                <a href="javascript:void (0);" onclick="jumpto();"  class="xt-link">跳转</a>
            </div>
        </div>


    </div>
</div>
<script type="text/javascript">
    function next(){
        window.location.href="http://localhost:8080/manager/myaddhouse.jsp?page=<%if(p>=totalpages){%><%=totalpages%><%}else{%><%=p+1%><%}%>";
    }
</script>
<script type="text/javascript">
    function jumpto(){
        var jumpto=document.getElementById("nlink1").value;
        if (jumpto >=<%=totalpages%>){
            jumpto=<%=totalpages%>;
        } else if (jumpto<=1){
            jumpto=1;
        }
        window.location.href="http://localhost:8080/manager/myaddhouse.jsp?page="+jumpto;
    }
</script>
<% }%>
<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function gethbyid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/gethbyid",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.location.href="http://localhost:8080/manager/housedetail.jsp";
            }
        )
    }
</script>
<script type="text/javascript">
    function updatehbyid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/gethbyid",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.location.href="http://localhost:8080/manager/updatehbyid.jsp";
            }
        )
    }
</script>
<script type="text/javascript">
    function deletehbyid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/deletehbyid",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.parent.document.getElementById("myaddhouse").click();
            }
        )
    }
</script>
<script type="text/javascript">
    function nodeletehbyid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/nodeletehbyid",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.parent.document.getElementById("myaddhouse").click();
            }
        )
    }
</script>
</body>
</html>
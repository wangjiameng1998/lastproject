<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Notice" %>
<%@ page import="com.springboot.dataObject.Order" %>
<%@ page import="com.springboot.dataObject.Manager" %>
<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
        <div class="xt-bt">功能导航> 交易管理 > 所有交易</div>
        <%
            ManagerVO managerVO=(ManagerVO)request.getSession().getAttribute("manager");
            if(managerVO==null){
                pageContext.forward("http://localhost:8080/error.jsp");
            }else{
                String pages=request.getParameter("orderpage");
                int p = Integer.parseInt(pages);
                String st=request.getParameter("state");
                int state = Integer.parseInt(st);
                List list=(List)request.getSession().getAttribute("myorder");
                if(list==null){
        %>
        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>订单号</th>
                    <th>订单时间</th>
                    <th>订单状态</th>
                    <th>用户ID</th>
                    <th>房源ID</th>
                    <th>操作</th>
                </tr>
            </table>
        </div>
        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第1 / 1页,每页10条，共 0条记录</div>
            <div class="xt-fenye-right">
                <a href="myorder.jsp?orderpage=1&&state="<%=state%>>首页</a>
                <a href="http://localhost:8080/manager/myorder.jsp?orderpage=1&&state="<%=state%>>上一步</a>
                <a href="http://localhost:8080/manager/myorder.jsp?orderpage=1&&state="<%=state%>>下一步</a>
                <a href="http://localhost:8080/manager/myorder.jsp?orderpage=1&&state="<%=state%>>尾页</a>
                <input type="text" name="text" />
                <a href="http://localhost:8080/manager/myorder.jsp?orderpage=1&&state="<%=state%> class="xt-link">跳转</a>
            </div>
        </div>
        <%}else{%>

        <div class="xt-table">
            <table cellpadding="0" cellspacing="0" border="0" bgcolor="#dcdcdc" width="100%">
                <tr>
                    <th>订单号</th>
                    <th>订单时间</th>
                    <th>订单状态</th>
                    <th>用户ID</th>
                    <th>房源ID</th>
                    <th>操作</th>
                </tr>
                <%
                    Integer totalpages=(list.size()-(list.size()%10))/10+1;
                    for(int i=0;i<((list.size()-10*(p-1))<10?(list.size()-10*(p-1)):10);i++){
                        Order order=(Order) list.get(i+(p-1)*10);String s;
                        Manager manager=new Manager();
                        if(order.getOrderstate()==0){
                            s = "订单已取消。";
                        }else if(order.getOrderstate()==1){
                            s = "用户已下单。";
                        }else if(order.getOrderstate()==2){
                            s = "用户已确认房源。";
                        }else if(order.getOrderstate()==3){
                            s = "您已确认无误,同意售卖。";
                        }else if(order.getOrderstate()==4){
                            s = "用户已付款，订单完成。";
                        }else{
                            s = "订单出现未知错误。";
                        }
                %>
                     <tr class="xt-bg">
                         <td><%=order.getOrderid()%></td>
                         <td><%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(order.getOrdertime())%></td>
                         <td><%=s%></td>
                         <td><a href="javascript:void (0);" onclick="getuser(<%=order.getHousebuyer()%>);" class="green-xt"><%=order.getHousebuyer()%></a></td>
                         <td><a href="javascript:void (0);" onclick="gethousebyhid(<%=order.getHouseid()%>);" class="blue-xt"><%=order.getHouseid()%></a></td>
                         <td>
                             <%if(order.getOrderstate()==2){%><a href="javascript:void (0);"  onclick="quebyid(<%=order.getOrderid()%>,<%=state%>);" class="yellow-xt">最后售卖确认</a>
                             <%}%>
                             <a href="javascript:void (0);"  onclick="respondbyid(<%=order.getHousebuyer()%>);" class="yellow-xt">联系买家</a>
                         </td>
                     </tr>
                <%}%>
            </table>
        </div>

        <div class="xt-fenye">
            <div class="xt-fenye-left">当前第<%=pages%> /<%=totalpages%> 页,每页10条，共 <%=list.size()%>条记录</div>
            <div class="xt-fenye-right">
                <a href="myorder.jsp?orderpage=1&&state="<%=state%>>首页</a>
                <a href="http://localhost:8080/manager/myorder.jsp?orderpage=<%if(p==1){%><%=1%><%}else{%><%=p-1%><%}%>">上一步</a>
                <a href= "javascript:void (0);" onclick="next();">下一步</a>
                <a href="myorder.jsp?orderpage=<%=totalpages%>">尾页</a>
                <input type="text" id="nlink" name="nlink" />
                <a href= "javascript:void (0);" onclick="jump();" class="xt-link">跳转</a>
            </div>
        </div>


    </div>
</div>

<script type="text/javascript">
    function next(){
        window.location.href="http://localhost:8080/manager/myorder.jsp?orderpage=<%if(p>=totalpages){%><%=totalpages%><%}else{%><%=p+1%><%}%>";
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
        window.location.href="http://localhost:8080/manager/myorder.jsp?orderpage="+jumpto;
    }
</script>
<% }}%>
<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function quebyid(id,state){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/quebyid",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
            if (state===2){
                window.parent.document.getElementById("state2").click();
            }
                if (state===1){
                    window.parent.document.getElementById("state1").click();
                }
                if (state===0){
                    window.parent.document.getElementById("state0").click();
                }
            }
        )
    }
</script>
<script type="text/javascript">
    function gethousebyhid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/gethousebyhid",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.location.href="http://localhost:8080/manager/onehouse.jsp";
            }
        )
    }
</script>
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
    function respondbyid(id){
        jQuery.support.cors = true;
        $.post("http://localhost:8080/help",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.location.href="http://localhost:8080/manager/help.jsp?uid="+id;
            }
        )
    }
</script>
</body>
</html>
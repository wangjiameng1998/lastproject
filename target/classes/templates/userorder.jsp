<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Notice" %>
<%@ page import="com.springboot.dataObject.Order" %>
<%@ page import="com.springboot.dataObject.Manager" %>
<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.springboot.dataObject.House" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../static/css/news/style.css" rel="stylesheet" type="text/css">
    <link href="../static/css/houtai/haiersoft.css" rel="stylesheet" type="text/css" media="screen,print" />
    <link href="../static/css/houtai/print.css" rel="stylesheet" type="text/css"  media="print" />
    <script src="../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../static/js/login.js"></script>
    <link rel="stylesheet" type="text/css"  href="../static/css/tanchucss/style.css"/>
</head>
<%List order=(List)request.getSession().getAttribute("userorder");
    List house=(List)request.getSession().getAttribute("userorderhouse");
if(order==null||order.size()==0){
%>您暂时无订单<%
}else{
%>
<body >
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 订单管理  > 我的订单</div>
        <%
            for(int i=0;i<order.size();i++){
                Order order1=(Order)order.get(i);String s;
                House house1=(House)house.get(i);
                if(order1.getOrderstate()==0){
                    s = "订单已取消。";
                }else if(order1.getOrderstate()==1){
                    s = "您已下单。";
                }else if(order1.getOrderstate()==2){
                    s = "您已确认房源。";
                }else if(order1.getOrderstate()==3){
                    s = "中介已确认。";
                }else if(order1.getOrderstate()==4){
                    s = "您已付款。";
                }else{
                    s = "订单出现未知错误。";
                }
                %><div class="xt-input"><%
%>

        <!-- MainForm -->
        <div id="MainForm">
            <div class="form_boxB">
                <table cellpadding="0" cellspacing="0" style="font-family:SimSun-ExtB;">
                    <tr>
                        <td colspan="10" class="info_boxA">订单号:<%=order1.getOrderid()%> 订单时间:<%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(order1.getOrdertime())%>
                            &nbsp;&nbsp;<div class="login-header"><a style="text-decoration: none;height:40px;color: #000000;font-size: 20px;"  href="tousu.jsp?id=<%=house1.getHouseowner()%>"><h5>投诉此中介</h5></a></div>
                            <a style="text-decoration: none;color: #000000;" href= "javascript:void (0);" onclick="contact(<%=house1.getHouseowner()%>)">联系中介</a></td>
                    </tr>
                    <tr>
                        <td rowspan="4"><img src="../static/img/client.jpg" style="width: 100px;height: 100px;vertical-align: middle;"></td>
                    </tr>
                    <tr>
                        <td><h3>&nbsp;<a style="text-decoration: none;" href="javascript:void(0);" onclick ="single(<%=house1.getHouseid()%>);">&nbsp;&nbsp;&nbsp;&nbsp;<%=house1.getHouseaddress()%></a></h3></td>
                    </tr>
                    <tr>
                        <td><h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=house1.getBedroom()%>室 | <%=house1.getKichen()%>厅 | <%=house1.getBathroom()%>卫 | <%=house1.getHousearea()%>平方米 | <%=house1.getHousefloor()%>楼</h5></td>
                    </tr>
                    <tr>
                        <td colspan="2"><h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;￥<%=new DecimalFormat("0.00").format((float)house1.getHousearea()*house1.getHouseprice()/10000)%>万&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;订单状态:<%=s%><%
                            if(order1.getOrderstate()==1){
                                %>如果您已看房并确认购买，请点击确认<a style="text-decoration: none;" onclick="que(<%=order1.getOrderid()%>)" class="green-int">确认购买</a><%
                            } if(order1.getOrderstate()==1||order1.getOrderstate()==2){
                            %><a style="text-decoration: none;" onclick="deleteorder(<%=order1.getOrderid()%>)" class="green-int">取消订单</a><%
                            }if(order1.getOrderstate()==3){
                                %><a style="text-decoration: none;" onclick="money(<%=order1.getOrderid()%>)" class="green-int">立即付款</a><%
                            }
                            %></h5></td>
                    </tr>
                </table>

            </div>
        </div></div>
        <%
            }
        %>

    </div>
</div>
<script>
    function deleteorder(id) {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/deleteorder",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.parent.location.href="http://localhost:8080/reload";
            }
        )
    }
</script>
<script>
    function money(id) {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/moneyorder",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
            alert("您已付款");
                window.parent.location.href="http://localhost:8080/reload";
            }
        )
    }
</script>
<script>
    function com(id) {alert(window.document.getElementById("pass"));
        jQuery.support.cors = true;alert(window.document.getElementById("pass").value);
        $.post("http://localhost:8080/addcom",
            //发送给后端的数据
            {"id":id,"content":window.document.getElementById("pass").value,
            },
            //回调函数
            function(data){
                window.location.href="http://localhost:8080/mycom.jsp?mcpage=1";
            }
        )
    }
</script>
<script>
    function que(id) {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/buy",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.parent.location.href="http://localhost:8080/reload";
            }
        )
    }
</script>
<script>
    function contact(id) {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/userhelp",
            //发送给后端的数据
            {"id":id,
            },
            //回调函数
            function(data){
                window.location.href="http://localhost:8080/userhelp.jsp?mid="+id;
            }
        )
    }
</script>
<script>
    function single(id) {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/housesingle",
            //发送给后端的数据
            {"hid":id},
            //回调函数
            function(data){
                window.open("http://localhost:8080/sell/property_single.jsp");
            }
        )
    }
</script>
</body>
<%}%>
</html>

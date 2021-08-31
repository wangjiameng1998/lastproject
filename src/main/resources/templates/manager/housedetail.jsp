<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
<%@ page import="com.springboot.dataObject.Manager" %>
<%@ page import="com.springboot.dataObject.User" %>
<%@ page import="com.springboot.dataObject.House" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Picture" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../../static/css/news/style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../../static/js/jquery-2.1.1.min.js"></script>
    <style type="text/css">
        .bbD{font-size: 20px;}
    </style>
</head>
<body>
<%
        House  house=(House)request.getSession().getAttribute("onehouse");
    List list=(List)request.getSession().getAttribute("housepicture");
        String s,l,f;
        if(house.getHousestate()==0){
             s = "正在出售";
        }
        else if(house.getHousestate()==1){
            s = "已有订单";
        }else{
            s = "已下架";
        }
        if(house.getHouselift()==0){
            l ="电梯未标明";
        }else if(house.getHouselift()==1){
            l = "有电梯";
        }else{
            l = "无电梯";
        }
        if(house.getHouseface()!=null){
            f = house.getHouseface();
        }else{
            f="未标明";
        }
        %>
<div class="xt-center">
    <div id="">
        <div class="xt-bt">功能导航> 房源管理 > 我的房源</div>
    </div>
</div>
<div class="xt-left">
    <br><br><br>
        <div class="bbD"><span>房屋ID：<%=house.getHouseid()%></span></div><br>
        <div class="bbD"><span>上传人：<%=house.getHouseowner()%></span></div><br>
        <div class="bbD"><span>房屋面积：<%=house.getHousearea()%></span>&nbsp;&nbsp;
            <span>房屋价格：<%=house.getHouseprice()%></span></div><br>
        <div class="bbD"><span>地理位置：<%=house.getHouseaddress()%></span></div><br>
        <div class="bbD"><span>楼层：<%=house.getHousefloor()%></span>
        <span><%=l%></span>&nbsp;&nbsp;<span>朝向：<%=f%></span></div><br>
        <div class="bbD"><span>客厅：<%=house.getKichen()%>间</span>&nbsp;&nbsp; <span>卧室：<%=house.getBedroom()%>间</span>&nbsp;&nbsp; <span>卫生间：<%=house.getBathroom()%>间</span></div><br>
    <div class="bbD"><span>房龄：<%=house.getHouseage()%></span></div><br>
    <div class="bbD"><span>关注人数：<%=house.getHouselike()%></span></div><br>
        <div class="bbD"><span>状态：<%=s%></span></div><br>
    <div class="bbD">  <%
        if(list!=null&&list.size()!=0){
    %><%
        for(int i=0;i<list.size();i++){
            Picture picture=(Picture)list.get(i);
            String s1="../../static/img/upload/"+picture.getPath();
    %><img src="<%=s1%>" style="width: 100px;height: 100px;"/>
        <%
            }%><%}else{%><span>无图片</span><%}
        %></div><br>
        <div class="bbD">

            <p class="bbDP">
                <input type="button" id="button3" onclick="mqueding()" value="确 定" class="green-int" />
                <input type="button" id="button4"onclick="updatehbyid(<%=house.getHouseid()%>);" value="修改" class="yellow-int" />
            </p>
        </div>

</div>

<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function mcancel(){
        document.location.href = "http://localhost:8080/manager/home.jsp";
    }
</script>
<script type="text/javascript">
    function mqueding(){
        window.history.go(-1);
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
</body>
</html>
<body>
</body>
</html>

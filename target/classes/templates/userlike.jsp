<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.springboot.dataObject.*" %>
<%@ page import="com.springboot.controller.viewobject.UserVO" %>
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
    <script src="../static/js/sell/sell.js"></script>
    <link rel="stylesheet" href="../static/css/simpleAlert.css">
    <script src="../static/js/buttonjs/simpleAlert.js"></script>

    <script>
        function c(uid,hid) {
            var manyAllChoseAlert = simpleAlert({
                "content":"确定提交订单!",
                "buttons":{
                    "确定":function () {
                        var manyAllChoseAlert2 = simpleAlert({
                            "content":"订单提交后不可修改，请再次确认!",
                            "buttons":{
                                "确定":function () {
                                    jQuery.support.cors = true;
                                    $.post("http://localhost:8080/addorder",
                                        //发送给后端的数据
                                        {"uid":uid,"hid":hid},
                                        //回调函数
                                        function(data){
                                            if (data.result.trim()!="1"){alert(data.result);
                                                manyAllChoseAlert2.close();
                                            }
                                        }
                                    )
                                    var manyAllChoseAlert3 = simpleAlert({
                                        "content":"订单已提交!",
                                        "closeAll":true,
                                        "buttons":{
                                            "确定":function () {
                                                manyAllChoseAlert3.close();
                                                window.parent.location.href="http://localhost:8080/reload";
                                            }
                                        }
                                    })
                                },
                                "取消":function () {
                                    manyAllChoseAlert2.close();
                                }
                            }
                        })
                    },
                    "取消":function () {
                        manyAllChoseAlert.close();
                    }
                }
            })}
    </script>
</head>
<%   UserVO userVO=(UserVO) request.getSession().getAttribute("user");
    if(userVO!=null){%><%
        List like=(List)request.getSession().getAttribute("userlike");
        List house=(List)request.getSession().getAttribute("userlikehouse");
        if(like==null||like.size()==0){%><center><h3><br><br>无关注的房源</h3></center><%
        }else{
%>
<body >
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 收藏管理  > 我的关注</div>
        <%
            for(int i=0;i<like.size();i++){
                Houselike houselike=(Houselike)like.get(i);
                House house1=(House)house.get(i);String s;
                if(house1.getHousestate()==0){
                    s = "未有人下单";
                }else{
                    s = "已售出或下架";
                }
                %><div class="xt-input"><%
%>

        <!-- MainForm -->
        <div id="MainForm">
            <div class="form_boxB">
                <table cellpadding="0" cellspacing="0" style="font-family:SimSun-ExtB;">
                    <tr>
                        <td colspan="10" class="info_boxA">房屋号:<%=houselike.getHouseid()%> 关注时间:<%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(houselike.getField())%>
                            &nbsp;<h5>关注人数：<%=house1.getHouselike()%></h5><a style="color: #000000;" href= "javascript:void (0);" onclick="contact(<%=house1.getHouseowner()%>)">联系中介</a></td>
                    </tr>
                    <tr>
                        <td rowspan="4"><img src="../static/img/client.jpg" style="width: 100px;height: 100px;vertical-align: middle;"></td>
                    </tr>
                    <tr>
                        <td><h3>&nbsp;<a style="text-decoration: none;" href="javascript:void(0);" onclick ="single(<%=house1.getHouseid()%>);">&nbsp;&nbsp;&nbsp;&nbsp;<%=house1.getHouseaddress()%></a></h3></td>
                    </tr>
                    <tr>
                        <td><h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=house1.getBedroom()%>室 | <%=house1.getBathroom()%>卫 | <%=house1.getHousearea()%>平方米 | <%=house1.getHousefloor()%>楼</h5></td>
                    </tr>
                    <tr>
                        <td colspan="2"><h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;￥<%=new DecimalFormat("0.00").format((float)house1.getHousearea()*house1.getHouseprice()/10000)%>万&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                         <%if(house1.getHousestate()==0){
                             %><a  id="manyAllChoseAlert" href="javascript:void(0);" onclick="c(<%=userVO.getUserid()%>,<%=house1.getHouseid()%>)" >立即下单</a>
                            <%
                         }else{
                             %><%=s%><%
                         }%>
                          <a onclick="deletelike(<%=houselike.getHouselikeid()%>)" >取消关注</a>
                         </h5></td>
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
    function deletelike(id) {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/deletelike",
            //发送给后端的数据
            {"id":id
            },
            //回调函数
            function(data){
                window.parent.document.getElementById("like").click();
            }
        )
    }
</script>
<script>
    function com(id) {
        jQuery.support.cors = true;
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
<%}}%>
</body>
</html>

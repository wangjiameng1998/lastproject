<%@ page import="java.util.List" %>
<%@ page import="com.springboot.controller.viewobject.UserVO" %>
<%@ page import="com.springboot.dataObject.House" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- Required meta tags always come first -->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Homify</title>
    <!--Bootstrap-->
    <link rel="stylesheet" type="text/css" href="../../static/css/bootstrap.min.css" media="all" />
    <!--Bootstrap-select CSS-->
    <link rel="stylesheet" type="text/css" href="../../static/vendors/bootstrap-select/bootstrap-select.min.css" media="all" />
    <!--Flexslider CSS-->
    <link rel="stylesheet" type="text/css" href="../../static/vendors/flexslider/css/flexslider.css" media="all" />
    <!--Owl_Carousel CSS-->
    <link rel="stylesheet" type="text/css" href="../../static/vendors/owl-carousel/owl.carousel.css" media="all" />
    <!--Linearicons Icons CSS-->
    <link rel="stylesheet" href="../../static/vendors/linearicons/Linearicons.css">
    <!--Font-Awesome CSS-->
    <link rel="stylesheet" href="../../static/vendors/font-awesome/css/font-awesome.min.css">
    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300,300italic,400italic,500,500italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>
    <!-- jquery-ui css -->
    <link rel="stylesheet" type="text/css" href="../../static/css/jquery-ui.min.css" media="all" />
    <!--Theme Styles CSS-->
    <link href="../../static/css/news/style.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../../static/css/style.css" media="all" />
    <script src="../../static/js/html5shiv.min.js"></script>
    <script src="../../static/js/respond.min.js"></script>
    <script src="../../static/js/jquery-1.12.0.min.js"></script>
    <script type="text/javascript" src="../../static/js/jquery.min.js"></script>
    <link rel="stylesheet" href="../../static/css/simpleAlert.css">
    <script src="../../static/js/buttonjs/simpleAlert.js"></script>

</head>
<body>
<%
    UserVO userVO=(UserVO) request.getSession().getAttribute("user");
    List list=(List)request.getSession().getAttribute("indexsearch");
    List list1=(List) request.getSession().getAttribute("allhouse");
    List put;
    if(list!=null&&list.size()>0){
            put=list;

    }else{
            put=list1;
    }
%>
<header class="header_top_section row">
    <div class="container coustome-container">
        <div class="row top_header">
            <a href="#"><i class="lnr lnr-phone-handset"></i> +15730069857</a>
            <a href="#"><i class="lnr lnr-envelope"></i> +15730069857</a>
            <ul>
                <li><a href="#">用户须知</a></li>
                <li><a href="#">网站支持</a></li>
                <%if(userVO==null){%><li><a href="../login.jsp">请登录</a></li>
                <%}else{%><li><a href="http://localhost:8080/exit">退出</a></li><%}%>
            </ul>
        </div>
    </div>
</header>
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
                                        if (data.result.trim()!="1"){
                                            alert(data.result);
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
                                            window.location.href="http://localhost:8080/personal.jsp";
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
    /*     })
     })*/
</script>

<!-- Heder_Bottom -->
<nav class="navbar navbar-default nav_custom row">
    <div class="container coustome-container">
        <!-- Brand and mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main_menu" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand_logo" href="../index.jsp"><img src="../../static/img/logo.png" alt="Logo"></a>
        </div>

        <!-- Collect the nav home, property  -->
        <div class="row collapse navbar-collapse" id="main_menu">
            <ul class="nav navbar-right nav_buttom">
                <li><a href="#">查询房源 <i class="lnr lnr-arrow-right"></i></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-menu">
                <li><a href="http://localhost:8080/index">首页</a></li>
                <%
                    if( userVO!=null){
                %>
                <li><a href="../personal.jsp">个人中心 </a></li>
                <%
                }
                else{
                %>
                <li><a href = "javascript:void(0);" onclick ="nologin()">个人中心 </a></li>
                <%
                    }
                %>

                <li><a href="property_sell.jsp?page=1">二手房</a></li>
                <%
                    if( userVO==null){
                %>
                <li><a href="../login.jsp">登录/注册</a></li>        <%
                }
            %>
            </ul>
        </div><!-- End navbar-collapse -->
    </div>
</nav>
<!-- End Heder_Bottom -->
<script>
    function nologin(){
        alert("请先注册或登录！");
    }
</script>
<!-- Banner area -->
<section class="banner-area row">
    <% if(list==null||list.size()==0){
    %><h2>无搜索结果，为您推荐以下热门二手房</h2><%
    }else{
        %><h2>商品列表</h2><%
    }
    %>
    <div class="bottom-menu-area">
        <a href="http://localhost:8080/index">首页</a>
        <i class="lnr lnr-chevron-right"></i>
        <a href="property_sell.jsp?page=1">商品</a>
        <i class="lnr lnr-chevron-right"></i>
        <a href="property_sell.jsp?page=1">商品列表</a>
    </div>
</section>
<!-- End Banner area -->
<%
    String pages=request.getParameter("page");
    int p = Integer.parseInt(pages);
    int totalpages=(put.size()-(put.size()%6))/6+1;
%>
<!--Latest-Properties -->
<section class="latest-properties">
    <div class="container coustome-container">
        <div class="row m0 latest_head">
            <h2>搜索结果</h2>
            <div class="properties-slider">
                <%
                        for(int i=0;i<((put.size()-6*(p-1))<3?(put.size()-6*(p-1)):3);i++){
                            House house=(House)put.get(i+(p-1)*6);String lift;
                            if(house.getHouselift()==0){
                                lift="未标明";
                            }else if(house.getHouselift()==1){
                                lift="有";
                            }else{
                                lift="无";
                            }
                %>
                <div class="item">
                    <div class="ready_flat">
                        <a href="javascript:void(0);" onclick ="single(<%=house.getHouseid()%>);"><img src="../../static/img/home.jpg" alt="">
                        </a><div class="content-area">
                        <h4><%=house.getHouseaddress()%></h4>
                        <a href="" class="btn-slide activ">出售</a>
                        <a href="" class="btn-slide activ"><%=house.getHouseprice()%> RMB/m²</a>
                        <%if(userVO==null){
                        %><a href="javascript:void(0);" onclick ="nologin();" class="btn-slide activ">加入关注列表</a><%
                    }else{
                    %><a href="javascript:void(0);" onclick ="addlike(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="btn-slide activ">加入关注列表</a><%
                        }%>
                        <ul class="info">
                            <li><i class="lnr lnr-tag"></i> 客厅: <%=house.getKichen()%></li>
                            <li><i class="lnr lnr-tag"></i> 卧室: <%=house.getBedroom()%></li>
                            <li><i class="lnr lnr-tag"></i> 卫生间: <%=house.getBathroom()%></li>
                            <li><i class="lnr lnr-tag"></i> 楼层: <%=house.getHousefloor()%></li>
                            <li><i class="lnr lnr-tag"></i> 电梯: <%=lift%></li>
                            <li><i class="lnr lnr-tag"></i> 面积: <%=house.getHousearea()%>m²</li>
                        </ul>
                        <%if(userVO==null){
                        %>
                        <a href="javascript:void(0);" onclick="nologin()" class="contact">立即下单<i class="lnr lnr-arrow-right"></i></a>
                        <%
                        }else{
                        %><a  id="manyAllChoseAlert" href="javascript:void(0);" onclick="c(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="contact">立即下单<i class="lnr lnr-arrow-right"></i></a>
                        <%  }%>
                        <h1>￥<%=new DecimalFormat("0.00").format((float)house.getHousearea()*house.getHouseprice()/10000)%>万</h1>
                    </div>
                    </div>
                </div>
                <%
                    }
            %>
            </div>
        </div>
    </div>
</section>
<!--End Latest-Properties -->

<!--Latest-Properties -->
<section class="latest-properties">
    <div class="container coustome-container">
        <div class="row m0 latest_head">
            <div class="properties-slider">
                <%
                    if((put.size()-6*(p-1))>3){
                        for(int i=0;i<((put.size()-6*(p-1))<3?(put.size()-6*(p-1)):3);i++){
                            House house=(House)put.get(i+3+(p-1)*6);String lift;
                            if(house.getHouselift()==0){
                                lift="未标明";
                            }else if(house.getHouselift()==1){
                                lift="有";
                            }else{
                                lift="无";
                            }
                %>
                <div class="item">
                    <div class="ready_flat">
                        <a href="javascript:void(0);" onclick ="single(<%=house.getHouseid()%>);"><img src="../../static/img/home.jpg" alt="">
                        </a><div class="content-area">
                        <h4><%=house.getHouseaddress()%></h4>
                        <a href="" class="btn-slide activ">出售</a>
                        <a href="" class="btn-slide activ"><%=house.getHouseprice()%> RMB/m²</a>
                        <%if(userVO==null){
                        %><a href="javascript:void(0);" onclick ="nologin();" class="btn-slide activ">加入关注列表</a><%
                    }else{
                    %><a href="javascript:void(0);" onclick ="addlike(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="btn-slide activ">加入关注列表</a><%
                        }%>
                        <ul class="info">
                            <li><i class="lnr lnr-tag"></i> 客厅: <%=house.getKichen()%></li>
                            <li><i class="lnr lnr-tag"></i> 卧室: <%=house.getBedroom()%></li>
                            <li><i class="lnr lnr-tag"></i> 卫生间: <%=house.getBathroom()%></li>
                            <li><i class="lnr lnr-tag"></i> 楼层: <%=house.getHousefloor()%></li>
                            <li><i class="lnr lnr-tag"></i> 电梯: <%=lift%></li>
                            <li><i class="lnr lnr-tag"></i> 面积: <%=house.getHousearea()%>m²</li>
                        </ul>
                        <%if(userVO==null){
                        %>
                        <a href="javascript:void(0);" onclick="nologin()" class="contact">立即下单<i class="lnr lnr-arrow-right"></i></a>
                        <%
                        }else{
                        %><a  id="manyAllChoseAlert" href="javascript:void(0);" onclick="c(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="contact">立即下单<i class="lnr lnr-arrow-right"></i></a>
                        <%  }%>
                        <h1>￥<%=new DecimalFormat("0.00").format((float)house.getHousearea()*house.getHouseprice()/10000)%>万</h1>
                    </div>
                    </div>
                </div>
                <%
                    }
                    }
                %>
            </div>
        </div>
    </div>
</section>
<!--End Latest-Properties -->

<!--Latest-Properties -->
<center>
<section class="heading-item-area">
    <div class="container coustome-container">
        <div class="col-md-9 col-sm-6 post-area">
                <%
                    if(p ==totalpages){
                %><div class="Load-more">无更多商品<i class="lnr lnr-sync"></i></div><%
            }else{
            %> <div class="Load-more"><a href="my-search-property.jsp?page=<%=p+1%>">加载更多商品<i class="lnr lnr-sync"></i></a></div><%
                }
            %>
        </div>
    </div>
</section></center>
<!--End Latest-Properties -->

<!-- Footer Area -->
<footer class="footer_area row">
    <div class="container coustome-container">
        <div class="row m0">
            <div class="col-md-3 col-sm-6">
                <div class="about">
                    <h4>关于主页</h4>
                    <a href=""><img src="../../static/img/logo.png" alt=""></a>
                    <p>要输一堆介绍的话 </p>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="Subscribe">
                    <h4>订阅我们的实时通讯</h4>
                    <form class="footer-form">
                        <div class="form-imput">
                            <input type="email" class="form-email" placeholder="输入邮箱">
                        </div>
                        <button type="submit" class="submit-btn">立即注册 <i class="lnr lnr-arrow-right"></i></button>
                    </form>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="popular_tags">
                    <h4>热门标签</h4>
                    <div class="tags">
                        <a href="#">Business</a>
                        <a href="#">OSX</a>
                        <a href="#">Windows 10</a>
                        <a href="#">OSX Yosemite</a>
                        <a href="#">Photoshop</a>
                        <a href="#">CSS</a>
                        <a href="#">Business</a>
                        <a href="#">OSX</a>
                        <a href="#">Windows 10</a>
                        <a href="#">OSX Yosemite</a>
                        <a href="#">Photoshop</a>
                        <a href="#">CSS</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="twitter_feed">
                    <h4>更多关注</h4>
                    <ul class="Feed">
                        <li>
                            <span><a href="#">微信公众号</a>微信111</span>
                        </li>
                        <li>
                            <span><a href="#">微博</a>微博222</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="copy_right">
        © 开发人<a href="#">王佳萌</a> 毕业设计
    </div>
</footer>
<!-- End Footer Area -->

<!--jQuery JS-->
<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script>
    function addlike(uid,hid) {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/addlike",
            //发送给后端的数据
            {"uid":uid,"hid":hid},
            //回调函数
            function(data){
                if (data.result.trim()!="1"){
                    alert(data.result);
                } else{
                    alert("已加入关注列表");
                }
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
                window.location.href="http://localhost:8080/sell/property_single.jsp";
            }
        )
    }
</script>
<script src="../../static/js/jquery-1.12.0.min.js"></script>
<!--Bootstrap JS-->
<script src="../../static/js/bootstrap.min.js"></script>
<!--Bootstrap-select JS-->
<script src="../../static/vendors/bootstrap-select/bootstrap-select.min.js"></script>
<!--Flexslider JS-->
<script src="../../static/vendors/flexslider/js/jquery.flexslider.js"></script>
<!--Owl Carousel JS-->
<script src="../../static/vendors/owl-carousel/owl.carousel.min.js"></script>
<!-- Counterup JS -->
<script src="../../static/js/waypoints.min.js"></script>
<script src="../../static/vendors/counter/jquery.counterup.min.js"></script>
<!--jQuery ui JS-->
<script src="../../static/js/jquery-ui.min.js"></script>

<!--Theme-->
<script src="../../static/js/theme.js"></script>
</body>
</html>



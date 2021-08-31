<%@ page import="com.springboot.controller.viewobject.UserVO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.House" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head >
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>毕设二手房交易网站</title>
    <script src="../static/js/jquery-1.12.0.min.js"></script>
    <script type="text/javascript" src="../static/js/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../static/css/bootstrap.min.css" media="all" />
    <!--Bootstrap-select CSS-->
    <link rel="stylesheet" type="text/css" href="../static/vendors/bootstrap-select/bootstrap-select.min.css" media="all" />
    <!--Flexslider CSS-->
    <link rel="stylesheet" type="text/css" href="../static/vendors/flexslider/css/flexslider.css" media="all" />
    <!--Owl_Carousel CSS-->
    <link rel="stylesheet" type="text/css" href="../static/vendors/owl-carousel/owl.carousel.css" media="all" />
    <!--Linearicons Icons CSS-->
    <link rel="stylesheet" href="../static/vendors/linearicons/Linearicons.css">
    <!--Font-Awesome CSS-->
    <link rel="stylesheet" href="../static/vendors/font-awesome/css/font-awesome.min.css">
    <link href="../static/css/news/style.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../static/css/style.css" media="all" />
    <script src="../static/js/sell/sell.js"></script>
    <link rel="stylesheet" href="../static/css/simpleAlert.css">
    <script src="../static/js/buttonjs/simpleAlert.js"></script>
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
                                                    window.location.href="http://localhost:8080/reload";
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
    <%
        UserVO userVO=new UserVO();
        userVO=(UserVO) request.getSession().getAttribute("user");
    %>
</head>
<body>
<!-- Heder_Top -->
<header class="header_top_section row">
    <div class="container coustome-container">
        <div class="row top_header">
            <a href="#"><i class="lnr lnr-phone-handset"></i> 客服电话</a>
            <a href="#"><i class="lnr lnr-envelope"></i> 客服邮箱</a>
            <ul>
                <li><a href="#">用户须知</a></li>
                <li><a href="#">帮助</a></li>
                <%if(userVO==null){%><li><a href="login.jsp">请登录</a></li>
                <%}else{%><li><a href="http://localhost:8080/exit">退出</a></li><%}%>
            </ul>
        </div>
    </div>
</header>
<!-- End Heder_Top  -->
<script type="text/javascript">
    function nologin() {

                alert("请先注册或登录！");
    }
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
            <a class="navbar-brand_logo" href="#"><img src="../static/img/logo.png" alt="Logo"></a>
        </div>
        <!-- Collect the nav home, property  -->
        <div class="row collapse navbar-collapse" id="main_menu">
            <ul class="nav navbar-right nav_buttom">
                <li><a href="sell/property_sell.jsp?page=1">查询房源 <i class="lnr lnr-arrow-right"></i></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-menu">
                 <li><a href="http://localhost:8080/index">首页</a></li>
                <%
                    if( userVO!=null){
                        %>
                <li><a onclick="toperson()">个人中心 </a></li>
                <script>function toperson() {
                    window.open("http://localhost:8080/personal.jsp");
                }</script>
                <%
                    }
                    else{
                        %>
                <li><a href = "javascript:void(0);" onclick ="nologin()">个人中心 </a></li>
                <%
                    }
                %>
                <li><a href="sell/property_sell.jsp?page=1">二手房</a></li>
                <%
                    if( userVO==null){
                %>
                <li><a href="login.jsp">登录/注册</a></li>        <%
                }
            %>
            </ul>
        </div><!-- End navbar-collapse -->
    </div>
</nav>
<!-- End Heder_Bottom -->

<!-- Search_From_Area -->
<section class="search_from_aria row">
    <div class="container coustome-container">
        <div class="row search_img_bg">
            <h2>Find Your Perfect Home Today</h2>
            <div class="dropdwon_section row m0">
                <div class="col-md-3 col-sm-6 p0 search-area">
                    <div class="media">
                        <div class="media-left">
                            <h3 class="location">位置</h3>
                        </div>
                        <div class="media-body">
                                <input id="inputaddress" type="text" class="search-input" placeholder="地址"/>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 p0 search-area">
                    <div class="media">
                        <div class="media-left">
                            <h3 class="location">面积</h3>
                        </div>
                        <div class="media-body">
                            <input id="inputarea" type="text" class="search-input" placeholder="请输入心仪面积（m²）"/>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 p0 search-area">
                    <div class="media">
                        <div class="media-left">
                            <h3 class="location">最高价位</h3>
                        </div>
                        <div class="media-body">
                            <input id="inputprice" type="text" class="search-input" placeholder="请输入最高价位(万元)"/>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 p0 search-area">
                    <a href="javascript:void (0);" onclick="searchindex();" class="btn-search">搜索 <i class="lnr lnr-arrow-right"></i></a>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- End Search_From_Area -->

<!-- Slider_area -->
<section class="slider row">
    <div class="container coustome-container">
        <div class="row flexslider-hed">
            <h2>热门商品</h2>
            <div id="slider" class="flexslider main_slider">
                <ul class="slides slide-bottom">
                    <%
                      List list=(List) request.getSession().getAttribute("likehouse");
                      if(list==null){
                      }else{
                          for(int i=0;i<(8<list.size()?8:list.size());i++){
                              House house=(House)list.get(i);String lift;
                              if(house.getHouselift()==0){
                                  lift="未标明";
                              }else if(house.getHouselift()==1){
                                  lift="有";
                              }else{
                                  lift="无";
                              }
                              %>
                                <li>
                                    <div class="col-md-5 p0">
                                        <div class="right-area">
                                            <h3><%=house.getHouseaddress()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </h3>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="btn-slide activ">出售中</a>
                                            <a  class="btn-slide activ"><%=house.getHouseprice()%> RMB/m²</a>
                                            <%if(userVO==null){
                                            %><a href="javascript:void(0);" onclick ="nologin()" class="btn-slide activ">加入关注列表</a><%
                                        }else{
                                        %><a href="javascript:void(0);" onclick ="addlike(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="btn-slide activ">加入关注列表</a><%
                                            }%>
                                            <ul class="info">
                                                <li><i class="lnr lnr-tag"></i> 客厅: <%=house.getKichen()%></li>
                                                <li><i class="lnr lnr-tag"></i> 卧室: <%=house.getBedroom()%></li>
                                                <li><i class="lnr lnr-tag"></i> 卫生间: <%=house.getBathroom()%></li>
                                                <li><i class="lnr lnr-tag"></i> 楼层: <%=house.getHousefloor()%></li>
                                                <li><i class="lnr lnr-tag"></i> 电梯: <%=lift%></li>
                                                <li><i class="lnr lnr-tag"></i> 面积: <%=house.getHousearea()%> m²</li>
                                            </ul>
                                            <%if(userVO==null){
                                            %>
                                            <a href="javascript:void(0);" onclick="nologin()" class="info-book">立即下单<i class="lnr lnr-arrow-right"></i></a>
                                            <%
                                            }else{
                                            %><a  id="manyAllChoseAlert" href="javascript:void(0);" onclick="c(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="info-book">立即下单<i class="lnr lnr-arrow-right"></i></a>
                                            <%  }%>
                                                 <h1>￥<%=new DecimalFormat("0.00").format((float)house.getHousearea()*house.getHouseprice()/10000)%>万</h1>
                                        </div>
                                    </div>
                                    <div class="col-md-7 team p0">
                                        <a href="javascript:void(0);" onclick ="single(<%=house.getHouseid()%>);"><img src="../static/img/slider_top_img.png" alt="" /></a>
                                    </div>
                                </li>
                              <%
                          }
                      }
                    %>
                </ul>
            </div>
        </div>
    </div>
    <div id="carousel" class="flexslider thumnil">
        <ul class="slides">
            <li>
                <img src="../static/img/slider_slides_1.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_2.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_3.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_4.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_5.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_6.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_7.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_8.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_1.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_2.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_3.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_4.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_5.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_6.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_7.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_8.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_1.png" alt="" />
            </li>
            <li>
                <img src="../static/img/slider_slides_2.png" alt="" />
            </li>
        </ul>
    </div>
</section>
<!-- End Slider_area -->

<!-- It-Work -->
<section class="row it-work row">
    <div class="container coustome-container">
        <div class="row fashion m0">
            <h2>问我们如何购买<br> 寻找您心仪的二手房，提交订单购买就可以啦！</h2>
            <div class="col-md-3 col-sm-6 item">
                <div class="round-icon">
                    <span class="lnr lnr-magnifier"></span>
                </div>
                <h4>搜索二手房</h4>
                <p>Over 3,000 properties</p>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="round-icon">
                    <span class="lnr lnr-users"></span>
                </div>
                <h4>提交订单</h4>
                <p>To make a order</p>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="round-icon">
                    <span class="lnr lnr-cart"></span>
                </div>
                <h4>联系中介</h4>
                <p>Over 1,000 agents</p>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="round-icon">
                    <span class="lnr lnr-thumbs-up"></span>
                </div>
                <h4>看房后付款</h4>
                <p>Cheers!</p>
            </div>
            <a href="sell/property_sell.jsp?page=1" class="find-agent active">搜索二手房 <i class="lnr lnr-arrow-right"></i></a>
            <%if(userVO==null){
            %>
            <a href="javascript:void(0);" onclick="nologin()" class="find-agent">我的订单列表 <i class="lnr lnr-arrow-right"></i></a>  <%
            }else{
            %><a href="personal.jsp" class="find-agent">我的订单列表 <i class="lnr lnr-arrow-right"></i></a>   <%  }%>
        </div>
    </div>
</section>
<!-- End It-Work -->

<!--Latest-Properties -->
<section class="latest-properties row">
    <div class="container coustome-container">
        <div class="row m0 latest_head">
            <h2>最新上架</h2>
            <div class="properties-slider">
                <%
                    List newest=(List) request.getSession().getAttribute("allhouse");
                    if(newest==null){
                    }else{
                        for(int j=0;j<(8<newest.size()?8:newest.size());j++){
                            House house=(House)newest.get(j);String lift2;
                            if(house.getHouselift()==0){
                                lift2="未标明";
                            }else if(house.getHouselift()==1){
                                lift2="有";
                            }else{
                                lift2="无";
                            }
                            %>
                                    <div class="item">
                                        <div class="ready_flat">
                                           <a href="javascript:void(0);" onclick ="single(<%=house.getHouseid()%>);"> <img src="../static/img/home.jpg" alt=""></a>
                                            <div class="content-area">
                                                <h4><%=house.getHouseaddress()%></h4>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a class="btn-slide activ">出售</a>
                                                <a class="btn-slide activ"><%=house.getHouseprice()%> RMB/m²</a>
                                                <%if(userVO==null){
                                                %><a href="javascript:void(0);" onclick ="nologin()" class="btn-slide activ">加入关注列表</a><%
                                            }else{
                                            %><a href="javascript:void(0);" onclick ="addlike(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="btn-slide activ">加入关注列表</a><%
                                                }%>
                                                <ul class="info">
                                                    <li><i class="lnr lnr-tag"></i> 客厅: <%=house.getKichen()%></li>
                                                    <li><i class="lnr lnr-tag"></i> 卧室: <%=house.getBedroom()%>5</li>
                                                    <li><i class="lnr lnr-tag"></i> 卫生间: <%=house.getBathroom()%></li>
                                                    <li><i class="lnr lnr-tag"></i> 楼层: <%=house.getHousefloor()%></li>
                                                    <li><i class="lnr lnr-tag"></i> 电梯: <%=lift2%></li>
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


<!--jQuery JS-->
<script src="../static/js/jquery-1.12.0.min.js"></script>
<!--Bootstrap JS-->
<script src="../static/js/bootstrap.min.js"></script>
<!--Bootstrap-select JS-->
<script src="../static/vendors/bootstrap-select/bootstrap-select.min.js"></script>
<!--Flexslider JS-->
<script src="../static/vendors/flexslider/js/jquery.flexslider.js"></script>
<!--Owl Carousel JS-->
<!--<script src="vendors/owl-carousel/owl.carousel.min.js"></script>-->
<script src="../static/js/owl.carousel.min.js"></script>
<!-- Counterup JS -->
<script src="../static/js/waypoints.min.js"></script>
<script src="../static/vendors/counter/jquery.counterup.min.js"></script>
<!--jQuery ui JS-->
<script src="../static/js/jquery-ui.min.js"></script>

<script src="../static/js/html5shiv.min.js"></script>
<script src="../static/js/respond.min.js"></script>
<!--Theme-->
<script src="../static/js/theme.js"></script>
</body>
</html>


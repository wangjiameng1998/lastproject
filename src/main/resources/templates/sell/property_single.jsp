<%@ page import="com.springboot.controller.viewobject.UserVO" %>
<%@ page import="com.springboot.dataObject.House" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.springboot.dataObject.Manager" %>
<!DOCTYPE HTML>
<html lang="en-US">
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
    <!--Theme Styles CSS-->
	<link rel="stylesheet" type="text/css" href="../../static/css/style.css" media="all" />
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="../../static/css/simpleAlert.css">
    <![endif]-->
</head>
<body>
    <%
        UserVO userVO=(UserVO) request.getSession().getAttribute("user");
    %>
    <!-- Heder_Top -->
    <header class="header_top_section row">
        <div class="container coustome-container">
            <div class="row top_header">
                <a href="http://localhost:8080/index"><i class="lnr lnr-phone-handset"></i> 15730069857</a>
                <a href="http://localhost:8080/personal.jsp"><i class="lnr lnr-envelope"></i> 15730069857</a>
                <ul>
                    <li><a href="#">，欢迎您！</a></li>
                    <li><a href="#">帮助</a></li>
                    <%if(userVO==null){%><li><a href="../login.jsp">请登录</a></li>
                    <%}else{%><li><a href="http://localhost:8080/exit">退出</a></li><%}%>
                </ul>
            </div>
        </div>
    </header>
	<!-- End Heder_Top  -->


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
                <a class="navbar-brand_logo" href="#"><img src="../../static/img/logo.png" alt="Logo"></a>
            </div>
            <!-- Collect the nav home, property  -->
            <div class="row collapse navbar-collapse" id="main_menu">
                <ul class="nav navbar-right nav_buttom">
                    <li><a href="property_sell.jsp?page=1">查询房源 <i class="lnr lnr-arrow-right"></i></a></li>
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

    <!-- Banner area -->
	<section class="banner-area row">
	    <h2>商品详情</h2>
         <div class="bottom-menu-area">
             <a href="../index.jsp">首页</a>
             <i class="lnr lnr-chevron-right"></i>
             <a>商品</a>
             <i class="lnr lnr-chevron-right"></i>
             <a href="property_single.jsp">商品详情</a>
         </div>
	</section>
	<!-- End Banner area -->
	<%
        House house=(House)request.getSession().getAttribute("housesingle");
        Manager manager=(Manager)request.getSession().getAttribute("housem");
    %>
    <script>
        function nologin(){
            alert("请先注册或登录！");
        }
    </script>
	<!-- Proparty area -->
    <section class="property_single">
        <div class="flat">
            <img src="../../static/img/property_single/flat.jpg" alt="">
        </div>
            <div class="container coustome-container">
                <div class="flat_details">
                    <h1><%=house.getHouseaddress()%></h1>
                    <h5>￥<%=new DecimalFormat("0.00").format((float)house.getHousearea()*house.getHouseprice()/10000)%>万</h5>
                    <a>出售中</a>
                    <%if(userVO==null){
                    %><a href="javascript:void(0);" onclick ="nologin()" class="btn-slide activ">加入关注列表</a><%
                }else{
                %><a href="javascript:void(0);" onclick ="addlike(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="btn-slide activ">加入关注列表</a><%
                    }%>
                    <%if(userVO==null){
                    %>
                    <a href="javascript:void(0);" onclick="nologin()" class="contact">立即下单<i class="lnr lnr-arrow-right"></i></a>
                    <%
                    }else{
                    %><a  id="manyAllChoseAlert" href="javascript:void(0);" onclick="c(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="contact">立即下单<i class="lnr lnr-arrow-right"></i></a>
                    <%  }%>
                    <div class="for_rent row">
                        <div class="col-md-4 col-sm-6 listing">
                            <img src="../../static/img/property_single/rent.png" alt="">
                            <h4>房龄：<%=house.getHouseage()%>年</h4>
                        </div>
                        <div class="col-md-4 col-sm-6 listing">
                            <img src="../../static/img/property_single/office.png" alt="">
                            <h4>楼层：<%=house.getHousefloor()%>楼</h4>
                           </div>
                        <div class="col-md-4 col-sm-6 listing">
                            <img src="../../static/img/property_single/california.png" alt="">
                            <h4>朝向：<%=house.getHouseface()%></h4>
                        </div>
                    </div>
                </div>
                <div class="about_property">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="fun_fact">
                                <h2>关于房屋</h2>
                                <p><%=house.getHouseuse()%></p>
                                <div class="row counter_inner text-center">
                                    <div class="counter_up col-md-3 col-sm-6">
                                        <div class="counter_item">
                                            <img src="../../static/img/person/coin14.png" alt="">
                                            <span class="counter"><%=house.getHouselike()%></span>
                                            <p>收藏数</p>
                                        </div>
                                    </div>
                                    <div class="counter_up col-md-3 col-sm-6">
                                        <div class="counter_item">
                                            <img src="../../static/img/property_single/bathrooms.png" alt="">
                                            <span class="counter"><%=house.getBathroom()%></span>
                                            <p>卫生间</p>
                                        </div>
                                    </div>
                                    <div class="counter_up col-md-3 col-sm-6">
                                        <div class="counter_item">
                                            <img src="../../static/img/property_single/parking.png" alt="">
                                            <span class="counter"><%=house.getHouselift()%></span>
                                            <p>电梯</p>
                                        </div>
                                    </div>
                                    <div class="counter_up col-md-3 col-sm-6">
                                        <div class="counter_item">
                                            <img src="../../static/img/property_single/bedrooms.png" alt="">
                                            <span class="counter"><%=house.getBedroom()%></span>
                                            <p>卧室</p>
                                        </div>
                                    </div>
                                 </div>
                               </div>
                           <div class="additional_details row">
                               <h2>其他细节</h2>
                                <!-- Nav tabs -->
                                <div class="col-md-6 nav_tabs">
                                    <ul class="nav" role="tablist">
                                        <li class="active"><a href="#1" data-toggle="tab">About The Construction</a></li>
                                        <li><a href="#2" data-toggle="tab">关于位置</a></li>
                                        <li><a href="#3" data-toggle="tab">关于装修</a></li>
                                        <li><a href="#4" data-toggle="tab">关于楼层</a></li>
                                        <li><a href="#5" data-toggle="tab">关于朝向</a></li>
                                    </ul>
                                </div>
                                <!-- Tab panes -->
                                <div class="col-md-6 tab-content">
                                    <div role="tabpanel" class="tab-pane active" id="1">
                                        <p>I get calls every week from lawyers saying they’re not getting calls anymore from yellow page advertising. Having done quite well in the past, they’re afraid to discontinue the advertising. They want to know what’s going on and what to do.</p>
                                        <p>Apparently, lawyers are not the only ones. In his article “Quit wasting money on Yellow Page advertising” by Peter Fernandez, D.C., a yellow page, print advertising and practice management consultant for chiropractors, Dr. Fernandez answers the question, “Why has advertising in the Yellow Pages changed from one of the best ways to advertise to one</p>
                                    </div>
                                    <div role="tabpanel" class="tab-pane" id="2">
                                        <p>Apparently, lawyers are not the only ones. In his article “Quit wasting money on Yellow Page advertising” by Peter Fernandez, D.C., a yellow page, print advertising and practice management consultant for chiropractors, Dr. Fernandez answers the question, “Why has advertising in the Yellow Pages changed from one of the best ways to advertise to one</p>
                                        <p>I get calls every week from lawyers saying they’re not getting calls anymore from yellow page advertising. Having done quite well in the past, they’re afraid to discontinue the advertising. They want to know what’s going on and what to do.</p>
                                    </div>
                                    <div role="tabpanel" class="tab-pane" id="3">
                                        <p>I get calls every week from lawyers saying they’re not getting calls anymore from yellow page advertising. Having done quite well in the past, they’re afraid to discontinue the advertising. They want to know what’s going on and what to do.</p>
                                        <p>Apparently, lawyers are not the only ones. In his article “Quit wasting money on Yellow Page advertising” by Peter Fernandez, D.C., a yellow page, print advertising and practice management consultant for chiropractors, Dr. Fernandez answers the question, “Why has advertising in the Yellow Pages changed from one of the best ways to advertise to one</p>
                                    </div>
                                    <div role="tabpanel" class="tab-pane" id="4">
                                        <p>Apparently, lawyers are not the only ones. In his article “Quit wasting money on Yellow Page advertising” by Peter Fernandez, D.C., a yellow page, print advertising and practice management consultant for chiropractors, Dr. Fernandez answers the question, “Why has advertising in the Yellow Pages changed from one of the best ways to advertise to one</p>
                                        <p>I get calls every week from lawyers saying they’re not getting calls anymore from yellow page advertising. Having done quite well in the past, they’re afraid to discontinue the advertising. They want to know what’s going on and what to do.</p>
                                    </div>
                                    <div role="tabpanel" class="tab-pane" id="5">
                                        <p>I get calls every week from lawyers saying they’re not getting calls anymore from yellow page advertising. Having done quite well in the past, they’re afraid to discontinue the advertising. They want to know what’s going on and what to do.</p>
                                        <p>Apparently, lawyers are not the only ones. In his article “Quit wasting money on Yellow Page advertising” by Peter Fernandez, D.C., a yellow page, print advertising and practice management consultant for chiropractors, Dr. Fernandez answers the question, “Why has advertising in the Yellow Pages changed from one of the best ways to advertise to one</p>
                                    </div>
                                </div>
                            </div>
                       </div>
                    <div class="col-md-4">
                       <div class="agent">
                           <h4>联系中介</h4>
                        <div class="agent_info">
                            <div class="profile_info">
                                <div class="profile_pic">
                                    <img class="img-circle" src="../../static/img/property_single/robin.jpg" alt="">
                                </div>
                                <div class="name_position">
                                    <h3><%=manager.getManagername()%></h3>
                                    <h6><%=manager.getManagersex()%></h6>
                                </div>
                            </div>
                        </div>
                        <div class="sent_message">
                            <h4>与他联系</h4>
                            <form>
                                <input type="text" id="msg" class="form-control" placeholder value="你好！">
                                <%if(userVO==null){
                                %><button onclick="nologin()" >发送<i class="lnr lnr-arrow-right"></i></button>
                                <%
                            }else{
                            %><button onclick="sendmsg(<%=manager.getManagerid()%>,<%=userVO.getUserid()%>)">发送<i class="lnr lnr-arrow-right"></i></button>
                                <%
                                }%>
                                 </form>
                        </div>
                       </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
	<!-- End Proparty area -->

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
    <script src="../../static/js/jquery-1.12.0.min.js"></script><script src="../../static/js/respond.min.js"></script>
    <script type="text/javascript" src="../../static/js/jquery.min.js"></script>
    <script src="../../static/js/html5shiv.min.js"></script>
    <link rel="stylesheet" href="../../static/css/simpleAlert.css">
    <script src="../../static/js/buttonjs/simpleAlert.js"></script>
    <script>
        function c(uid,hid){
            var manyAllChoseAlert =simpleAlert({
                "content":"确定提交订单!",
                "buttons":{
                    "确定":function () {
                        var manyAllChoseAlert2 =simpleAlert({
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
                                                manyAllChoseAlert2.close();alert(data.result);
                                                manyAllChoseAlert3.close();
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
    </script>
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
        function sendmsg(mid,uid) {
            jQuery.support.cors = true;
            $.post("http://localhost:8080/sendmsg",
                //发送给后端的数据
                {"mid":mid,"uid":uid,"content":document.getElementById("msg").value},
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


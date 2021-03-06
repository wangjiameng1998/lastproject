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
                <li><a href="#">????????????</a></li>
                <li><a href="#">????????????</a></li>
                <%if(userVO==null){%><li><a href="../login.jsp">?????????</a></li>
                <%}else{%><li><a href="http://localhost:8080/exit">??????</a></li><%}%>
            </ul>
        </div>
    </div>
</header>
<script>
    function c(uid,hid) {
        var manyAllChoseAlert = simpleAlert({
            "content":"??????????????????!",
            "buttons":{
                "??????":function () {
                    var manyAllChoseAlert2 = simpleAlert({
                        "content":"?????????????????????????????????????????????!",
                        "buttons":{
                            "??????":function () {
                                jQuery.support.cors = true;
                                $.post("http://localhost:8080/addorder",
                                    //????????????????????????
                                    {"uid":uid,"hid":hid},
                                    //????????????
                                    function(data){
                                        if (data.result.trim()!="1"){
                                            alert(data.result);
                                            manyAllChoseAlert2.close();
                                        }
                                    }
                                )
                                var manyAllChoseAlert3 = simpleAlert({
                                    "content":"???????????????!",
                                    "closeAll":true,
                                    "buttons":{
                                        "??????":function () {
                                            manyAllChoseAlert3.close();
                                            window.location.href="http://localhost:8080/personal.jsp";
                                        }
                                    }
                                })
                            },
                            "??????":function () {
                                manyAllChoseAlert2.close();
                            }
                        }
                    })
                },
                "??????":function () {
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
                <li><a href="#">???????????? <i class="lnr lnr-arrow-right"></i></a></li>
            </ul>
            <ul class="nav navbar-nav navbar-menu">
                <li><a href="http://localhost:8080/index">??????</a></li>
                <%
                    if( userVO!=null){
                %>
                <li><a href="../personal.jsp">???????????? </a></li>
                <%
                }
                else{
                %>
                <li><a href = "javascript:void(0);" onclick ="nologin()">???????????? </a></li>
                <%
                    }
                %>

                <li><a href="property_sell.jsp?page=1">?????????</a></li>
                <%
                    if( userVO==null){
                %>
                <li><a href="../login.jsp">??????/??????</a></li>        <%
                }
            %>
            </ul>
        </div><!-- End navbar-collapse -->
    </div>
</nav>
<!-- End Heder_Bottom -->
<script>
    function nologin(){
        alert("????????????????????????");
    }
</script>
<!-- Banner area -->
<section class="banner-area row">
    <% if(list==null||list.size()==0){
    %><h2>???????????????????????????????????????????????????</h2><%
    }else{
        %><h2>????????????</h2><%
    }
    %>
    <div class="bottom-menu-area">
        <a href="http://localhost:8080/index">??????</a>
        <i class="lnr lnr-chevron-right"></i>
        <a href="property_sell.jsp?page=1">??????</a>
        <i class="lnr lnr-chevron-right"></i>
        <a href="property_sell.jsp?page=1">????????????</a>
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
            <h2>????????????</h2>
            <div class="properties-slider">
                <%
                        for(int i=0;i<((put.size()-6*(p-1))<3?(put.size()-6*(p-1)):3);i++){
                            House house=(House)put.get(i+(p-1)*6);String lift;
                            if(house.getHouselift()==0){
                                lift="?????????";
                            }else if(house.getHouselift()==1){
                                lift="???";
                            }else{
                                lift="???";
                            }
                %>
                <div class="item">
                    <div class="ready_flat">
                        <a href="javascript:void(0);" onclick ="single(<%=house.getHouseid()%>);"><img src="../../static/img/home.jpg" alt="">
                        </a><div class="content-area">
                        <h4><%=house.getHouseaddress()%></h4>
                        <a href="" class="btn-slide activ">??????</a>
                        <a href="" class="btn-slide activ"><%=house.getHouseprice()%> RMB/m??</a>
                        <%if(userVO==null){
                        %><a href="javascript:void(0);" onclick ="nologin();" class="btn-slide activ">??????????????????</a><%
                    }else{
                    %><a href="javascript:void(0);" onclick ="addlike(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="btn-slide activ">??????????????????</a><%
                        }%>
                        <ul class="info">
                            <li><i class="lnr lnr-tag"></i> ??????: <%=house.getKichen()%></li>
                            <li><i class="lnr lnr-tag"></i> ??????: <%=house.getBedroom()%></li>
                            <li><i class="lnr lnr-tag"></i> ?????????: <%=house.getBathroom()%></li>
                            <li><i class="lnr lnr-tag"></i> ??????: <%=house.getHousefloor()%></li>
                            <li><i class="lnr lnr-tag"></i> ??????: <%=lift%></li>
                            <li><i class="lnr lnr-tag"></i> ??????: <%=house.getHousearea()%>m??</li>
                        </ul>
                        <%if(userVO==null){
                        %>
                        <a href="javascript:void(0);" onclick="nologin()" class="contact">????????????<i class="lnr lnr-arrow-right"></i></a>
                        <%
                        }else{
                        %><a  id="manyAllChoseAlert" href="javascript:void(0);" onclick="c(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="contact">????????????<i class="lnr lnr-arrow-right"></i></a>
                        <%  }%>
                        <h1>???<%=new DecimalFormat("0.00").format((float)house.getHousearea()*house.getHouseprice()/10000)%>???</h1>
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
                                lift="?????????";
                            }else if(house.getHouselift()==1){
                                lift="???";
                            }else{
                                lift="???";
                            }
                %>
                <div class="item">
                    <div class="ready_flat">
                        <a href="javascript:void(0);" onclick ="single(<%=house.getHouseid()%>);"><img src="../../static/img/home.jpg" alt="">
                        </a><div class="content-area">
                        <h4><%=house.getHouseaddress()%></h4>
                        <a href="" class="btn-slide activ">??????</a>
                        <a href="" class="btn-slide activ"><%=house.getHouseprice()%> RMB/m??</a>
                        <%if(userVO==null){
                        %><a href="javascript:void(0);" onclick ="nologin();" class="btn-slide activ">??????????????????</a><%
                    }else{
                    %><a href="javascript:void(0);" onclick ="addlike(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="btn-slide activ">??????????????????</a><%
                        }%>
                        <ul class="info">
                            <li><i class="lnr lnr-tag"></i> ??????: <%=house.getKichen()%></li>
                            <li><i class="lnr lnr-tag"></i> ??????: <%=house.getBedroom()%></li>
                            <li><i class="lnr lnr-tag"></i> ?????????: <%=house.getBathroom()%></li>
                            <li><i class="lnr lnr-tag"></i> ??????: <%=house.getHousefloor()%></li>
                            <li><i class="lnr lnr-tag"></i> ??????: <%=lift%></li>
                            <li><i class="lnr lnr-tag"></i> ??????: <%=house.getHousearea()%>m??</li>
                        </ul>
                        <%if(userVO==null){
                        %>
                        <a href="javascript:void(0);" onclick="nologin()" class="contact">????????????<i class="lnr lnr-arrow-right"></i></a>
                        <%
                        }else{
                        %><a  id="manyAllChoseAlert" href="javascript:void(0);" onclick="c(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="contact">????????????<i class="lnr lnr-arrow-right"></i></a>
                        <%  }%>
                        <h1>???<%=new DecimalFormat("0.00").format((float)house.getHousearea()*house.getHouseprice()/10000)%>???</h1>
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
                %><div class="Load-more">???????????????<i class="lnr lnr-sync"></i></div><%
            }else{
            %> <div class="Load-more"><a href="my-search-property.jsp?page=<%=p+1%>">??????????????????<i class="lnr lnr-sync"></i></a></div><%
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
                    <h4>????????????</h4>
                    <a href=""><img src="../../static/img/logo.png" alt=""></a>
                    <p>???????????????????????? </p>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="Subscribe">
                    <h4>???????????????????????????</h4>
                    <form class="footer-form">
                        <div class="form-imput">
                            <input type="email" class="form-email" placeholder="????????????">
                        </div>
                        <button type="submit" class="submit-btn">???????????? <i class="lnr lnr-arrow-right"></i></button>
                    </form>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="popular_tags">
                    <h4>????????????</h4>
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
                    <h4>????????????</h4>
                    <ul class="Feed">
                        <li>
                            <span><a href="#">???????????????</a>??????111</span>
                        </li>
                        <li>
                            <span><a href="#">??????</a>??????222</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="copy_right">
        ?? ?????????<a href="#">?????????</a> ????????????
    </div>
</footer>
<!-- End Footer Area -->

<!--jQuery JS-->
<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script>
    function addlike(uid,hid) {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/addlike",
            //????????????????????????
            {"uid":uid,"hid":hid},
            //????????????
            function(data){
                if (data.result.trim()!="1"){
                    alert(data.result);
                } else{
                    alert("?????????????????????");
                }
            }
        )
    }
</script>
<script>
    function single(id) {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/housesingle",
            //????????????????????????
            {"hid":id},
            //????????????
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



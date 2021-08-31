<%@ page import="java.util.List" %>
<%@ page import="com.springboot.controller.viewobject.UserVO" %>
<%@ page import="com.springboot.dataObject.Notice" %>
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
    <script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
    <!--Font-Awesome CSS-->
    <link rel="stylesheet" href="../../static/vendors/font-awesome/css/font-awesome.min.css">
    <!-- Fonts -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,300,300italic,400italic,500,500italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>
    <!-- jquery-ui css -->
    <link rel="stylesheet" type="text/css" href="../../static/css/jquery-ui.min.css" media="all" />
    <!--Theme Styles CSS-->
    <link rel="stylesheet" type="text/css" href="../../static/css/style.css" media="all" />
    <script type="text/javascript" src="../../static/js/address.js"></script>
    <link href="../../static/css/news/style.css" rel="stylesheet" type="text/css">
    <script src="../../static/js/sell/sell.js"></script>
    <link rel="stylesheet" href="../../static/css/simpleAlert.css">
    <script src="../../static/js/buttonjs/simpleAlert.js"></script>
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
        /*     })
         })*/
    </script>
</head>
<body>
<%
    UserVO userVO=new UserVO();
    userVO=(UserVO) request.getSession().getAttribute("user");

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
<!-- Banner area -->
<section class="banner-area row">
  <h2>商品列表</h2>
    <div class="bottom-menu-area">
        <a href="http://localhost:8080/index">首页</a>
        <i class="lnr lnr-chevron-right"></i>
        <a href="property_sell.jsp?page=1">商品</a>
        <i class="lnr lnr-chevron-right"></i>
        <a href="property_sell.jsp?page1">商品列表搜索</a>
    </div>
</section>
<!-- End Banner area -->
<!-- Heading-item area -->
<section class="heading-item-area">
    <div class="container coustome-container">
        <div >
            <div class="leftsite-by">
                <h3><i class="lnr lnr-funnel"></i> 排序按照:</h3>
                    <select class="selectpicker" id="selectby">
                        <option id="20" value="20">最新发布</option>
                        <option id="21" value="21" selected="selected">热门关注</option>
                        <option id="22" value="22">价格最优</option>
                    </select>
            </div><br>
            <div class="right-site-bar pull-right">
                <form class="navbar-form navbar-right" role="search">
                    <a href="javascript:void(0);" onclick ="searchh()" style="background-color: #96d036;color: #ffffff;width: 200px;" class="btn btn-submit">&nbsp;&nbsp;搜索&nbsp;&nbsp;</a>
                </form>
            </div>
                <span>选择地址&nbsp;</span>
                <select  class="int-text" id="cmbProvince" name="cmbProvince"></select>
                <select  class="int-text" id="cmbCity" name="cmbCity"></select>
                <select  class="int-text" id="cmbArea" name="cmbArea"></select>
                <span>&nbsp;&nbsp;详细地址：</span><input type="text" id="myaddress" value="" class="int-text" />
                <script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
                <script type="text/javascript">
                    addressInit('cmbProvince', 'cmbCity', 'cmbArea');
                </script>
                <span>&nbsp;&nbsp;房龄：</span>
                <select class="int-text" id="houseage">
                    <option  value="12" selected="selected">自定义</option>
                    <option  value="13">1年</option>
                    <option  value="14">1年~5年</option>
                    <option  value="15">5年~10年</option>
                    <option  value="16">10年~20年</option>
                    <option  value="17">20年及以上</option>
                </select>
                <input type="text" id="myage" value="" class="int-text" />
            <div ><br><span>心仪的二手房面积：</span>
                <select class="int-text" id="area">
                    <option  value="0" selected="selected">自定义</option>
                    <option  value="1">50平以下</option>
                    <option  value="2">50~100平</option>
                    <option  value="3">100~150平</option>
                    <option  value="4">150~200平</option>
                    <option  value="5">200平以上</option>
                </select>
                <input type="text" id="myarealow" value="" class="int-text" /><span>~</span>
                <input type="text" id="myareatop" value="" class="int-text" />
               <span>&nbsp;&nbsp;房型：</span>
                    <select class="int-text" id="bedroom">
                        <option  value="11" selected="selected">自定义</option>
                        <option  value="6">1室</option>
                        <option  value="7">2室</option>
                        <option  value="8">3室</option>
                        <option  value="9">4室</option>
                        <option  value="10">5室及以上</option>
                    </select>
                    <input type="text" id="mybedroom" value="" class="int-text" />
            </div></div>

        <div class="row all-widgets-area m0">
            <div class="col-md-3 col-sm-6 p0">
                <div class="widgets">
                    <h5>热门地点</h5>
                    <ul class="list">
                        <li>重庆</li>
                        <li>成都</li>
                        <li>北京</li>
                        <li>上海</li>
                        <li>深圳</li>
                    </ul>
                </div>
                <div class="widgets appartnemt">
                    <h5>热门问题</h5>
                    <form role="form" class="radio_area">
                        <ul class="list">
                            <%
                                List list=(List)  request.getSession().getAttribute("ques");
                                for(int i=0;i<(4<list.size()?4:list.size());i++){
                                    Notice notice = (Notice)list.get(i);
                                    %>
                            <li><a href="" onclick="looknews(<%=notice.getNoticeid()%>)"><%=notice.getNoticetitle()%></a></li>
                            <%
                                }
                            %>
                        </ul>
                    </form>
                </div>
                <div class="widgets appartnemt">
                    <h5>最新公告</h5>
                    <form role="form" class="radio_area">
                        <ul class="list">
                            <%
                                List n=(List)request.getSession().getAttribute("notice");
                                for(int i=0;i<(4<n.size()?4:n.size());i++){
                                    Notice notice = (Notice)n.get(i);
                            %>
                            <li><a href="" onclick="looknews(<%=notice.getNoticeid()%>)"><%=notice.getNoticetitle()%></a></li>
                                    <%
                                }
                            %>
                        </ul>
                    </form>
                </div>
            </div>
            <div class="col-md-9 col-sm-6 post-area">
                <%
                    List list1=(List) request.getSession().getAttribute("likehouse");
                    String pages=request.getParameter("page");
                    int p = Integer.parseInt(pages);
                    if(list1==null){
                    }else{
                        Integer totalpages=(list1.size()-(list1.size()%10))/10+1;
                        for(int i=0;i<((list1.size()-10*(p-1))<10?(list1.size()-10*(p-1)):10);i++){
                            House house=(House)list1.get(i+(p-1)*10);String lift;
                            if(house.getHouselift()==0){
                                lift="未标明";
                            }else if(house.getHouselift()==1){
                                lift="有";
                            }else{
                                lift="无";
                            }
                            %>
                                <div class="Building-University">
                                    <div class="Building">
                                        <a href="javascript:void(0);" onclick ="single(<%=house.getHouseid()%>);"><img src="../../static/img/property_listing/1.jpg" alt=""></a>
                                    </div>
                                    <div class="Building-content">
                                        <div class="right-area">
                                            <h3><%=house.getHouseaddress()%></h3><a>&nbsp;&nbsp;联系中介</a>
                                            <a  class="btn-slide"><%=house.getHouseprice()%> RMB/m²</a>
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
                                            <a href="javascript:void(0);" onclick="nologin()" class="contact">立即下单<i class="lnr lnr-arrow-right"></i></a>
                                            <%
                                            }else{
                                            %><a  id="manyAllChoseAlert" href="javascript:void(0);" onclick="c(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="contact">立即下单<i class="lnr lnr-arrow-right"></i></a>
                                            <%  }%>
                                            <h3>￥<%=new DecimalFormat("0.00").format((float)house.getHousearea()*house.getHouseprice()/10000)%>万</h3>
                                        </div>
                                    </div>
                                </div>
                <%
                    }
                        if(p ==totalpages){
                            %>     <div class="Load-more">无更多商品<i class="lnr lnr-sync"></i></div><%
                        }else{
                            %> <div class="Load-more"><a href="property_sell.jsp?page=<%=p+1%>">加载更多商品<i class="lnr lnr-sync"></i></a></div><%
                        }
                    }
                %>
            </div>
        </div>
    </div>
</section>
<!-- End Heading-item area -->


<!--jQuery JS-->
<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
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
    function looknews(id) {
        jQuery.support.cors = true;
        $.post("http://localhost:8080/newsingle",
            //发送给后端的数据
            {"id":id},
            //回调函数
            function(data){
                window.open('page.jsp', 'newwindow', 'height=100, width=400, top=410,left=610, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
            }
        )
           }
</script>
</body>
</html>



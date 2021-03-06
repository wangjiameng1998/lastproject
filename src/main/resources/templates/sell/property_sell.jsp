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
                                                manyAllChoseAlert2.close();alert(data.result);
                                                manyAllChoseAlert3.close();
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
                <li><a href="#">????????????</a></li>
                <li><a href="#">????????????</a></li>
                <%if(userVO==null){%><li><a href="../login.jsp">?????????</a></li>
                <%}else{%><li><a href="http://localhost:8080/exit">??????</a></li><%}%>
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
<!-- Banner area -->
<section class="banner-area row">
  <h2>????????????</h2>
    <div class="bottom-menu-area">
        <a href="http://localhost:8080/index">??????</a>
        <i class="lnr lnr-chevron-right"></i>
        <a href="property_sell.jsp?page=1">??????</a>
        <i class="lnr lnr-chevron-right"></i>
        <a href="property_sell.jsp?page1">??????????????????</a>
    </div>
</section>
<!-- End Banner area -->
<!-- Heading-item area -->
<section class="heading-item-area">
    <div class="container coustome-container">
        <div >
            <div class="leftsite-by">
                <h3><i class="lnr lnr-funnel"></i> ????????????:</h3>
                    <select class="selectpicker" id="selectby">
                        <option id="20" value="20">????????????</option>
                        <option id="21" value="21" selected="selected">????????????</option>
                        <option id="22" value="22">????????????</option>
                    </select>
            </div><br>
            <div class="right-site-bar pull-right">
                <form class="navbar-form navbar-right" role="search">
                    <a href="javascript:void(0);" onclick ="searchh()" style="background-color: #96d036;color: #ffffff;width: 200px;" class="btn btn-submit">&nbsp;&nbsp;??????&nbsp;&nbsp;</a>
                </form>
            </div>
                <span>????????????&nbsp;</span>
                <select  class="int-text" id="cmbProvince" name="cmbProvince"></select>
                <select  class="int-text" id="cmbCity" name="cmbCity"></select>
                <select  class="int-text" id="cmbArea" name="cmbArea"></select>
                <span>&nbsp;&nbsp;???????????????</span><input type="text" id="myaddress" value="" class="int-text" />
                <script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
                <script type="text/javascript">
                    addressInit('cmbProvince', 'cmbCity', 'cmbArea');
                </script>
                <span>&nbsp;&nbsp;?????????</span>
                <select class="int-text" id="houseage">
                    <option  value="12" selected="selected">?????????</option>
                    <option  value="13">1???</option>
                    <option  value="14">1???~5???</option>
                    <option  value="15">5???~10???</option>
                    <option  value="16">10???~20???</option>
                    <option  value="17">20????????????</option>
                </select>
                <input type="text" id="myage" value="" class="int-text" />
            <div ><br><span>???????????????????????????</span>
                <select class="int-text" id="area">
                    <option  value="0" selected="selected">?????????</option>
                    <option  value="1">50?????????</option>
                    <option  value="2">50~100???</option>
                    <option  value="3">100~150???</option>
                    <option  value="4">150~200???</option>
                    <option  value="5">200?????????</option>
                </select>
                <input type="text" id="myarealow" value="" class="int-text" /><span>~</span>
                <input type="text" id="myareatop" value="" class="int-text" />
               <span>&nbsp;&nbsp;?????????</span>
                    <select class="int-text" id="bedroom">
                        <option  value="11" selected="selected">?????????</option>
                        <option  value="6">1???</option>
                        <option  value="7">2???</option>
                        <option  value="8">3???</option>
                        <option  value="9">4???</option>
                        <option  value="10">5????????????</option>
                    </select>
                    <input type="text" id="mybedroom" value="" class="int-text" />
            </div></div>

        <div class="row all-widgets-area m0">
            <div class="col-md-3 col-sm-6 p0">
                <div class="widgets">
                    <h5>????????????</h5>
                    <ul class="list">
                        <li>??????</li>
                        <li>??????</li>
                        <li>??????</li>
                        <li>??????</li>
                        <li>??????</li>
                    </ul>
                </div>
                <div class="widgets appartnemt">
                    <h5>????????????</h5>
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
                    <h5>????????????</h5>
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
                                lift="?????????";
                            }else if(house.getHouselift()==1){
                                lift="???";
                            }else{
                                lift="???";
                            }
                            %>
                                <div class="Building-University">
                                    <div class="Building">
                                        <a href="javascript:void(0);" onclick ="single(<%=house.getHouseid()%>);"><img src="../../static/img/property_listing/1.jpg" alt=""></a>
                                    </div>
                                    <div class="Building-content">
                                        <div class="right-area">
                                            <h3><%=house.getHouseaddress()%></h3><a>&nbsp;&nbsp;????????????</a>
                                            <a  class="btn-slide"><%=house.getHouseprice()%> RMB/m??</a>
                                            <%if(userVO==null){
                                            %><a href="javascript:void(0);" onclick ="nologin()" class="btn-slide activ">??????????????????</a><%
                                        }else{
                                        %><a href="javascript:void(0);" onclick ="addlike(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="btn-slide activ">??????????????????</a><%
                                            }%>
                                            <ul class="info">
                                                <li><i class="lnr lnr-tag"></i> ??????: <%=house.getKichen()%></li>
                                                <li><i class="lnr lnr-tag"></i> ??????: <%=house.getBedroom()%></li>
                                                <li><i class="lnr lnr-tag"></i> ?????????: <%=house.getBathroom()%></li>
                                                <li><i class="lnr lnr-tag"></i> ??????: <%=house.getHousefloor()%></li>
                                                <li><i class="lnr lnr-tag"></i> ??????: <%=lift%></li>
                                                <li><i class="lnr lnr-tag"></i> ??????: <%=house.getHousearea()%> m??</li>
                                            </ul>
                                            <%if(userVO==null){
                                            %>
                                            <a href="javascript:void(0);" onclick="nologin()" class="contact">????????????<i class="lnr lnr-arrow-right"></i></a>
                                            <%
                                            }else{
                                            %><a  id="manyAllChoseAlert" href="javascript:void(0);" onclick="c(<%=userVO.getUserid()%>,<%=house.getHouseid()%>)" class="contact">????????????<i class="lnr lnr-arrow-right"></i></a>
                                            <%  }%>
                                            <h3>???<%=new DecimalFormat("0.00").format((float)house.getHousearea()*house.getHouseprice()/10000)%>???</h3>
                                        </div>
                                    </div>
                                </div>
                <%
                    }
                        if(p ==totalpages){
                            %>     <div class="Load-more">???????????????<i class="lnr lnr-sync"></i></div><%
                        }else{
                            %> <div class="Load-more"><a href="property_sell.jsp?page=<%=p+1%>">??????????????????<i class="lnr lnr-sync"></i></a></div><%
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
            //????????????????????????
            {"hid":id},
            //????????????
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
            //????????????????????????
            {"id":id},
            //????????????
            function(data){
                window.open('page.jsp', 'newwindow', 'height=100, width=400, top=410,left=610, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
            }
        )
           }
</script>
</body>
</html>



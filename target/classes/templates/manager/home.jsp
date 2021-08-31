<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Notice" %>
<%@ page import="com.springboot.dataObject.Order" %>
<%@ page import="java.nio.charset.CoderMalfunctionError" %>
<%@ page import="javax.swing.border.AbstractBorder" %>
<%@ page import="com.springboot.dataObject.Complaint" %>
<%@ page import="com.springboot.dataObject.Manager" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=utf-8" %>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>当日提醒</title>

    <link rel="shortcut icon" href="#">
    <link href="../.././static/css/home/bootstrap.min.css?v=3.3.5" rel="stylesheet">
    <link href="../.././static/css/home/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="../.././static/css/home/custom.css" rel="stylesheet">
    <link href="../.././static/css/home/animate.min.css" rel="stylesheet">
    <link href="../.././static/css/home/style.min.css?v=4.0.0" rel="stylesheet"><base target="_blank">
    <!--公共样式-->
    <link rel="stylesheet" href="../.././static/css/home/reset.css" />

    <!--主要样式-->
    <link rel="stylesheet" type="text/css" href="../.././static/css/home/simple-calendar.css">
    <link rel="stylesheet" href="../.././static/css/home/calendar.css" />
    <!--<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>-->
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight" >
    <div class="row" >
        <div class="inner">
            <div class="col-sm-4">
                <div id='calendar' class="sc-calendar " >
                    <div class="sc-header">
                        <div class="sc-title">
                            <div class="year"><span class="sc-select-year" name=""></span>年</div>
                            <div class="month">
                                <div class="arrow sc-mleft"></div>
                                <div class="monthdiv">
                                    <span class="sc-select-month" name=""></span>
                                </div>
                                <div class="arrow sc-mright"></div>
                            </div>
                        </div>
                        <div class="sc-week"></div>
                    </div>
                    <div class="sc-body">
                        <div class="sc-days"></div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>当日交易</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="announcement">
                            <ul class="order">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>全部公告</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a class="dropdown-toggle" data-toggle="dropdown" href="table_basic.html#">
                            <i class="fa fa-wrench"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                        </ul>
                        <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content">
                    <div class="announcement">
                        <ul class="matter">
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-4">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>投诉处理</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a class="dropdown-toggle" data-toggle="dropdown" href="table_basic.html#">
                            <i class="fa fa-wrench"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                        </ul>
                        <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content">
                    <div class="announcement">
                        <ul class="complaint">
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>下属员工</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a class="dropdown-toggle" data-toggle="dropdown" href="table_basic.html#">
                            <i class="fa fa-wrench"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                        </ul>
                        <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>员工号</th>
                            <th>姓名</th>
                            <th>性别</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List low=(List)request.getSession().getAttribute("lowmanager");
                            if(low!=null){
                                for(int i=0;i<low.size();i++){
                                    Manager manager =(Manager)low.get(i);;
                        %>
                        <tr>
                            <td><%=manager.getManagerid()%></td>
                            <td><%=manager.getManagername()%></td>
                            <td><%=manager.getManagersex()%></td>

                        </tr>
                        <%  } }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>热门问题</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a class="dropdown-toggle" data-toggle="dropdown" href="table_basic.html#">
                            <i class="fa fa-wrench"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                        </ul>
                        <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content">
                    <div class="announcement">
                        <ul class="question">
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="../.././static/js/homejs/jquery.min.js?v=2.1.4"></script>
<script src="../.././static/js/homejs/bootstrap.min.js?v=3.3.5"></script>
<script src="../.././static/js/homejs/jquery.peity.min.js"></script>
<script src="../.././static/js/homejs/content.min.js?v=1.0.0"></script>
<script src="../.././static/js/homejs/icheck.min.js"></script>
<script src="../.././static/js/homejs/peity-demo.min.js"></script>
<script>
    $(document).ready(function(){$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})});
</script>
<script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
<script type="text/javascript" src="../.././static/js/homejs/jquery.min.js" ></script>
<script type="text/javascript" src="../.././static/js/homejs/simple-calendar.js"></script>
<script type="text/javascript" src="../.././static/js/homejs/hammer-2.0.8-min.js"></script>
<script type="text/javascript">
    var myCalendar = new SimpleCalendar('#calendar');
    complaint();
    $(function(){
        var monthCH = $('.sc-select-month').text();
        $(".sc-mleft").click(function(){
            myCalendar.subMonth();
            var year = $('.sc-select-year').text();
            var monthCH = $('.sc-select-month').text();
            var month = SimpleCalendar.prototype.languageData.months_CH.indexOf(monthCH)+1;
        })
        $(".sc-mright").click(function(){
            myCalendar.addMonth();
            var year = $('.sc-select-year').text();
            var monthCH = $('.sc-select-month').text();
            var month = SimpleCalendar.prototype.languageData.months_CH.indexOf(monthCH)+1;
        })
    });

    //滑动切换
    var myElement = document.getElementById('calendar');
    var hammer = new Hammer(myElement);
    hammer.on("swipeleft", function (ev) {
        myCalendar.addMonth();
    });
    hammer.on("swiperight", function (ev) {
        myCalendar.subMonth();
    });

    //添加标记
    var mark = {
        '2018-10-11':[
            {title:'无其他公告'},
            {title:'无其他公告'},
            {title:'无其他公告'},
            {title:'无其他公告'},
            {title:'无其他公告'},
            {title:'无其他公告'},
            {title:'无其他公告'},
        ],
    };
    myCalendar._defaultOptions.mark=mark;
    myCalendar.update();



    //显示当天的活动在初始化mark之后
    //初始化今天的活动
    //有标记的日期点击事件
    $('#calendar').on("click", '.sc-selected', function() {
        complaint();
        window.location.reload();
    });

    function complaint() {
        <%  List list4=(List)request.getSession().getAttribute("question");
              if(list4!=null){
               int integer=list4.size();
      %>
        var quesHtml=''
        quesHtml +='<a href="../news.jsp"> <li class="announceItem"><div><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=1){Notice notice=(Notice) list4.get(0);%><%=notice.getNoticetitle()%><%}else{%>无其他热门问题<%}%></p></div></li><a> '
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=2){Notice notice=(Notice) list4.get(1);%><%=notice.getNoticetitle()%><%}else{%>无其他热门问题<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=3){Notice notice=(Notice) list4.get(2);%><%=notice.getNoticetitle()%><%}else{%>无其他热门问题<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=4){Notice notice=(Notice) list4.get(3);%><%=notice.getNoticetitle()%><%}else{%>无其他热门问题<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=5){Notice notice=(Notice) list4.get(4);%><%=notice.getNoticetitle()%><%}else{%>无其他热门问题<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=6){Notice notice=(Notice) list4.get(5);%><%=notice.getNoticetitle()%><%}else{%>无其他热门问题<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=7){Notice notice=(Notice) list4.get(6);%><%=notice.getNoticetitle()%><%}else{%>无其他热门问题<%}%></p></div></li>';
        <%}%>
        $('.question').html(quesHtml);
        <%  List list3=(List)request.getSession().getAttribute("complaint");
                if(list3!=null){
                 int i=list3.size();
        %>
        var comHtml=''
        comHtml +='<a href="../news.jsp"> <li class="announceItem"><div><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(i>=1){Complaint complaint=(Complaint) list3.get(0);%>员工号为<%=complaint.getComid()%>的员工被投诉，投诉等待处理。<%}else{%>无等待被处理的投诉<%}%></p></div></li><a> '
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(i>=2){Complaint complaint=(Complaint) list3.get(1);%>员工号为<%=complaint.getComid()%>的员工被投诉，投诉等待处理。<%}else{%>无等待被处理的投诉<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(i>=3){Complaint complaint=(Complaint) list3.get(2);%>员工号为<%=complaint.getComid()%>的员工被投诉，投诉等待处理。<%}else{%>无等待被处理的投诉<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(i>=4){Complaint complaint=(Complaint) list3.get(3);%>员工号为<%=complaint.getComid()%>的员工被投诉，投诉等待处理。<%}else{%>无等待被处理的投诉<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(i>=5){Complaint complaint=(Complaint) list3.get(4);%>员工号为<%=complaint.getComid()%>的员工被投诉，投诉等待处理。<%}else{%>无等待被处理的投诉<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(i>=6){Complaint complaint=(Complaint) list3.get(5);%>员工号为<%=complaint.getComid()%>的员工被投诉，投诉等待处理。<%}else{%>无等待被处理的投诉<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(i>=7){Complaint complaint=(Complaint) list3.get(6);%>员工号为<%=complaint.getComid()%>的员工被投诉，投诉等待处理。<%}else{%>无等待被处理的投诉<%}%></p></div></li>';
        <%}%>
        <% List list1=(List)request.getSession().getAttribute("order");
               if(list1!=null){
                int integer1=list1.size();
       %>
        var orderHtml=''
        orderHtml +='<a href="../news.jsp"> <li class="announceItem"><div><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer1>=1){Order order=(Order) list1.get(0);%>订单号为<%=order.getOrderid()%>的订单<%String state;if(order.getOrderstate()==0){state="订单已取消。";}else if(order.getOrderstate()==1){state="用户已下单。";}else if(order.getOrderstate()==2){state="用户已确认房源。";}else if(order.getOrderstate()==3){state="中介确认无误，同意售卖。";}else if(order.getOrderstate()==4){state="用户已付款。";}else{state="订单出错。";}%><%=state%><%}else{%>无其他消息<%}%></p></div></li><a> '
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer1>=2){Order order=(Order)  list1.get(1);%>订单号为<%=order.getOrderid()%>的订单<%String state;if(order.getOrderstate()==0){state="订单已取消。";}else if(order.getOrderstate()==1){state="用户已下单。";}else if(order.getOrderstate()==2){state="用户已确认房源。";}else if(order.getOrderstate()==3){state="中介确认无误，同意售卖。";}else if(order.getOrderstate()==4){state="用户已付款。";}else{state="订单出错。";}%><%=state%><%}else{%>无其他消息<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer1>=3){Order order=(Order)  list1.get(2);%>订单号为<%=order.getOrderid()%>的订单<%String state;if(order.getOrderstate()==0){state="订单已取消。";}else if(order.getOrderstate()==1){state="用户已下单。";}else if(order.getOrderstate()==2){state="用户已确认房源。";}else if(order.getOrderstate()==3){state="中介确认无误，同意售卖。";}else if(order.getOrderstate()==4){state="用户已付款。";}else{state="订单出错。";}%><%=state%><%}else{%>无其他消息<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer1>=4){Order order=(Order)  list1.get(3);%>订单号为<%=order.getOrderid()%>的订单<%String state;if(order.getOrderstate()==0){state="订单已取消。";}else if(order.getOrderstate()==1){state="用户已下单。";}else if(order.getOrderstate()==2){state="用户已确认房源。";}else if(order.getOrderstate()==3){state="中介确认无误，同意售卖。";}else if(order.getOrderstate()==4){state="用户已付款。";}else{state="订单出错。";}%><%=state%><%}else{%>无其他消息<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer1>=5){Order order=(Order) list1.get(4);%>订单号为<%=order.getOrderid()%>的订单<%String state;if(order.getOrderstate()==0){state="订单已取消。";}else if(order.getOrderstate()==1){state="用户已下单。";}else if(order.getOrderstate()==2){state="用户已确认房源。";}else if(order.getOrderstate()==3){state="中介确认无误，同意售卖。";}else if(order.getOrderstate()==4){state="用户已付款。";}else{state="订单出错。";}%><%=state%><%}else{%>无其他消息<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer1>=6){Order order=(Order)  list1.get(5);%>订单号为<%=order.getOrderid()%>的订单<%String state;if(order.getOrderstate()==0){state="订单已取消。";}else if(order.getOrderstate()==1){state="用户已下单。";}else if(order.getOrderstate()==2){state="用户已确认房源。";}else if(order.getOrderstate()==3){state="中介确认无误，同意售卖。";}else if(order.getOrderstate()==4){state="用户已付款。";}else{state="订单出错。";}%><%=state%><%}else{%>无其他消息<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer1>=7){Order order=(Order)  list1.get(6);%>订单号为<%=order.getOrderid()%>的订单<%String state;if(order.getOrderstate()==0){state="订单已取消。";}else if(order.getOrderstate()==1){state="用户已下单。";}else if(order.getOrderstate()==2){state="用户已确认房源。";}else if(order.getOrderstate()==3){state="中介确认无误，同意售卖。";}else if(order.getOrderstate()==4){state="用户已付款。";}else{state="订单出错。";}%><%=state%><%}else{%>无其他消息<%}%></p></div></li>';
        <%}%>
        <%  List list=(List)request.getSession().getAttribute("notice");
               if(list!=null){
                int integer=list.size();
       %>
        var matterHtml=''
        matterHtml +='<a href="../news.jsp"> <li class="announceItem"><div><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=1){Notice notice=(Notice) list.get(0);%><%=notice.getNoticetitle()%><%}else{%>无其他公告<%}%></p></div></li><a> '
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=2){Notice notice=(Notice) list.get(1);%><%=notice.getNoticetitle()%><%}else{%>无其他公告<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=3){Notice notice=(Notice) list.get(2);%><%=notice.getNoticetitle()%><%}else{%>无其他公告<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=4){Notice notice=(Notice) list.get(3);%><%=notice.getNoticetitle()%><%}else{%>无其他公告<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=5){Notice notice=(Notice) list.get(4);%><%=notice.getNoticetitle()%><%}else{%>无其他公告<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=6){Notice notice=(Notice) list.get(5);%><%=notice.getNoticetitle()%><%}else{%>无其他公告<%}%></p></div></li>'
            +'<li class="announceItem"><div class="fl announceImg">'
            +'<img class=" " src="../.././static/img/images/content.png"/></div><div><p class="announceContent"><%if(integer>=7){Notice notice=(Notice) list.get(6);%><%=notice.getNoticetitle()%><%}else{%>无其他公告<%}%></p></div></li>';
        <%}%>
        $('.matter').html(matterHtml);
        $('.order').html(orderHtml);
        $('.complaint').html(comHtml);
    }
</script>
</body>

</html>
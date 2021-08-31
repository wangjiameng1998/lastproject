<html>
<head><%@ page contentType="text/html; charset=utf-8" %>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="../../static/js/address.js"></script>
    <link href="../../static/css/news/style.css" rel="stylesheet" type="text/css">
</head>

<body>
<%--地址定位--%>
<div class="xt-center">
    <div id="xt-right">
        <div class="xt-bt">功能导航> 房源管理 > 上传房源</div>
        <div class="xt-input">
                <%--<span>账号/邮箱</span><input type="text" class="int-text" />--%>
                <span>房屋地址</span>
                    <select  class="int-text" id="cmbProvince" name="cmbProvince"></select>
                    <select  class="int-text" id="cmbCity" name="cmbCity"></select>
                    <select  class="int-text" id="cmbArea" name="cmbArea"></select>
                    <span>详细地址：</span><input type="text" id="address" value="" class="int-text" />
        </div>
        <div class="xt-input">
                <span>请输入房屋面积（m²）</span><input type="text" id="area" value="" class="int-text" />
        </div>
        <div class="xt-input">
                  <span>请输入房屋单价（RMB/m²）</span><input type="text" id="price" value="" class="int-text" />
        </div>
        <div class="xt-input">
            <span>请输入房屋朝向</span><input type="text" id="face" placeholder="选填" class="int-text" />
        </div>
        <div class="xt-input">
            <span>客厅数目</span><input type="text" id="kicthens"  value="" class="int-text" />
        </div>
        <div class="xt-input">
            <span>卧室数目</span><input type="text" id="bedroom"  value="" class="int-text" />
        </div>
        <div class="xt-input">
            <span>卫生间数目</span><input type="text" id="bathroom"  class="int-text" />
        </div>
        <div class="xt-input">
            <span>请输入房屋楼层</span><input type="text" id="floor"  class="int-text" />
            <span>是否有电梯</span>
            <select  class="int-text" id="lift" name="lift">
                <option value="0" id="0">未标明</option>
                <option value="1" id="1" >有</option>
                <option value="2" id="2">无</option>
            </select>
        </div>
        <div class="xt-input">
            <span>请输入房屋年龄</span><input type="text" id="age" class="int-text" />
        </div>
        <div class="xt-input">
            <span>其他说明</span><input type="text" id="label" placeholder="选填" class="int-text" />
        </div>

        <center>
        <input type="button" id="button1" onclick="submitto()" value="提交" class="green-int" />
        <input type="button" id="button2" onclick="tocancel()" value="取消" class="yellow-int" /></center>
    </div>
</div>
<script src="../../static/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function submitto(){
        if (document.getElementById("area").value == "" || document.getElementById("price").value == "" || document.getElementById("kicthens").value == "" ||
    document.getElementById("bedroom").value==""||document.getElementById("bathroom").value==""||document.getElementById("floor").value==""||
            document.getElementById("age").value=="" ){
            alert("必填字段不能为空");
        }else{
        jQuery.support.cors = true;
        var address=document.getElementById("cmbProvince").value+document.getElementById("cmbCity").value+document.getElementById("cmbArea").value+document.getElementById("address").value;
        $.post("http://localhost:8080/addhouse",
            //发送给后端的数据
            {"address":address,
                "area":document.getElementById("area").value,
                "price":document.getElementById("price").value,
                "face":document.getElementById("face").value,
                "kicthens":document.getElementById("kicthens").value,
                "bedroom":document.getElementById("bedroom").value,
                "bathroom":document.getElementById("bathroom").value,
                "floor":document.getElementById("floor").value,
                "lift":document.getElementById("lift").value,
                "age":document.getElementById("age").value,
                "label":document.getElementById("label").value,
            },
            //回调函数
            function(data){
                window.location.href="upload.jsp"
            }
        )     }
    }
</script>
<script type="text/javascript">
   function tocancel() {
       window.location.reload();
   }
</script>
<script type="text/javascript">
    addressInit('cmbProvince', 'cmbCity', 'cmbArea');
</script>
</body>
</html>


<%@ page import="com.springboot.controller.viewobject.ManagerVO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.springboot.dataObject.Picture" %>
<%@ page contentType="text/html; charset=utf-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="../../static/js/jquery-2.1.1.min.js"></script>
    <link href="../../static/css/news/style.css" rel="stylesheet" type="text/css">
<style>
    .head-img{
        text-align: center;
    }

    #img-upload{
        display: none;
    }
</style>
</head>
<body>
<form   method="POST" action="http://localhost:8080/uploadFile" enctype="multipart/form-data">
    <div class="xt-input"><div class="head-img">
    <img src="../../static/img/picture/add_img.png" id="show" width="200"/><br>
            <input type="button" value="选择文件" class="yellow-int" id="my-img">
        　<input type="file" id="img-upload" name="file" onchange="changepic(this)"/>
            <input type="submit"  value="提交" class="green-int"/>
    </div>
    </div>
</form>
<br><a href="myupload.jsp"  class="yellow-int">我的上传</a>
</body>
<script>
    $(document).ready(function(){
        $('#my-img').click(function(){
            $('#img-upload').click();
        });
    });
</script>
<script>
    function changepic() {
        var reads= new FileReader();
        f=document.getElementById('img-upload').files[0];
        reads.readAsDataURL(f);
        reads.onload=function (e) {
            document.getElementById('show').src=this.result;
        };
    }
</script>

</html>

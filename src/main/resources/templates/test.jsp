<%@ page import="com.springboot.dataObject.Picture" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>H5图片上传~</title>
    <link rel="stylesheet" type="text/css" href="../static/css/picture/index.css">

    <script type="text/javascript" src="../static/js/picture/jquery.min.js"></script>
    <script type="text/javascript" src="../static/js/picture/fileInput.js"></script>

    <script type="text/javascript" src="../static/js/picture/test.js"></script>
</head>
<%
    Picture picture=new Picture();picture.setPath("58/back.jpg");
    String s="../static/upload/"+picture.getPath();
String s1="../static/upload/58/back.jpg";

%>
<body>
<img src="<%=s%>" width="50%" height="50%"/>
<img src="<%=s1%>" width="50%" height="50%"/>

</body>
</html>
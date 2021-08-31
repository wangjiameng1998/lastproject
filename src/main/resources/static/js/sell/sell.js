function searchindex(){
    var address=window.document.getElementById("inputaddress").value;
    var area=window.document.getElementById("inputarea").value;
    var priceup=window.document.getElementById("inputprice").value;
    if (address==""||area==""||priceup==""){
        window.location.href="http://localhost:8080/sell/property_sell.jsp?page=1";
    }else{
        jQuery.support.cors = true;
         $.post("http://localhost:8080/indexsearch",
             //发送给后端的数据
             {"address":address,"area":area,"priceup":priceup},
             //回调函数
             function(data){
                 window.open("http://localhost:8080/sell/my-search-property.jsp?page=1");
             }
         )
    }
}
function nologin(){
    alert("请先注册或登录！");
}
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
function searchh(){
    var address=document.getElementById("cmbProvince").value+document.getElementById("cmbCity").value+document.getElementById("cmbArea").value+document.getElementById("myaddress").value;
   if (address == "" || (document.getElementById("houseage").value == 12&&document.getElementById("myage").value=="")||
       (document.getElementById("area").value==0&&document.getElementById("myarealow").value==""&&document.getElementById("myareatop").value)||
       (document.getElementById("bedroom").value==11&&document.getElementById("mybedroom").value=="")) {
    alert("请先进行选择或者输入");
   }
    jQuery.support.cors = true;
    $.post("http://localhost:8080/searchh",
        //发送给后端的数据
        {"address":address,
            "selectby":document.getElementById("selectby").value,
            "houseage":document.getElementById("houseage").value,
            "myage":document.getElementById("myage").value,
            "area":document.getElementById("area").value,
            "myarealow":document.getElementById("myarealow").value,
            "myareatop":document.getElementById("myareatop").value,
            "bedroom":document.getElementById("bedroom").value,
            "mybedroom":document.getElementById("mybedroom").value,
        },
        //回调函数
        function(data){
            window.open("http://localhost:8080/sell/my-search-property.jsp?page=1");
        }
    )
}

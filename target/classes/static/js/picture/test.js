$(function () {
    var cacheForPutHtml = '<div class="btn-control">' + $('.btn-control').html() + '</div>';//将提交栏DIV提取为常量

    //增加一栏上传图片DIV
    $('.add-more').click(function () {
        $('body').append(cacheForPutHtml);
    })
})

//开始上传图片
function do_upload(){
    //整理最终上传文件
    var nameFlags = 0;//重写文件名命名标记
    var tempFile = [];//临时文件对象存储变量

    $.each(allFile,function (k,v) {
        tempFile.push(new File([v],nameFlags.toString() + '.' + v.type.substr(6),{type: v.type}));//重建文件 加入数组
        nameFlags++;
    })

    var formData = new FormData();//FormData 转换成二进制文件上传至后台

    for(var i = 0; i < tempFile.length;i++){
        formData.append('uploads[]', tempFile[i]);
    }

    $.ajax({
        url: './doInput.php',
        type: 'POST',
        data: formData,                    // 上传formdata封装的数据
        dataType: 'JSON',
        cache: false,                      // 不缓存
        processData: false,                // jQuery不要去处理发送的数据
        contentType: false,                // jQuery不要去设置Content-Type请求头
        success:function (res) {           //成功回调
        }
    });
}

//移除一栏
function del_files(obj) {
    if (!emptyHtmlVal()){
        alert('再删啥都没啦~');
    } else{
        obj.parent('.btn-control').remove();
    }
}

//空选择器验证
function emptyHtmlVal() {
    if ($('.btn-control').length <= 1){
        return false;
    }
    return true;
}

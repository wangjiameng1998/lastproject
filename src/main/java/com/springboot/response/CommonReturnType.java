package com.springboot.response;

import org.springframework.boot.jdbc.metadata.DataSourcePoolMetadata;

/**
 * Created by  on 2019/4/16 0016.
 */
public class CommonReturnType {
/*表明对应请求的返回处理结果       success &&fail          */
    private String status;
    /*若statue=success返回请求的json数据*/
/*若为fail则返回通用的错误格式*/
    private Object data;

    public static CommonReturnType creat(Object result){

        return CommonReturnType.creat(result,"success");
    }
    public static CommonReturnType creat(Object result,String status){
        CommonReturnType commonReturnType=new CommonReturnType();
        commonReturnType.setStatus(status);
        commonReturnType.setData(result);
        return commonReturnType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}

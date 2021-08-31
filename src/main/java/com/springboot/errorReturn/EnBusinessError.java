package com.springboot.errorReturn;

/**
 * Created by  on 2019/4/17 0017.
 */
public enum EnBusinessError implements CommomError {

    PARAMETER_NALIDATION_ERROR(10001,"参数不合法"),/*00001通用错误类型*/
    UNKONWN_ERREO(10002,"未知错误"),
    USER_NOT_EXIST(20001,"用户不存在")    /*1000开头为用户相关信息定义*/
    ;

    private EnBusinessError(int errCode,String errMsg){
        this.errCode=errCode;
        this.errMsg=errMsg;
    }
    private int errCode;
    private String errMsg;

    @Override
    public int getErrCode() {
        return this.errCode;
    }

    @Override
    public String getErrMsg() {
        return this.errMsg;
    }

    @Override
    public CommomError setErrMsg(String errMsg) {
        this.errMsg=errMsg;
        return this;
    }
}

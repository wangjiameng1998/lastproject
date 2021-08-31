package com.springboot.errorReturn;

/**
 * Created by  on 2019/4/17 0017.
 */
/*包装器业务异常类实现*/
public class BusinessException extends Exception implements CommomError{

    private CommomError commomError;

    /*直接接受BusinessException的传参用于构造业务异常*/
    public BusinessException(CommomError commomError){
        super();
        this.commomError=commomError;
    }

    /*接收自定义的errmsg方式业务异常*/
    public BusinessException(CommomError commomError,String errMsg){
        super();
        this.commomError=commomError;
        this.commomError.setErrMsg(errMsg);
    }

    @Override
    public int getErrCode() {
        return this.commomError.getErrCode();
    }

    @Override
    public String getErrMsg() {
        return this.commomError.getErrMsg();
    }

    @Override
    public CommomError setErrMsg(String errMsg) {
         this.commomError.setErrMsg(errMsg);
        return this;
    }
}

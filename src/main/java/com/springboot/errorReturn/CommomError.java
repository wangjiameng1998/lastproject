package com.springboot.errorReturn;

/**
 * Created by  on 2019/4/17 0017.
 */
public interface CommomError {
    public int getErrCode();
    public String getErrMsg();
    public CommomError setErrMsg(String errMsg);
}

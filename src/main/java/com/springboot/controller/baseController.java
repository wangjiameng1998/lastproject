package com.springboot.controller;

import com.springboot.errorReturn.BusinessException;
import com.springboot.errorReturn.EnBusinessError;
import com.springboot.response.CommonReturnType;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by  on 2019/4/17 0017.
 */
public class baseController {
    /*定义exception handler解决未被controller吸收的异常*/
    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.OK)
    @ResponseBody
    public Object handlerException(HttpServletRequest request, HttpServletResponse response, Exception ex){
        response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
        Map<String,Object> responsemap=new HashMap<>();
        if(ex instanceof BusinessException){
            BusinessException businessException=(BusinessException)ex;

            responsemap.put("errrCode",businessException.getErrCode());
            responsemap.put("errrMsg",businessException.getErrMsg());
            return CommonReturnType.creat(responsemap,"fail");
        }else{
            responsemap.put("errrCode", EnBusinessError.UNKONWN_ERREO.getErrCode());
            responsemap.put("errrMsg",EnBusinessError.UNKONWN_ERREO.getErrMsg());

        }
        return CommonReturnType.creat(responsemap,"fail");

    }
}

package com.springboot.dao;

import com.springboot.dataObject.Password;
import org.springframework.stereotype.Component;

@Component
public interface PasswordMapper {
    int deleteByPrimaryKey(Integer pid);

    int insert(Password record);

    int insertSelective(Password record);

    Password selectByPrimaryKey(Integer pid);

    int updateByPrimaryKeySelective(Password record);

    int updateByPrimaryKey(Password record);

    Password getpassword(Integer oneid,Integer onepower);

    int updatep(Integer oneid,Integer onepower,String onepassword);
}
package com.springboot.dao;

import com.springboot.dataObject.User;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface UserMapper {
    int deleteByPrimaryKey(Integer userid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    User selectByTele(String tele);
    List getalluser();
    int freezebyuserid(Integer userid);
    int nofreezebyuserid(Integer userid);
    List getuserbyid(Integer userid);
    List getuserbyname(String username);
    List getuserbytele(String usertele);
}
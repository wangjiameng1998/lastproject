package com.springboot.dao;

import com.springboot.dataObject.Manager;
import org.springframework.stereotype.Component;

import java.util.List;


@Component
public interface ManagerMapper {
    int deleteByPrimaryKey(Integer managerid);

    int insert(Manager record);

    int insertSelective(Manager record);

    Manager selectByPrimaryKey(Integer managerid);

    int updateByPrimaryKeySelective(Manager record);

    int updateByPrimaryKey(Manager record);

    List listlowmanager();

    Integer getnewest();

    List listlowmanagerbyid(Integer mid);
    List listlowmanagerbyname(String mname);

    int deletebymid(Integer managerid);
    int freezebymid(Integer managerid);
    int nofreezebymid(Integer managerid);
}
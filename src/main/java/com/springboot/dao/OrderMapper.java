package com.springboot.dao;

import com.springboot.dataObject.Order;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface OrderMapper {
    int deleteByPrimaryKey(Integer orderid);

    int insert(Order record);

    int insertSelective(Order record);

    Order selectByPrimaryKey(Integer orderid);

    int updateByPrimaryKeySelective(Order record);

    int updateByPrimaryKey(Order record);

    List listallorder();

    List listorderok();

    List listorderon();
    List listallorderm(Integer m);

    List listorderokm(Integer m);

    List listorderonm(Integer m);
    List listuserorder(Integer uid);
    Integer deleteorder(Integer oid);
    Integer okorder(Integer oid);
    Integer queorder(Integer oid);
    Integer moneyorder(int oid);
}
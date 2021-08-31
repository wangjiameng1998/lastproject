package com.springboot.dao;

import com.springboot.dataObject.Houselike;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface HouselikeMapper {
    int deleteByPrimaryKey(Integer houselikeid);

    int insert(Houselike record);

    int insertSelective(Houselike record);

    Houselike selectByPrimaryKey(Integer houselikeid);

    int updateByPrimaryKeySelective(Houselike record);

    int updateByPrimaryKey(Houselike record);

    Houselike selectbyuidhid(Integer uid,Integer hid);
    List selectbyuid(Integer uid);
    List selectbyhid(Integer hid);
    Integer deletelike(Integer id);
}
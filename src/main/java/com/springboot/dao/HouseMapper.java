package com.springboot.dao;

import com.springboot.dataObject.House;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface HouseMapper {
    int deleteByPrimaryKey(Integer houseid);

    int insert(House record);

    int insertSelective(House record);

    House selectByPrimaryKey(Integer houseid);

    int updateByPrimaryKeySelective(House record);

    int updateByPrimaryKey(House record);

    List myaddhouse(Integer mid);

    Integer deletehbyid(Integer hid);

    Integer nodeletehbyid(Integer hid);
    Integer getnewesthouse(Integer mid);
    Integer updatelike(Integer hid);
    List selectallh();
    List listallhousebylike();
    List indexsearch1(String address,Integer arealow,Integer areatop,Integer priceup);
    List indexsearchbynew(String address,Integer arealow,Integer areatop,Integer agelow,Integer agetop,Integer bedlow,Integer bedtop);
    List indexsearchbyprice(String address,Integer arealow,Integer areatop,Integer agelow,Integer agetop,Integer bedlow,Integer bedtop);
    Integer uphstate(Integer hid);
    List indexsearchbylike(String address,Integer arealow,Integer areatop,Integer agelow,Integer agetop,Integer bedlow,Integer bedtop);
    Integer uphstateok(Integer hid);
    Integer deletelike(Integer hid);
    Integer sellout(Integer hid);

}
package com.springboot.dao;

import com.springboot.dataObject.Help;
import org.springframework.stereotype.Component;

import java.util.List;
@Component
public interface HelpMapper {
    int deleteByPrimaryKey(Integer helpid);

    int insert(Help record);

    int insertSelective(Help record);

    Help selectByPrimaryKey(Integer helpid);

    int updateByPrimaryKeySelective(Help record);
    List getallhelp(Integer mid);
    List gethelp(Integer mid,Integer uid);
    List getuserhelp(Integer uid);
    int updateByPrimaryKey(Help record);
}
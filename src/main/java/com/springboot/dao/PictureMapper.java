package com.springboot.dao;

import com.springboot.dataObject.Picture;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface PictureMapper {
    int deleteByPrimaryKey(Integer pid);

    int insert(Picture record);

    int insertSelective(Picture record);

    Picture selectByPrimaryKey(Integer pid);

    int updateByPrimaryKeySelective(Picture record);

    int updateByPrimaryKey(Picture record);
    Integer deletep(Integer pid);
    List selectbyhid(Integer hid);
}
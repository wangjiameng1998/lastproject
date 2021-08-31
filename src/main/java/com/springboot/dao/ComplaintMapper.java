package com.springboot.dao;

import com.springboot.dataObject.Complaint;
import org.springframework.stereotype.Component;

import java.util.List;
@Component
public interface ComplaintMapper {
    int deleteByPrimaryKey(Integer comid);

    int insert(Complaint record);

    int insertSelective(Complaint record);

    Complaint selectByPrimaryKey(Integer comid);

    int updateByPrimaryKeySelective(Complaint record);

    int updateByPrimaryKey(Complaint record);
    List listallcom();
    int agreecom(Integer comid,Integer managerid);
    int disagreecom(Integer comid,Integer managerid);
    List getmycom(Integer managerid);
    List usercom(Integer uid);
    Integer cancelcom(Integer cid);
    Complaint getcomto(Integer uid,Integer mid);

}
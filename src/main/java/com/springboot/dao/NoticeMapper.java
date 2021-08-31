package com.springboot.dao;

import com.springboot.dataObject.Notice;
import org.hibernate.validator.constraints.Range;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface NoticeMapper {
    int deleteByPrimaryKey(Integer noticeid);

    int insert(Notice record);

    int insertSelective(Notice record);

    Notice selectByPrimaryKey(Integer noticeid);

    int updateByPrimaryKeySelective(Notice record);

    int updateByPrimaryKey(Notice record);

    List listallnews();
    List listallnewsby(Integer field2);
    List listallcontent(String content);
    List listallbycontent(Integer field2,String content);

    int deletenbyid(Integer id);
}
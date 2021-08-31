package com.springboot.service;

import com.springboot.dataObject.Help;
import com.springboot.dataObject.Manager;
import com.springboot.dataObject.Notice;

import java.util.List;

/**
 * Created by  on 2019/4/25 0025.
 */
public interface OtherService{
    List listallnews();
    List listallnewsby(Integer field2);
    List listallorder();
    List listallcontent(String content);
    List listallbycontent(Integer field2,String content);
    Notice getbyid(Integer id);
    int deletenbyid(Integer id);
    int addnews(Notice notice);
    List listallorderby(Integer select);
    List listallorderm(Integer select,Integer m);
    Manager getmbyhid(Integer hid);
    int updatep(Integer oneid,Integer onepower,String onepassword);
    List gethelp(Integer mid,Integer uid);
    Integer huifu(Help help);
}

package com.springboot.service;

import com.springboot.dataObject.*;
import com.springboot.service.Model.UserModel;

import java.util.List;

/**
 * Created by  on 2019/4/16 0016.
 */
public interface UserService {

    UserModel getUserById(Integer id);
    UserModel getUserByTele(String tele);
    UserModel userRegister(String tele,String password);
    List listallhousebylike();
    List selectallh();
    List indexsearch(String address,Integer arealow,Integer areatop,Integer priceup);
    Integer addlike(Integer uid,Integer hid);
    Houselike selectbyuidhid(Integer uid, Integer hid);
    List indexsearch3(Integer select,String address,Integer arealow,Integer areatop,Integer agelow,Integer agetop,Integer bedlow,Integer bedtop);
    House gethousebyid(Integer hid);
    Integer insertorder(Order order);
    Integer updatehousestate(Integer hid);
    House single(Integer hid);
    Manager getmbyid(Integer mid);
    Integer uhuifu(Help help);
    List myorder(Integer uid);
    List mylike(Integer uid);
    List mymsg(Integer uid);
    List mycom(Integer uid);
    Integer deleteorder(Integer id);
    Integer userupdate(User user);
    Integer okorder(Integer id);
    List userhelpm(Integer uid);
    Integer addcom(Complaint complaint);
    Integer cancelcom(Integer cid);
    Complaint getcomto(Integer uid,Integer mid);
    Integer deletelike(Integer id);
    Integer moneyorder(Integer id);







}

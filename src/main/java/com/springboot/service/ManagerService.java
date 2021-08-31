package com.springboot.service;

import com.springboot.dataObject.Help;
import com.springboot.dataObject.House;
import com.springboot.dataObject.Manager;
import com.springboot.dataObject.Password;
import com.springboot.service.Model.ManagerModel;

import java.util.List;

/**
 * Created by  on 2019/4/23 0023.
 */
public interface ManagerService {
    ManagerModel getByMid(int mid);
    List listallcom();
    List listlowmanager();
    int addmanager(Manager manager,String password);
    List listlowmanagerbyid(Integer mid);
    List listlowmanagerbyname(String mname);
    int deletebymid(Integer managerid);
    int freezebymid(Integer managerid);
    int nofreezebymid(Integer managerid);
    int agreecom(Integer comid,Integer managerid);
    int disagreecom(Integer comid,Integer managerid);
    List getmycom(Integer managerid);
    List getalluser();
    int freezebyuserid(Integer userid);
    int nofreezebyuserid(Integer userid);
    List getuserbyid(Integer userid);
    List getuserbyname(String username);
    List getuserbytele(String usertele);
    int addhouse(House house);
    List myaddhouse(Integer mid);
    Integer deletehbyid(Integer hid);
    House gethbyid(Integer hid);
    Integer nodeletehbyid(Integer hid);
    int updatehbyid(House house);
    int addhousepicture(Integer hid,String path);
    Integer getnewesthouse(Integer mid);
    List selectbyhid(Integer hid);
    List getallhelp(Integer mid);
    Integer deletep(Integer pid);
    Integer queorder(Integer id);
}

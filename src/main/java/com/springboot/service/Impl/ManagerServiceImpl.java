package com.springboot.service.Impl;

import com.springboot.dao.*;
import com.springboot.dataObject.*;
import com.springboot.service.ManagerService;
import com.springboot.service.Model.ManagerModel;
import com.sun.tools.corba.se.idl.toJavaPortable.Helper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * Created by  on 2019/4/23 0023.
 */
@Service
public class ManagerServiceImpl implements ManagerService {
    @Autowired
    private ManagerMapper mMapper;
    @Autowired
    private ComplaintMapper complaintMapper;
    @Autowired
    private UserMapper userMapper;
    protected Date date;
    @Autowired
    private HouseMapper houseMapper;
    @Autowired
    private PasswordMapper passwordMapper;
    @Autowired
    private PictureMapper pictureMapper;
    @Autowired
    private HelpMapper helpMapper;
    @Autowired
    private OrderMapper orderMapper;
    @Override
    public ManagerModel getByMid(int mid) {
        Manager manager=mMapper.selectByPrimaryKey(mid);
        if(manager==null){
            return null;
        }
        Password password=passwordMapper.getpassword(mid,1);
        return convertFromDataobject(manager,password);
    }

    @Override
    public List listallcom() {
        return this.complaintMapper.listallcom();
    }

    @Override
    public List listlowmanager() {
        return this.mMapper.listlowmanager();
    }

    @Override
    public int addmanager(Manager manager, String password) {
        int i=this.mMapper.insertSelective(manager);
        Integer id=this.mMapper.getnewest();
        Password password1=new Password();
        password1.setOnepassword(password);
        password1.setOneid(id);
        password1.setOnepower(manager.getmanagerpower());date=new Date();
        password1.setOnetime(date);
        return this.passwordMapper.insertSelective(password1);
    }

    @Override
    public List listlowmanagerbyid(Integer mid) {
        return this.mMapper.listlowmanagerbyid(mid);
    }

    @Override
    public List listlowmanagerbyname(String mname) {
        return this.mMapper.listlowmanagerbyname(mname);
    }

    @Override
    public int deletebymid(Integer managerid) {
        return this.mMapper.deletebymid(managerid);
    }

    @Override
    public int freezebymid(Integer managerid) {
        Manager manager = this.mMapper.selectByPrimaryKey(managerid);
        if(manager.getmanagerpower()/10==2){
            return 1;
        }else{
            return this.mMapper.freezebymid(managerid);
        }
    }

    @Override
    public int nofreezebymid(Integer managerid) {
        Manager manager = this.mMapper.selectByPrimaryKey(managerid);
        if(manager.getmanagerpower()==0){
            return 1;
        }else {
            return this.mMapper.nofreezebymid(managerid);
        }
    }

    @Override
    public int agreecom(Integer comid,Integer managerid) {
        Complaint complaint=this.complaintMapper.selectByPrimaryKey(comid);
        int r=this.mMapper.freezebymid(complaint.getManagerid2());
        return this.complaintMapper.agreecom(comid,managerid);
    }

    @Override
    public int disagreecom(Integer comid,Integer managerid) {
        return this.complaintMapper.disagreecom(comid,managerid);
    }

    @Override
    public List getmycom(Integer managerid) {
        return this.complaintMapper.getmycom(managerid);
    }

    @Override
    public List getalluser() {
        return this.userMapper.getalluser();
    }

    @Override
    public int freezebyuserid(Integer userid) {
        return this.userMapper.freezebyuserid(userid);
    }

    @Override
    public int nofreezebyuserid(Integer userid) {
        return this.userMapper.nofreezebyuserid(userid);
    }

    @Override
    public List getuserbyid(Integer userid) {
        return this.userMapper.getuserbyid(userid);
    }

    @Override
    public List getuserbyname(String username) {
        return this.userMapper.getuserbyname(username);
    }

    @Override
    public List getuserbytele(String usertele) {
        return this.userMapper.getuserbytele(usertele);
    }

    @Override
    public int addhouse(House house) {
        return this.houseMapper.insertSelective(house);
    }

    @Override
    public List myaddhouse(Integer mid) {
        return this.houseMapper.myaddhouse(mid);
    }

    @Override
    public Integer deletehbyid(Integer hid) {
        return this.houseMapper.deletehbyid(hid);
    }

    @Override
    public House gethbyid(Integer hid) {
        return this.houseMapper.selectByPrimaryKey(hid);
    }

    @Override
    public Integer nodeletehbyid(Integer hid) {
        return this.houseMapper.nodeletehbyid(hid);
    }

    @Override
    public int updatehbyid(House house) {
        return this.houseMapper.updateByPrimaryKeySelective(house);
    }

    @Override
    public int addhousepicture(Integer hid, String path) {
        Picture picture=new Picture();picture.setPid(0);
        picture.setHouseid(hid);picture.setPath(path);
        return this.pictureMapper.insertSelective(picture);
    }

    @Override
    public Integer getnewesthouse(Integer mid) {
        return this.houseMapper.getnewesthouse(mid);
    }

    @Override
    public List selectbyhid(Integer hid) {
        return this.pictureMapper.selectbyhid(hid);
    }


    @Override
    public List getallhelp(Integer mid) {
        return this.helpMapper.getallhelp(mid);
    }

    @Override
    public Integer deletep(Integer pid) {
        return this.pictureMapper.deletep(pid);
    }

    @Override
    public Integer queorder(Integer id) {
        return this.orderMapper.queorder(id);
    }


    private ManagerModel convertFromDataobject(Manager user, Password password){
        if(user==null){
            return null;
        }
        ManagerModel mModel=new ManagerModel();
        BeanUtils.copyProperties(user,mModel);
        if(password==null){
            mModel.setOnepassword(null);
        }else {
            mModel.setOnepassword(password.getOnepassword());
        }
        return mModel;
    }
}

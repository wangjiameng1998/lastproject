package com.springboot.service.Impl;

import com.springboot.dao.*;
import com.springboot.dataObject.*;
import com.springboot.service.Model.UserModel;
import com.springboot.service.UserService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.PrivateKey;
import java.util.Date;
import java.util.List;

/**
 * Created by  on 2019/4/16 0016.
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    protected Date date;

    @Autowired
    private PasswordMapper passwordMapper;
    @Autowired
    private HouseMapper houseMapper;
    @Autowired
    private HouselikeMapper houselikeMapper;
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private ManagerMapper mMapper;
    @Autowired
    private HelpMapper helpMapper;
    @Autowired
    private ComplaintMapper complaintMapper;
    @Override
    public List selectallh() {
        return this.houseMapper.selectallh();
    }

    @Override
    public List indexsearch(String address,Integer arealow,Integer areatop, Integer priceup) {
        System.out.println("search");
        return this.houseMapper.indexsearch1(address,arealow,areatop,priceup);
    }

    @Override
    public Integer addlike(Integer uid, Integer hid) {
        Houselike houselike=new Houselike();
        houselike.setHouseid(hid);houselike.setHouseliker(uid);Date date=new Date();
        houselike.setField(date);
        Integer integer = houselikeMapper.insertSelective(houselike);
        Integer r2=houseMapper.updatelike(hid);
        return r2;
    }

    @Override
    public Houselike selectbyuidhid(Integer uid, Integer hid) {
        return this.houselikeMapper.selectbyuidhid(uid,hid);
    }

    @Override
    public List indexsearch3(Integer select,String address, Integer arealow, Integer areatop, Integer agelow, Integer agetop, Integer bedlow, Integer bedtop) {
        if(select==20){
            return this.houseMapper.indexsearchbynew(address,arealow,areatop,agelow,agetop,bedlow,bedtop);
        }
        else if(select==21){
            return this.houseMapper.indexsearchbylike(address,arealow,areatop,agelow,agetop,bedlow,bedtop);
        }else if(select==22){
            return this.houseMapper.indexsearchbyprice(address,arealow,areatop,agelow,agetop,bedlow,bedtop);
        }else{
            return this.houseMapper.indexsearchbynew(address,arealow,areatop,agelow,agetop,bedlow,bedtop);
        }

    }

    @Override
    public House gethousebyid(Integer hid) {
        return this.houseMapper.selectByPrimaryKey(hid);
    }

    @Override
    public Integer insertorder(Order order) {

        return this.orderMapper.insertSelective(order);
    }

    @Override
    public Integer updatehousestate(Integer hid) {
        return this.houseMapper.uphstate(hid);
    }

    @Override
    public House single(Integer hid) {
        return this.houseMapper.selectByPrimaryKey(hid);
    }

    @Override
    public Manager getmbyid(Integer mid) {
        return this.mMapper.selectByPrimaryKey(mid);
    }

    @Override
    public List listallhousebylike() {
        return this.houseMapper.listallhousebylike();
    }
    @Override
    public UserModel getUserById(Integer id){
        User user=userMapper.selectByPrimaryKey(id);
        if(user==null){
            return null;
        }
        Password password=passwordMapper.getpassword(id,0);

        return convertFromDataobject(user,password);
    }

    @Override
    public Integer uhuifu(Help help) {
        return this.helpMapper.insertSelective(help);
    }

    @Override
    public List myorder(Integer uid) {
        return this.orderMapper.listuserorder(uid);
    }

    @Override
    public List mylike(Integer uid) {
        return this.houselikeMapper.selectbyuid(uid);
    }

    @Override
    public List mymsg(Integer uid) {
        return this.helpMapper.getuserhelp(uid);
    }

    @Override
    public List mycom(Integer uid) {
        return this.complaintMapper.usercom(uid);
    }

    @Override
    public Integer deleteorder(Integer id) {
       Order order=this.orderMapper.selectByPrimaryKey(id);
        Integer  integer=this.houseMapper.uphstateok(order.getHouseid());
        return this.orderMapper.deleteorder(id);
    }

    @Override
    public Integer userupdate(User user) {
        return this.userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public Integer okorder(Integer id) {
        return this.orderMapper.okorder(id);
    }

    @Override
    public List userhelpm(Integer uid) {
        return this.helpMapper.getuserhelp(uid);
    }

    @Override
    public Integer addcom(Complaint complaint) {
        return this.complaintMapper.insertSelective(complaint);
    }

    @Override
    public Integer cancelcom(Integer cid) {
        return this.complaintMapper.cancelcom(cid);
    }

    @Override
    public Complaint getcomto(Integer uid, Integer mid) {
        return this.complaintMapper.getcomto(uid,mid);
    }

    @Override
    public Integer deletelike(Integer id) {
        Houselike houselike=this.houselikeMapper.selectByPrimaryKey(id);
        House house=this.houseMapper.selectByPrimaryKey(houselike.getHouseid());
        if(house.getHouselike()>0){
            Integer integer=this.houseMapper.deletelike(house.getHouseid());
        }
        return this.houselikeMapper.deletelike(id);
    }

    @Override
    public Integer moneyorder(Integer id) {
        Integer integer = this.houseMapper.sellout(id);
        return this.orderMapper.moneyorder(id);
    }

    @Override
    public UserModel getUserByTele(String tele) {
        User user=userMapper.selectByTele(tele);
        if(user==null){
            return null;
        }
        Password password=passwordMapper.getpassword(user.getUserid(),0);
        return convertFromDataobject(user,password);
    }

    @Override/*用户注册*/
    public UserModel userRegister(String tele, String password) {
        User user=new User();
        user.setUsertele(tele);
        int result=userMapper.insertSelective(user);
        if(result==0){
            return null;
        }
        else{
            int userid=userMapper.selectByTele(tele).getUserid();
            Password password1=new Password();
            password1.setOneid(userid);
            password1.setOnepower(0);
            password1.setOnepassword(password);
            date=new Date();
            password1.setOnetime(date);
            int result1=passwordMapper.insertSelective(password1);
            if(result1==0){
                return null;
            }
            return convertFromDataobject(userMapper.selectByTele(tele),password1);
        }
    }

    private UserModel convertFromDataobject(User user, Password password){
        if(user==null){
            return null;
        }
        UserModel userModel=new UserModel();
        BeanUtils.copyProperties(user,userModel);
        if(password==null){
            userModel.setOnepassword(null);
        }else {
            userModel.setOnepassword(password.getOnepassword());
        }
        return userModel;
    }
}

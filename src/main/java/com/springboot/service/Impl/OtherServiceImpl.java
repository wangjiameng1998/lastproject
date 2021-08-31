package com.springboot.service.Impl;

import com.springboot.dao.*;
import com.springboot.dataObject.Help;
import com.springboot.dataObject.Manager;
import com.springboot.dataObject.Notice;
import com.springboot.dataObject.Password;
import com.springboot.service.OtherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by  on 2019/4/25 0025.
 */
@Service
public class OtherServiceImpl implements OtherService {
    @Autowired
    private NoticeMapper noticeMapper;
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private HouseMapper houseMapper;
    @Autowired
    private ManagerMapper managerMapper;
    @Autowired
    private PasswordMapper passwordMapper;
    @Autowired
    private HelpMapper helpMapper;
    @Override
    public List listallnews() {
        return noticeMapper.listallnews();
    }

    @Override
    public int updatep(Integer oneid, Integer onepower, String onepassword) {
        return this.passwordMapper.updatep(oneid,onepower,onepassword);
    }
    @Override
    public Integer huifu(Help help) {
        return this.helpMapper.insertSelective(help);
    }

    @Override
    public List gethelp(Integer mid, Integer uid) {
        return this.helpMapper.gethelp(mid,uid);
    }

    @Override
    public List listallorder() {
        return orderMapper.listallorder();
    }

    @Override
    public List listallcontent(String content) {
        return this.noticeMapper.listallcontent(content);
    }

    @Override
    public List listallnewsby(Integer field2) {
        return this.noticeMapper.listallnewsby(field2);
    }

    @Override
    public List listallbycontent(Integer field2, String content) {
        return this.noticeMapper.listallbycontent(field2,content);
    }

    @Override
    public Notice getbyid(Integer id) {
        return this.noticeMapper.selectByPrimaryKey(id);
    }

    @Override
    public int deletenbyid(Integer id) {
        return this.noticeMapper.deletenbyid(id);
    }

    @Override
    public int addnews(Notice notice) {
        return this.noticeMapper.insertSelective(notice);
    }

    @Override
    public List listallorderby(Integer select) {
        if(select==0){
            return this.orderMapper.listallorder();
        }
        else if(select==1){
            return this.orderMapper.listorderok();
        }
        else{
            return this.orderMapper.listorderon();
        }
    }

    @Override
    public List listallorderm(Integer select, Integer m) {
        if(select==0){
            return this.orderMapper.listallorderm(m);
        }
        else if(select==1){
            return this.orderMapper.listorderokm(m);
        }
        else{
            return this.orderMapper.listorderonm(m);
        }
    }

    @Override
    public Manager getmbyhid(Integer hid) {
        return this.managerMapper.selectByPrimaryKey(houseMapper.selectByPrimaryKey(hid).getHouseowner());
    }
}

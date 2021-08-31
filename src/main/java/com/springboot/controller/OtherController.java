package com.springboot.controller;

import com.springboot.controller.viewobject.ManagerVO;
import com.springboot.dataObject.Manager;
import com.springboot.dataObject.Notice;
import com.springboot.service.OtherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by  on 2019/4/25 0025.
 */
@Controller("other")
@RequestMapping("/")
@CrossOrigin
public class OtherController {

    @Autowired
    private OtherService otherService;

    @Autowired
    private HttpServletRequest request;

    private Date date;

    /**
     * 查看订单
     * */
    @RequestMapping(value="/searchorders",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>searchorders(HttpServletRequest request,@RequestParam(value="select")int select,@RequestParam(value="content")String content){
        List list;Map<String,String> map = new HashMap<String, String>();
        if(content==null||content==""){
                list=otherService.listallorderby(select);
        }
        else{
            int c = Integer.parseInt(content);
                list=otherService.listallorderm(select,c);
        }
        request.getSession().setAttribute("orders",list);
        if(list.size()==0){
            map.put("result","0");
            return map;
        }
        else{
            map.put("result","1");
            return map;
        }
    }

    /**
     *home公告
     * */
    @RequestMapping(value="/getallnews",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> getallnews(@RequestParam(value = "manager")Integer managerid){

        List list=otherService.listallnews();
        List list1=otherService.listallorder();
        request.getSession().setAttribute("order",list1);
        request.getSession().setAttribute("notice",list);
        List list2=otherService.listallnewsby(1);
        request.getSession().setAttribute("question",list2);
        Map<String,String> map = new HashMap<String, String>();
        if(list.size()==0){
            map.put("result","无公告");
            return map;
        }
        else{
            map.put("result","有公告");
            return map;
        }
    }

    /**
     * 查看公告
     * */
    @RequestMapping(value="/search",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>searchnews(HttpServletRequest request,@RequestParam(value="select")int select,@RequestParam(value="content")String content){
       List list;Map<String,String> map = new HashMap<String, String>();
       if(content==null||content==""){
           if(select==0){
               list=otherService.listallnews();
           }
           else{
               list=otherService.listallnewsby(select);
           }
      }
       else{
           if(select==0){
               list=otherService.listallcontent(content);
           }
           else{
               list=otherService.listallbycontent(select-1,content);
           }

       }
        request.getSession().setAttribute("result",list);
        if(list.size()==0){
            map.put("result","0");
            return map;
        }
        else{
            map.put("result","1");
            return map;
        }
    }
    /**
     * 查看公告详情
     * */
    @RequestMapping(value="/getbyid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>getbyid(HttpServletRequest request,@RequestParam(value="id")int id){
        Map<String,String> map = new HashMap<String, String>();
        Notice notice=new Notice();
        if(id==0){
            notice=null;
        }
        else{
            notice=otherService.getbyid(id);
        }
        request.getSession().setAttribute("noticeid",notice);
        if(notice==null){
            map.put("result","0");
            return map;
        }
        else{
            map.put("result","1");
            return map;
        }
    }
    /**
     * 删除公告
     * */
    @RequestMapping(value="/deletenbyid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>deletenbyid(HttpServletRequest request,@RequestParam(value="id")int id){
        Map<String,String> map = new HashMap<String, String>();
        int r=otherService.deletenbyid(id);
       List list=otherService.listallnews();request.getSession().setAttribute("result",list);
        if(r==0){
            map.put("result","0");
            return map;
        }
        else{
            map.put("result","1");
            return map;
        }
    }
/**
 * 添加公告
 * */
    @RequestMapping(value="/addnews",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>addnews(HttpServletRequest request,@RequestParam(value="addselect")Integer select,@RequestParam(value="addtitle")String title,@RequestParam(value="addcontent")String content){
        Map<String,String> map = new HashMap<String, String>();
        Notice notice=new Notice();
        notice.setNoticetitle(title);notice.setField2(select-1);notice.setNoticecontent(content);date=new Date();notice.setNoticetime(date);
        ManagerVO managerVO=(ManagerVO) request.getSession().getAttribute("manager");
        if(managerVO==null){
            map.put("result","2");
            return map;
        }else{
        notice.setNoticemanager(managerVO.getManagerid());
        int r=otherService.addnews(notice);
        if(r==0){
            map.put("result","0");
            return map;
        }
        else{
            map.put("result","1");
            return map;
        }
    }  }
    /**
     * 得到房子上传的管理员
     * */
    @RequestMapping(value="/getmbyhid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> getmbyhid(HttpServletRequest request,@RequestParam(value = "id")Integer managerid){
        Manager manager=otherService.getmbyhid(managerid);
        Map<String,String> map = new HashMap<String, String>();
        if(manager==null){
            map.put("result","0");
            return map;
        }
        else{
            request.getSession().setAttribute("getlowmanager",manager);
            map.put("result","1");
            return map;
        }
    }
}

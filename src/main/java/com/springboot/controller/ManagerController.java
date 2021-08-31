package com.springboot.controller;

import com.springboot.controller.viewobject.ManagerVO;
import com.springboot.controller.viewobject.UserVO;
import com.springboot.dataObject.*;
import com.springboot.errorReturn.BusinessException;
import com.springboot.service.ManagerService;
import com.springboot.service.Model.ManagerModel;
import com.springboot.service.Model.UserModel;
import com.springboot.service.OtherService;
import com.springboot.service.UserService;
import javafx.application.Application;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.servlet.http.HttpServletRequest;
import java.security.SecureRandom;
import java.util.*;

import static com.springboot.controller.UserController.decryptBasedDes;
import static com.springboot.controller.UserController.encryptBasedDes;

/**
 * Created by  on 2019/4/16 0016.
 */
/*@Controller*/
@Controller("manager")
@RequestMapping("/")
@CrossOrigin
public class ManagerController extends baseController{

    @Autowired
    private ManagerService mService;
    @Autowired
    private OtherService otherService;
    protected String o=null;
    private Date date;

    @RequestMapping("agentindex")
    public String agentindex(HttpServletRequest request){
        List list=mService.listallcom();        List list0=otherService.listallnews();request.getSession().setAttribute("notice",list0);
        List list1=otherService.listallorder();
        List m=mService.listlowmanager();     List list2=otherService.listallnewsby(1);
        request.getSession().setAttribute("complaint",list);
        request.getSession().setAttribute("lowmanager",m);
        request.getSession().setAttribute("order",list1);
        request.getSession().setAttribute("question",list2);
        return "manager/agentindex";
    }

    @RequestMapping("mindex")
    public String mindex(HttpServletRequest request){
        List list=mService.listallcom();        List list0=otherService.listallnews();request.getSession().setAttribute("notice",list0);
        List list1=otherService.listallorder();
        List m=mService.listlowmanager();     List list2=otherService.listallnewsby(1);
        request.getSession().setAttribute("complaint",list);
        request.getSession().setAttribute("lowmanager",m);
        request.getSession().setAttribute("order",list1);
        request.getSession().setAttribute("question",list2);
        return "manager/mindex";
    }

    /**
     * 管理员登录时
     * */
    @RequestMapping(value = "/managerget",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> Managerlogin(HttpServletRequest request,@RequestParam(name="managerid")int managerid,@RequestParam(name="mpassword")String mpassword) throws BusinessException {
        Map<String,String> map = new HashMap<String, String>();
        ManagerModel managerModel=mService.getByMid(managerid);
        List list=mService.listallcom();
        List list0=otherService.listallnews();
        request.getSession().setAttribute("notice",list0);
        List list1=otherService.listallorder();
        List m=mService.listlowmanager();     List list2=otherService.listallnewsby(1);
        request.getSession().setAttribute("complaint",list);
        request.getSession().setAttribute("lowmanager",m);
        request.getSession().setAttribute("order",list1);
        request.getSession().setAttribute("question",list2);
        /*若获取的用户信息不存在*/
        if(managerModel==null){
            map.put("result","登录失败，没有此账号！");
            return map;
        }
        else if(!mpassword.equals(decryptBasedDes(managerModel.getOnepassword()))){
            map.put("result","登录失败，密码错误！");
            return map;
        }

      else  if(managerModel.getManagerpower()==0){
            System.out.println("员工号为"+managerid+"的管理员登录成功！");
            ManagerVO mVO=convertFromModel(managerModel);
            request.getSession().setAttribute("manager",mVO);
            map.put("result","低级管理员登录成功");
            return map;
        }
        else if(managerModel.getManagerpower()==1){
            System.out.println("员工号为"+managerid+"的管理员登录成功！");
            ManagerVO mVO=convertFromModel(managerModel);
            request.getSession().setAttribute("manager",mVO);
            map.put("result","高级管理员登录成功");
            return map;
        }
        else{
            map.put("result","账号异常，登录失败！");
            return map;
        }

    }

    /**
     * 管理员修改密码时
     * */
    @RequestMapping(value = "/updatemanager",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> updatemanager(HttpServletRequest request,@RequestParam(name="pass")String pass,@RequestParam(name="pass2")String pass2) throws BusinessException {
        Map<String,String> map = new HashMap<String, String>();
        ManagerVO managerVO=(ManagerVO) request.getSession().getAttribute("manager");
        ManagerModel managerModel=mService.getByMid(managerVO.getManagerid());
        /*若获取的用户信息不存在*/
        if(managerVO==null){
            map.put("result","2");
            return map;
        }
        else{
                if(!pass.equals(decryptBasedDes(managerModel.getOnepassword()))){
                    map.put("result","密码错误！");
                    return map;
                }
                else{
                    int r=otherService.updatep(managerModel.getManagerid(),1,encryptBasedDes(pass2));
                    map.put("result","1");
                    return map;
                }
        }
    }
    /**
     * 管理员注册时
     * */
    @RequestMapping(value = "/addmanager",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> addmanager(HttpServletRequest request,@RequestParam(name="mpass")String mpass,@RequestParam(name="mselect")Integer mselect,@RequestParam(name="msex")String msex,@RequestParam(name="mname")String mname) throws BusinessException {
        Map<String,String> map = new HashMap<String, String>();
        ManagerVO managerVO=(ManagerVO) request.getSession().getAttribute("manager");
        if(managerVO==null){
            map.put("result","2");
            return map;
        }
        else{
            Manager manager=new Manager();
            manager.setManagername(mname);manager.setmanagerpower(mselect);manager.setManagersex(msex);
            int r=mService.addmanager(manager,encryptBasedDes(mpass));
            if(r==1){
                map.put("result","1");
                return map;
            }
            else{
                map.put("result","未知错误，添加管理员失败");
                return map;
            }
        }
    }

    /**
     * 后端UserModel转换为用户可以显示在前端的UserVO
     * */
    private ManagerVO convertFromModel(ManagerModel mModel){
        if(mModel==null){
            return null;
        }
        ManagerVO mVO=new ManagerVO();
        BeanUtils.copyProperties(mModel,mVO);
        return mVO;
    }
    /**
     * 得到所有用户
     * */

    @RequestMapping(value="/getalluser",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>getalluser(HttpServletRequest request,@RequestParam(value = "id")String id){
        List list; Map<String,String> map = new HashMap<String, String>();
       list=mService.getalluser();
        request.getSession().setAttribute("userlist",list);
        map.put("result","1");
        return map;
    }

    /**
     * 得到所有低级管理员
     * */

    @RequestMapping(value="/searchm",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> searchm(HttpServletRequest request,@RequestParam(value = "content5")String content,@RequestParam(value = "select5")Integer select){
        List list; Map<String,String> map = new HashMap<String, String>();
        if(select==0 && content==""){
           list=mService.listlowmanager();
        }else if(select==1){
            if(content==null||content==""){
                map.put("result","请输入员工号");
                return map;
            }else{
                Integer mid=Integer.parseInt(content);
                list=mService.listlowmanagerbyid(mid);
            }

        }else{
            if(content==""||content==null){
                map.put("result","请输入员工姓名");
                return map;
            }else{
                list=mService.listlowmanagerbyname(content);
            }

        }
        request.getSession().setAttribute("lowmanager2",list);
            map.put("result","1");
            return map;
    }
    /**
     * 得到所有my投诉
     * */
    @RequestMapping(value="/getmycom",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> getmycom(HttpServletRequest request,@RequestParam(value = "manager")Integer managerid){
       ManagerVO managerVO=(ManagerVO) request.getSession().getAttribute("manager");
        List list=mService.getmycom(managerVO.getManagerid());
        Map<String,String> map = new HashMap<String, String>();
        if(list.size()==0){
            map.put("result","0");
            return map;
        }
        else{
            request.getSession().setAttribute("mycomplaint",list);
            map.put("result","11");
            return map;
        }
    }

    /**
     * 得到所有未处理投诉
     * */
    @RequestMapping(value="/getallcom",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> getallcom(HttpServletRequest request,@RequestParam(value = "manager")Integer managerid){
        List list=mService.listallcom();
        request.getSession().setAttribute("complaint",list);
        Map<String,String> map = new HashMap<String, String>();
        if(list.size()==0){
            map.put("result","无");
            return map;
        }
        else{
            map.put("result","有");
            return map;
        }
    }

    /**
     * 处理投诉no
     * */
    @RequestMapping(value="/disagreecom",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> disagreecom(HttpServletRequest request,@RequestParam(value = "id")Integer id){
        ManagerVO managerVO=(ManagerVO)request.getSession().getAttribute("manager");
        int r=mService.disagreecom(id,managerVO.getManagerid());
        Map<String,String> map = new HashMap<String, String>();
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
     * 处理投诉同意
     * */
    @RequestMapping(value="/agreecom",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> agreecom(HttpServletRequest request,@RequestParam(value = "id")Integer id){
        ManagerVO managerVO=(ManagerVO)request.getSession().getAttribute("manager");
        int r=mService.agreecom(id,managerVO.getManagerid());
        Map<String,String> map = new HashMap<String, String>();
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
     * 删除低级管理员
     * */
    @RequestMapping(value="/deletebymid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> deletebymid(HttpServletRequest request,@RequestParam(value = "id")Integer managerid){
        int r=mService.deletebymid(managerid);
        Map<String,String> map = new HashMap<String, String>();
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
     * 冻结低级管理员
     * */
    @RequestMapping(value="/freezebymid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> freezebymid(HttpServletRequest request,@RequestParam(value = "id")Integer managerid){
        int r=mService.freezebymid(managerid);
        Map<String,String> map = new HashMap<String, String>();
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
     * 解冻低级管理员
     * */
    @RequestMapping(value="/nofreezebymid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> nofreezebymid(HttpServletRequest request,@RequestParam(value = "id")Integer managerid){
        int r=mService.nofreezebymid(managerid);
        Map<String,String> map = new HashMap<String, String>();
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
     * 冻结用户
     * */
    @RequestMapping(value="/freezebyuserid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> freezebyuserid(HttpServletRequest request,@RequestParam(value = "id")Integer id){
        int r=mService.freezebyuserid(id);
        Map<String,String> map = new HashMap<String, String>();
        map.put("result","1");
        return map;
    }
    /**
     * 解冻冻结用户
     * */
    @RequestMapping(value="/nofreezebyuserid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> nofreezebyuserid(HttpServletRequest request,@RequestParam(value = "id")Integer id){
        int r=mService.nofreezebyuserid(id);
        Map<String,String> map = new HashMap<String, String>();
        map.put("result","1");
        return map;
    }

    /**
     * 查询用户
     * */

    @RequestMapping(value="/searchuser",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> searchuser(HttpServletRequest request,@RequestParam(value = "content")String content,@RequestParam(value = "select")Integer select){
        List list; Map<String,String> map = new HashMap<String, String>();
        if(select==0 && content==""){
            list=mService.getalluser();
        }else if(select==1){
            if(content==null||content==""){
                map.put("result","请输入员工号");
                return map;
            }else{
                Integer uid=Integer.parseInt(content);
                list=mService.getuserbyid(uid);
            }

        }else if(select==2){
            if(content==""||content==null){
                map.put("result","请输入员工姓名");
                return map;
            }else{
                list=mService.getuserbyname(content);
            }
        }else{
            if(content==""||content==null){
                map.put("result","请输入员工电话");
                return map;
            }else{
                list=mService.getuserbytele(content);
            }
        }
        request.getSession().setAttribute("userlist",list);
        map.put("result","1");
        return map;
    }
    /**
     * 得到用户
     * */

    @RequestMapping(value="/getuserbyid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>getuserbyid(HttpServletRequest request,@RequestParam(value="id")Integer id){
             User user; Map<String,String> map = new HashMap<String, String>();
             List list=mService.getuserbyid(id);
             user=(User)list.get(0);
             request.getSession().setAttribute("getuser",user);
             map.put("result","1");
             return map;
    }

    /**
     * 查看我的订单
     * */
    @RequestMapping(value="/getmyorder",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>getmyorder(HttpServletRequest request,@RequestParam(value="state")int state){
        List list;Map<String,String> map = new HashMap<String, String>();
        ManagerVO managerVO=(ManagerVO)request.getSession().getAttribute("manager");
       if(state==0){
            list=otherService.listallorderm(0,managerVO.getManagerid());
        }
      else if(state==1){
            list=otherService.listallorderm(1,managerVO.getManagerid());
        }else{
            list=otherService.listallorderm(2,managerVO.getManagerid());
        }
        request.getSession().setAttribute("myorder",list);
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
     * add house
     * */
    @RequestMapping(value="/addhouse",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>addhouse(HttpServletRequest request,@RequestParam(value="address")String address,@RequestParam("area")Integer area,@RequestParam("price")Integer price,
                                      @RequestParam("face")String face,@RequestParam("kicthens")Integer kicthen,@RequestParam("bedroom")Integer bedroom,@RequestParam("bathroom")Integer bathroom,
                                      @RequestParam("floor")Integer floor,@RequestParam("lift")Integer lift,@RequestParam("age")Integer age,@RequestParam("label")String label){
        House house=new House();ManagerVO managerVO=(ManagerVO) request.getSession().getAttribute("manager");
        house.setBathroom(bathroom);house.setBedroom(bedroom);house.setHouseaddress(address);
        house.setHouseage(age);house.setHousearea(area);house.setHouseface(face);house.setHousefloor(floor);
        house.setHouselift(lift);house.setHouseprice(price);house.setKichen(kicthen);house.setHouseuse(label);
        house.setHousestate(0);house.setHouselike(0);house.setHouseowner(managerVO.getManagerid());
         int r=mService.addhouse(house); System.out.println("integer="+r);
        Integer integer=mService.getnewesthouse(managerVO.getManagerid());
         request.getSession().setAttribute("houseid",integer);
         Map<String,String> map = new HashMap<String, String>();            map.put("result","1");
        return map;
    }

    /**
     * 得到我上传的房子
     * */

    @RequestMapping(value="/myaddhouse",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>myaddhouse(HttpServletRequest request,@RequestParam("id")Integer id){
        Map<String,String> map = new HashMap<String, String>();
        ManagerVO managerVO=(ManagerVO) request.getSession().getAttribute("manager");
        List list=mService.myaddhouse(managerVO.getManagerid());
        request.getSession().setAttribute("myaddhouse",list);
        map.put("result","1");
        return map;
    }
    /**
     * 得到房子byid
     * */

    @RequestMapping(value="/gethbyid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>gethbyid(HttpServletRequest request,@RequestParam("id")Integer id){
        Map<String,String> map = new HashMap<String, String>();
        House house=mService.gethbyid(id);
        request.getSession().setAttribute("onehouse",house);
        List list=mService.selectbyhid(id); request.getSession().setAttribute("housepicture",list);
        map.put("result","1");
        return map;
    }

    /**
     *房子 刷新
     * */
    @RequestMapping(value="/updateh",method ={RequestMethod.POST})
    @ResponseBody
    public Map<String,String> updateh(@RequestParam(value = "id")Integer id,HttpServletRequest request){
        Map<String,String> map = new HashMap<String, String>();
        House house=mService.gethbyid(id);
        request.getSession().setAttribute("onehouse",house);
        List list=mService.selectbyhid(id); request.getSession().setAttribute("housepicture",list);
        map.put("result","1");System.out.println(id);
        return map;
    }

    /**
     * 房子图片下架
     * */

    @RequestMapping(value="/deletep",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>deletep(HttpServletRequest request,@RequestParam("hid")Integer hid,@RequestParam("id")Integer id){
        Map<String,String> map = new HashMap<String, String>();
        int integer=mService.deletep(id);
        map.put("result","1");
        return map;
    }

    /**
     * 房子下架
     * */

    @RequestMapping(value="/deletehbyid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>deletehbyid(HttpServletRequest request,@RequestParam("id")Integer id){
        Map<String,String> map = new HashMap<String, String>();
        int integer=mService.deletehbyid(id);
        map.put("result","1");
        return map;
    }

    /**
     * 房子下架撤回
     * */

    @RequestMapping(value="/nodeletehbyid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>nodeletehbyid(HttpServletRequest request,@RequestParam("id")Integer id){
        Map<String,String> map = new HashMap<String, String>();
        int integer=mService.nodeletehbyid(id);
        map.put("result","1");
        return map;
    }
    /**
     * 房子修改信息
     * */

    @RequestMapping(value="/updatehbyid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>updatehbyid(HttpServletRequest request,@RequestParam("hid")Integer hid,@RequestParam(value="address")String address,@RequestParam("area")Integer area,@RequestParam("price")Integer price,
                                      @RequestParam("face")String face,@RequestParam("kicthens")Integer kicthen,@RequestParam("bedroom")Integer bedroom,@RequestParam("bathroom")Integer bathroom,
                                      @RequestParam("floor")Integer floor,@RequestParam("lift")Integer lift,@RequestParam("age")Integer age,@RequestParam("label")String label){
        House house=new House();
        house.setBathroom(bathroom);house.setBedroom(bedroom);house.setHouseaddress(address);
        house.setHouseage(age);house.setHousearea(area);house.setHouseface(face);house.setHousefloor(floor);
        house.setHouselift(lift);house.setHouseprice(price);house.setKichen(kicthen);house.setHouseuse(label);
        house.setHouseid(hid);
        int r=mService.updatehbyid(house);
        Map<String,String> map = new HashMap<String, String>();            map.put("result","1");
        return map;
    }

    /**
     * 得到历史用户消息
     * */

    @RequestMapping(value="/getallhelp",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>getallhelp(HttpServletRequest request,@RequestParam(value = "id")String id){
        ManagerVO managerVO=(ManagerVO)request.getSession().getAttribute("manager");
        List list; Map<String,String> map = new HashMap<String, String>();
        list=mService.getallhelp(managerVO.getManagerid());
        request.getSession().setAttribute("allhelp",list);
        map.put("result","1");
        return map;
    }

    /**
     * 得到one用户消息
     * */

    @RequestMapping(value="/help",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>help(HttpServletRequest request,@RequestParam(value = "id")Integer id){
        ManagerVO managerVO=(ManagerVO)request.getSession().getAttribute("manager");
        List list; Map<String,String> map = new HashMap<String, String>();
        list=otherService.gethelp(managerVO.getManagerid(),id);
        request.getSession().setAttribute("help",list);
        map.put("result","1");
        return map;
    }

    /**
     * 回复消息
     * */

    @RequestMapping(value="/huifu",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>huifu(HttpServletRequest request,@RequestParam(value = "id")Integer id,@RequestParam(value = "content")String content){
       Map<String,String> map = new HashMap<String, String>();
        ManagerVO managerVO=(ManagerVO)request.getSession().getAttribute("manager");
        date=new Date();
        Help help=new Help();help.setHelpmanager(managerVO.getManagerid());help.setHelpques(content);
        help.setHelptime(date);help.setHelpuser(id);help.setHelpsend(1);
       Integer i=otherService.huifu(help);
        map.put("result","1");
        return map;
    }
    /**
     * 回复消息hou刷新
     * */
    @RequestMapping(value="/reloadmhelp",method ={RequestMethod.POST})
    @ResponseBody
    public Map<String,String> reloadmhelp(@RequestParam(value = "id")Integer id,HttpServletRequest request){
        ManagerVO managerVO=(ManagerVO)request.getSession().getAttribute("manager");List list;
        list=otherService.gethelp(managerVO.getManagerid(),id);Map<String,String> map = new HashMap<String, String>();
        request.getSession().setAttribute("help",list);
        map.put("result","1");
        return map;
    }

    /**
     * 图片房子
     * */
    @RequestMapping(value="/myup",method ={RequestMethod.POST})
    @ResponseBody
    public Map<String,String> myup(@RequestParam(value = "id")Integer id,HttpServletRequest request){
        ManagerVO managerVO=(ManagerVO)request.getSession().getAttribute("manager");
        List list=(List)mService.selectbyhid(id);
        request.getSession().setAttribute("housepicture",list);Map<String,String> map = new HashMap<String, String>();
        map.put("result","1");
        return map;
    }

    /**
     * 最后确认售卖
     * */

    @RequestMapping(value="/quebyid",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>quebyid(HttpServletRequest request,@RequestParam(value = "id")Integer  id){
        Map<String,String> map = new HashMap<String, String>();
        Integer i=mService.queorder(id);
        map.put("result","1");
        return map;
    }


}

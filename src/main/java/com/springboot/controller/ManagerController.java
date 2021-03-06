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
     * ??????????????????
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
        /*?????????????????????????????????*/
        if(managerModel==null){
            map.put("result","?????????????????????????????????");
            return map;
        }
        else if(!mpassword.equals(decryptBasedDes(managerModel.getOnepassword()))){
            map.put("result","??????????????????????????????");
            return map;
        }

      else  if(managerModel.getManagerpower()==0){
            System.out.println("????????????"+managerid+"???????????????????????????");
            ManagerVO mVO=convertFromModel(managerModel);
            request.getSession().setAttribute("manager",mVO);
            map.put("result","???????????????????????????");
            return map;
        }
        else if(managerModel.getManagerpower()==1){
            System.out.println("????????????"+managerid+"???????????????????????????");
            ManagerVO mVO=convertFromModel(managerModel);
            request.getSession().setAttribute("manager",mVO);
            map.put("result","???????????????????????????");
            return map;
        }
        else{
            map.put("result","??????????????????????????????");
            return map;
        }

    }

    /**
     * ????????????????????????
     * */
    @RequestMapping(value = "/updatemanager",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> updatemanager(HttpServletRequest request,@RequestParam(name="pass")String pass,@RequestParam(name="pass2")String pass2) throws BusinessException {
        Map<String,String> map = new HashMap<String, String>();
        ManagerVO managerVO=(ManagerVO) request.getSession().getAttribute("manager");
        ManagerModel managerModel=mService.getByMid(managerVO.getManagerid());
        /*?????????????????????????????????*/
        if(managerVO==null){
            map.put("result","2");
            return map;
        }
        else{
                if(!pass.equals(decryptBasedDes(managerModel.getOnepassword()))){
                    map.put("result","???????????????");
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
     * ??????????????????
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
                map.put("result","????????????????????????????????????");
                return map;
            }
        }
    }

    /**
     * ??????UserModel???????????????????????????????????????UserVO
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
     * ??????????????????
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
     * ???????????????????????????
     * */

    @RequestMapping(value="/searchm",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> searchm(HttpServletRequest request,@RequestParam(value = "content5")String content,@RequestParam(value = "select5")Integer select){
        List list; Map<String,String> map = new HashMap<String, String>();
        if(select==0 && content==""){
           list=mService.listlowmanager();
        }else if(select==1){
            if(content==null||content==""){
                map.put("result","??????????????????");
                return map;
            }else{
                Integer mid=Integer.parseInt(content);
                list=mService.listlowmanagerbyid(mid);
            }

        }else{
            if(content==""||content==null){
                map.put("result","?????????????????????");
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
     * ????????????my??????
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
     * ???????????????????????????
     * */
    @RequestMapping(value="/getallcom",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> getallcom(HttpServletRequest request,@RequestParam(value = "manager")Integer managerid){
        List list=mService.listallcom();
        request.getSession().setAttribute("complaint",list);
        Map<String,String> map = new HashMap<String, String>();
        if(list.size()==0){
            map.put("result","???");
            return map;
        }
        else{
            map.put("result","???");
            return map;
        }
    }

    /**
     * ????????????no
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
     * ??????????????????
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
     * ?????????????????????
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
     * ?????????????????????
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
     * ?????????????????????
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
     * ????????????
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
     * ??????????????????
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
     * ????????????
     * */

    @RequestMapping(value="/searchuser",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> searchuser(HttpServletRequest request,@RequestParam(value = "content")String content,@RequestParam(value = "select")Integer select){
        List list; Map<String,String> map = new HashMap<String, String>();
        if(select==0 && content==""){
            list=mService.getalluser();
        }else if(select==1){
            if(content==null||content==""){
                map.put("result","??????????????????");
                return map;
            }else{
                Integer uid=Integer.parseInt(content);
                list=mService.getuserbyid(uid);
            }

        }else if(select==2){
            if(content==""||content==null){
                map.put("result","?????????????????????");
                return map;
            }else{
                list=mService.getuserbyname(content);
            }
        }else{
            if(content==""||content==null){
                map.put("result","?????????????????????");
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
     * ????????????
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
     * ??????????????????
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
     * ????????????????????????
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
     * ????????????byid
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
     *?????? ??????
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
     * ??????????????????
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
     * ????????????
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
     * ??????????????????
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
     * ??????????????????
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
     * ????????????????????????
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
     * ??????one????????????
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
     * ????????????
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
     * ????????????hou??????
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
     * ????????????
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
     * ??????????????????
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

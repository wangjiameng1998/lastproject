package com.springboot.controller;

import com.springboot.controller.viewobject.ManagerVO;
import com.springboot.controller.viewobject.UserVO;
import com.springboot.dataObject.*;
import com.springboot.errorReturn.BusinessException;
import com.springboot.errorReturn.EnBusinessError;
import com.springboot.response.CommonReturnType;
import com.springboot.service.Model.UserModel;
import com.springboot.service.OtherService;
import com.springboot.service.UserService;
import org.omg.PortableInterceptor.USER_EXCEPTION;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.util.*;

/**
 * Created by  on 2019/4/16 0016.
 */
/*@Controller*/
@Controller("user")
@RequestMapping("/")
@CrossOrigin
public class UserController extends baseController{

    @Autowired
    private UserService userService;
    @Autowired
    private OtherService oService;
    protected String o=null;
    private Date date;
    @Autowired
    private HttpServletRequest httpServletRequest;

    @RequestMapping("exit")
    public String exit(HttpServletRequest request){
        request.getSession().removeAttribute("user");//清空session信息
        request.getSession().invalidate();//清除 session 中的所有信息
        return "index";
    }

    /**
    * 用户进入首页时
    *
    * */
    @RequestMapping("index")
    public String index(HttpServletRequest request){
        List list=(List)userService.selectallh();
        request.getSession().setAttribute("allhouse",list);
        List list2=(List)userService.listallhousebylike();
        request.getSession().setAttribute("likehouse",list2);
        List list1=oService.listallnewsby(1);
        List listn=oService.listallnewsby(0);
        request.getSession().setAttribute("notice",listn);
        request.getSession().setAttribute("ques",list1);
        return "index";
    }

    /**
     * 用户注册时获取otp短信验证码接口
     * */
    @RequestMapping(value = "/usergetOtp")
    @ResponseBody
    public Map<String,String> getOtp(){
        Random random=new Random();
        int randomint=random.nextInt(99999);
        randomint+=100000;
        String otpCode=String.valueOf(randomint);
        /*验证码                                          session*/
        o=otpCode;
        /*发给用户*/
        System.out.println("otpCode="+otpCode);
        Map<String,String> map = new HashMap<String, String>();
        map.put("result",otpCode);
        return map;
    }

    /**
     * 用户重载页面
     * */
    @RequestMapping(value = "/reload")
    public String reload(HttpServletRequest request) throws BusinessException {
        UserVO userModel=(UserVO) request.getSession().getAttribute("user");
        List order=userService.myorder(userModel.getUserid());request.getSession().setAttribute("userorder",order);
        List h=new ArrayList();
        for(int i = 0;i<order.size();i++){
            Order order1=(Order)order.get(i);
            House house=userService.gethousebyid(order1.getHouseid());
            h.add(house);
        }request.getSession().setAttribute("userorderhouse",h);
        List like=userService.mylike(userModel.getUserid());request.getSession().setAttribute("userlike",like);
        List com=userService.mycom(userModel.getUserid());request.getSession().setAttribute("usercome",com);
        List msg=userService.userhelpm(userModel.getUserid());request.getSession().setAttribute("usermsg",msg);
        return "personal";
    }

    /**
     * 用户重载用户页面
     * */
    @RequestMapping(value = "/userreload")
    public String userreload(HttpServletRequest request) throws BusinessException {
        UserVO user=(UserVO) request.getSession().getAttribute("user");
        UserModel userModel=userService.getUserById(user.getUserid());
        UserVO userVO=convertFromModel(userModel);
        httpServletRequest.getSession().setAttribute("user",userVO);
        return "personal";
    }

    /**
     * 用户登录时
     * */
    @RequestMapping(value = "/userget",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> Userlogin(HttpServletRequest request,@RequestParam(name="user_tele")String telephone,@RequestParam(name="password")String password) throws BusinessException {
       UserModel userModel= userService.getUserByTele(telephone);
        /*若获取的用户信息不存在*/
        Map<String,String> map = new HashMap<String, String>();
        if(userModel==null){
            map.put("result","登录失败，没有此用户！");
            return map;
        }
        if(!password.equals(decryptBasedDes(userModel.getOnepassword()))){
            map.put("result","登录失败，用户手机号或密码错误！");
            return map;
        }
       List order=userService.myorder(userModel.getUserid());request.getSession().setAttribute("userorder",order);
       List h=new ArrayList();
       for(int i = 0;i<order.size();i++){
           Order order1=(Order)order.get(i);
           House house=userService.gethousebyid(order1.getHouseid());
           h.add(house);
       }request.getSession().setAttribute("userorderhouse",h);
       List like=userService.mylike(userModel.getUserid());request.getSession().setAttribute("userlike",like);
        List l=new ArrayList();
        for(int i = 0;i<like.size();i++){
            Houselike houselike=(Houselike) like.get(i);
            House house=userService.gethousebyid(houselike.getHouseid());
            l.add(house);  }request.getSession().setAttribute("userlikehouse",l);
       List com=userService.mycom(userModel.getUserid());request.getSession().setAttribute("usercome",com);
       List msg=userService.mymsg(userModel.getUserid());request.getSession().setAttribute("usermsg",msg);
        UserVO userVO=convertFromModel(userModel);
        httpServletRequest.getSession().setAttribute("user",userVO);
        List list=(List)userService.selectallh();
        request.getSession().setAttribute("allhouse",list);
        List list2=(List)userService.listallhousebylike();
        request.getSession().setAttribute("likehouse",list2);
        List list1=oService.listallnewsby(1);
        request.getSession().setAttribute("ques",list1);
        List listn=oService.listallnewsby(0);
        request.getSession().setAttribute("notice",listn);
        map.put("result","登录成功");
        System.out.println("手机用户手机号为"+java.net.URLDecoder.decode(telephone)+"的用户登录成功！");
        return map;

    }
    /**
     *用户注册时
     **/
    @RequestMapping(value ="/usertoregister",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody/*application/x-www-form-urlencoded*/
    public Map<String,String> Userregister(@RequestParam(name="telephone")String telephone,@RequestParam(name="r_password")String password,@RequestParam(name="r_password2")String password2,@RequestParam(name="check")String otpCode) throws BusinessException {
        UserModel user= userService.getUserByTele(telephone);
        Map<String,String> map = new HashMap<String, String>();
            if(telephone==null){
                map.put("result","手机号不能为空！");
                return map;
            }
        if(password==null){
            map.put("result","密码不能为空！");
            return map;
        }
        if(password2==null){
            map.put("result","确认密码不能为空！");
            return map;
        }
        if(otpCode==null){
            map.put("result","验证码不能为空！");
            return map;
        }
            if(!password.equals(password2)){
                map.put("result","两次输入密码不相同！");
                return map;
            }
             if(!otpCode.equals(o)){
                 map.put("result","验证码已失效！");
                return map;
            }
        if(user!=null){
            map.put("result","此账号已被注册！");
            return map;
        }
            UserModel userModel=userService.userRegister(telephone,encryptBasedDes(password));
             if(userModel==null){
                 map.put("result","注册失败");
                 return map;
             }

             UserVO userVO=convertFromModel(userModel);
             httpServletRequest.getSession().setAttribute("user",userVO);
            map.put("result","注册成功");
        System.out.println("手机用户手机号为"+java.net.URLDecoder.decode(telephone)+"的用户注册成功！");
             return map;
    }

    /**
     * 用户首页简易搜索商品时
     * */
    @RequestMapping(value = "/indexsearch",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> indexsearch(HttpServletRequest request,
                                          @RequestParam(name="address")String address,@RequestParam(name="area")Integer area,@RequestParam(name="priceup")Integer priceup) throws BusinessException {
        Integer price=priceup*10000/area;
        List list=(List)userService.indexsearch(address,area-15,area+15,price);
        request.getSession().setAttribute("indexsearch",list);
        Map<String,String> map = new HashMap<String, String>();
            map.put("result","1");
            return map;
    }


    /**
     * 用户首页关注商品时
     * */
    @RequestMapping(value = "/addlike",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> addlike(HttpServletRequest request,
                                          @RequestParam(name="uid")Integer uid,@RequestParam(name="hid")Integer hid) throws BusinessException {
        System.out.println(uid+","+hid);
        Houselike houselike=userService.selectbyuidhid(uid,hid);   Map<String,String> map = new HashMap<String, String>();
        if(houselike!=null){
            map.put("result","已关注此二手房");
            return map;
        }
        Integer integer = userService.addlike(uid,hid);
        map.put("result","1");
        return map;
    }


    /**
     * 房子信息search
     * */

    @RequestMapping(value="/searchh",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>searchh(HttpServletRequest request,@RequestParam("houseage")Integer houseage,@RequestParam(value="address")String address,@RequestParam("area")Integer area,@RequestParam("myage")Integer myage,
                                       @RequestParam("myarealow")Integer myarealow,@RequestParam("bedroom")Integer bedroom,@RequestParam("myareatop")Integer myareatop,
                                     @RequestParam("selectby")Integer selectby,@RequestParam("mybedroom")Integer mybedroom){
       Integer useagetop,useagelow;
            switch (houseage){
                case 12:useagelow=myage-5;useagetop=myage+5;break;
                case 13:useagelow=0;useagetop=1;break;
                case 14:useagelow=1;useagetop=5;break;
                case 15:useagelow=5;useagetop=10;break;
                case (16):useagelow=10;useagetop=20;break;
                case 17:useagelow=20;useagetop=100;break;
                    default:useagelow=0;useagetop=100;break;
            }
        Integer useareatop,usearealow;
            switch (area){
                case 0:  useareatop=myareatop;usearealow=myareatop;break;
                case 1:useareatop=50;usearealow=0;break;
                case 2:useareatop=100;usearealow=50;break;
                case 3:useareatop=150;usearealow=100;break;
                case 4:useareatop=200;usearealow=150;break;
                case 5:useareatop=10000;usearealow=200;break;
                    default:useareatop=10000;usearealow=0;break;
            }
        Integer usebedroomlow,usebedroomtop;
            switch (bedroom){
                case 11:usebedroomlow=mybedroom;usebedroomtop=mybedroom;break;
                case 6:usebedroomlow=1;usebedroomtop=1;break;
                case 7:usebedroomlow=2;usebedroomtop=2;break;
                case 8:usebedroomlow=3;usebedroomtop=3;break;
                case 9:usebedroomlow=4;usebedroomtop=4;break;
                case 10:usebedroomlow=5;usebedroomtop=1000;break;
                    default:usebedroomlow=0;usebedroomtop=1000;break;
            }
            List list=userService.indexsearch3(selectby,address,usearealow,useareatop,useagelow,useagetop,usebedroomlow,usebedroomtop);
           request.getSession().setAttribute("indexsearch",list);
            Map<String,String> map = new HashMap<String, String>();            map.put("result","1");
        return map;
    }



    /**
     * 用户buy商品时
     * */
    @RequestMapping(value = "/addorder",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> addorder(HttpServletRequest request,
                                      @RequestParam(name="uid")Integer uid,@RequestParam(name="hid")Integer hid) throws BusinessException {
        System.out.println(uid+","+hid);
        Map<String,String> map = new HashMap<String, String>();
       House house=userService.gethousebyid(hid);
       if(house.getHousestate()!=0){
           map.put("result","此房屋已下架，订单出现错误。");return map;
       }else{
           Order order=new Order();order.setOrderstate(1);order.setHousebuyer(uid);order.setHouseid(hid);
           date=new Date();order.setOrdertime(date);
           List myorder=userService.myorder(uid);request.getSession().setAttribute("userorder",myorder);
           List h=new ArrayList();
           for(int i = 0;i<myorder.size();i++){
               Order order1=(Order)myorder.get(i);
               House myhouse=userService.gethousebyid(order1.getHouseid());
               h.add(myhouse);
           }request.getSession().setAttribute("userorderhouse",h);
           Integer integer = userService.insertorder(order);
            Integer integer1=userService.updatehousestate(hid);
           map.put("result","1");
           return map;
       }
    }


    /**
     * 商品详情
     * */
    @RequestMapping(value = "/housesingle",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> housesingle(HttpServletRequest request,@RequestParam(name="hid")Integer hid) throws BusinessException {
       House house=userService.single(hid);
        Manager manager=userService.getmbyid(house.getHouseowner());
        request.getSession().setAttribute("housesingle",house);
        request.getSession().setAttribute("housem",manager);
        Map<String,String> map = new HashMap<String, String>();
        map.put("result","1");
        return map;
    }

    /**
     * 回复消息
     * */

    @RequestMapping(value="/sendmsg",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>sendmsg(HttpServletRequest request,@RequestParam(value = "mid")Integer mid,@RequestParam(value = "uid")Integer uid,@RequestParam(value = "content")String content){
        Map<String,String> map = new HashMap<String, String>();
        date=new Date();
        Help help=new Help();help.setHelpmanager(mid);help.setHelpques(content);
        help.setHelptime(date);help.setHelpuser(uid);help.setHelpsend(0);
        Integer i=userService.uhuifu(help);
        map.put("result","1");
        return map;
    }

    /**
     * 删除订单
     * */
    @RequestMapping(value = "/deleteorder",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> deleteorder(HttpServletRequest request,@RequestParam(name="id")Integer id) throws BusinessException {
       Integer integer=userService.deleteorder(id);
        Map<String,String> map = new HashMap<String, String>();
        map.put("result","1");
        return map;
    }

    /**
     * 确认订单
     * */
    @RequestMapping(value = "/buy",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> buy(HttpServletRequest request,@RequestParam(name="id")Integer id) throws BusinessException {
        Integer integer=userService.okorder(id);
        Map<String,String> map = new HashMap<String, String>();
        map.put("result","1");
        return map;
    }

    /**
     * 付款
     * */
    @RequestMapping(value = "/moneyorder",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> moneyorder(HttpServletRequest request,@RequestParam(name="id")Integer id) throws BusinessException {
        Integer integer=userService.moneyorder(id);
        Map<String,String> map = new HashMap<String, String>();
        map.put("result","1");
        return map;
    }


    /**
     * 个人信息更改
     * */
    @RequestMapping(value = "/userupdate",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> userupdate(HttpServletRequest request,@RequestParam(name="id")Integer id,@RequestParam(name="sex")String sex,
                                         @RequestParam(name="address")String address,@RequestParam(name="name")String name,@RequestParam(name="tele")String tele,@RequestParam(name="mail")String mail) throws BusinessException {
        User user=new User();user.setUsertele(tele);user.setUserid(id);
        user.setUsermail(mail);user.setUsername(name);user.setUseraddress(address);user.setUsersex(sex);
        Integer integer=userService.userupdate(user);
        Map<String,String> map = new HashMap<String, String>();
        map.put("result","1");
        return map;
    }


    /**
     * 修改密码时
     * */
    @RequestMapping(value = "/userchangepass",method ={RequestMethod.POST},consumes = {"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String> userchangepass(HttpServletRequest request,@RequestParam(name="pass")String pass,@RequestParam(name="pass2")String pass2) throws BusinessException {
        Map<String,String> map = new HashMap<String, String>();
        UserVO userVO=(UserVO)request.getSession().getAttribute("user");
        UserModel userModel=userService.getUserById(userVO.getUserid());
        /*若获取的用户信息不存在*/
        if(userVO==null){
            map.put("result","2");
            return map;
        }
        else{
            if(!pass.equals(decryptBasedDes(userModel.getOnepassword()))){
                map.put("result","密码错误！");
                return map;
            }
            else{
                int r=oService.updatep(userModel.getUserid(),0,encryptBasedDes(pass2));
                map.put("result","1");
                return map;
            }
        }
    }

    /**
     * 得到one用户消息
     * */

    @RequestMapping(value="/userhelp",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>userhelp(HttpServletRequest request,@RequestParam(value = "id")Integer id){
        UserVO userVO=(UserVO)request.getSession().getAttribute("user");
        List list; Map<String,String> map = new HashMap<String, String>();
        list=oService.gethelp(id,userVO.getUserid());
        request.getSession().setAttribute("userhelp",list);
        map.put("result","1");
        return map;
    }
    /**
     * 得到用户所有消息
     * */
    @RequestMapping(value="/mymsg",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>mymsg(HttpServletRequest request,@RequestParam(value = "id")Integer id){
        UserVO userVO=(UserVO)request.getSession().getAttribute("user");
        List list; Map<String,String> map = new HashMap<String, String>();
        list=userService.mymsg(userVO.getUserid());
        request.getSession().setAttribute("usermsg",list);
        map.put("result","1");
        return map;
    }

    /**
     * 得到用户所有complaint
     * */
    @RequestMapping(value="/mycom",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>mycom(HttpServletRequest request,@RequestParam(value = "id")Integer id){
        UserVO userVO=(UserVO)request.getSession().getAttribute("user");
        List list; Map<String,String> map = new HashMap<String, String>();
        list=userService.mycom(userVO.getUserid());
        request.getSession().setAttribute("usercom",list);
        map.put("result","1");
        return map;
    }

    /**
     * fasong消息
     * */

    @RequestMapping(value="/userhuifu",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>userhuifu(HttpServletRequest request,@RequestParam(value = "id")Integer id,@RequestParam(value = "content")String content){
        Map<String,String> map = new HashMap<String, String>();
        UserVO userVO=(UserVO)request.getSession().getAttribute("user");
        date=new Date();
        Help help=new Help();help.setHelpmanager(id);help.setHelpques(content);
        help.setHelptime(date);help.setHelpuser(userVO.getUserid());help.setHelpsend(0);
        Integer i=oService.huifu(help);
        map.put("result","1");
        return map;
    }

    /**
     *刷新消息
     * */
    @RequestMapping(value="/reloadhelp",method ={RequestMethod.POST})
    @ResponseBody
    public Map<String,String> reloadhelp(@RequestParam(value = "id")Integer id,HttpServletRequest request){
        UserVO userVO=(UserVO)request.getSession().getAttribute("user");List list;
        list=oService.gethelp(id,userVO.getUserid());Map<String,String> map = new HashMap<String, String>();
        request.getSession().setAttribute("userhelp",list);
        map.put("result","1");
        return map;
    }
    /**
     * 投诉
     * */
    @RequestMapping(value="/addcom",method ={RequestMethod.POST})
    @ResponseBody
    public Map<String,String> addcom(@RequestParam(value = "id")Integer id,@RequestParam(value = "content")String content,HttpServletRequest request){
        UserVO userVO=(UserVO)request.getSession().getAttribute("user");List list;Map<String,String> map = new HashMap<String, String>();
        Complaint com=userService.getcomto(userVO.getUserid(),id);
        if(com==null){
            date=new Date();
            Complaint complaint=new Complaint();complaint.setComreason(content);
            complaint.setComstate(0);complaint.setComtime(date);complaint.setUserid1(userVO.getUserid());complaint.setManagerid2(id);
            Integer integer =userService.addcom(complaint);
            list=userService.mycom(userVO.getUserid());
            request.getSession().setAttribute("usercom",list);
            map.put("result","1");
            return map;
        } else{
            map.put("result","已对此管理员进行了投诉");
            return map;
        }

    }

    /**
     * 撤销投诉
     * */
    @RequestMapping(value="/cancelcom",method ={RequestMethod.POST})
    @ResponseBody
    public Map<String,String> cancelcom(@RequestParam(value = "id")Integer id,HttpServletRequest request){
        UserVO userVO=(UserVO)request.getSession().getAttribute("user");List list;date=new Date();
        Integer integer =userService.cancelcom(id);Map<String,String> map = new HashMap<String, String>();
        list=userService.mycom(userVO.getUserid());
        request.getSession().setAttribute("usercom",list);
        map.put("result","1");
        return map;
    }

    /**
     * 撤销关注
     * */
    @RequestMapping(value="/deletelike",method ={RequestMethod.POST})
    @ResponseBody
    public Map<String,String> deletelike(@RequestParam(value = "id")Integer id,HttpServletRequest request){
        Integer integer=userService.deletelike(id);UserVO userVO=(UserVO)request.getSession().getAttribute("user");
        List list=userService.mylike(userVO.getUserid());
        request.getSession().setAttribute("userlike",list);
        List l=new ArrayList();
        for(int i = 0;i<list.size();i++){
            Houselike houselike=(Houselike) list.get(i);
            House house=userService.gethousebyid(houselike.getHouseid());
            l.add(house);  }request.getSession().setAttribute("userlikehouse",l);
        Map<String,String> map = new HashMap<String, String>();
        map.put("result","1");
        return map;
    }


    /**
     * 得到用户所有关注
     * */
    @RequestMapping(value="/mylike",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>mylike(HttpServletRequest request,@RequestParam(value = "id")Integer id){
        UserVO userVO=(UserVO)request.getSession().getAttribute("user");
        List list; Map<String,String> map = new HashMap<String, String>();
        list=userService.mylike(userVO.getUserid());
        request.getSession().setAttribute("userlike",list);
        List l=new ArrayList();
        for(int i = 0;i<list.size();i++){
            Houselike houselike=(Houselike) list.get(i);
            House house=userService.gethousebyid(houselike.getHouseid());
            l.add(house);  }request.getSession().setAttribute("userlikehouse",l);
        map.put("result","1");
        return map;
    }


    /**
     * 得到newsingle
     * */
    @RequestMapping(value="/newsingle",method ={RequestMethod.POST},consumes={"application/x-www-form-urlencoded"})
    @ResponseBody
    public Map<String,String>newsingle(HttpServletRequest request,@RequestParam(value = "id")Integer id){
        List list; Map<String,String> map = new HashMap<String, String>();
        Notice notice=oService.getbyid(id);
        request.getSession().setAttribute("noticeid",notice);
        map.put("result","1");
        return map;
    }




    /**
     * 后端UserModel转换为用户可以显示在前端的UserVO
     * */
    private UserVO convertFromModel(UserModel userModel){
        if(userModel==null){
            return null;
        }
        UserVO userVO=new UserVO();
        BeanUtils.copyProperties(userModel,userVO);
        return userVO;
    }

    /**
     *  EDS的加密解密代码
     */
    private static final byte[] DES_KEY = { 21, 1, -110, 82, -32, -85, -128, -65 };
    @SuppressWarnings("restriction")
    public static String encryptBasedDes(String data) {
        String encryptedData = null;
        try {
            // DES算法要求有一个可信任的随机数源
            SecureRandom sr = new SecureRandom();
            DESKeySpec deskey = new DESKeySpec(DES_KEY);
            // 创建一个密匙工厂，然后用它把DESKeySpec转换成一个SecretKey对象
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            SecretKey key = keyFactory.generateSecret(deskey);
            // 加密对象
            Cipher cipher = Cipher.getInstance("DES");
            cipher.init(Cipher.ENCRYPT_MODE, key, sr);
            // 加密，并把字节数组编码成字符串
            encryptedData = new sun.misc.BASE64Encoder().encode(cipher.doFinal(data.getBytes()));
        } catch (Exception e) {
            // log.error("加密错误，错误信息：", e);
            throw new RuntimeException("加密错误，错误信息：", e);
        }
        return encryptedData;
    }
    @SuppressWarnings("restriction")
    public static String decryptBasedDes(String cryptData) {
        String decryptedData = null;
        try {
            // DES算法要求有一个可信任的随机数源
            SecureRandom sr = new SecureRandom();
            DESKeySpec deskey = new DESKeySpec(DES_KEY);
            // 创建一个密匙工厂，然后用它把DESKeySpec转换成一个SecretKey对象
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            SecretKey key = keyFactory.generateSecret(deskey);
            // 解密对象
            Cipher cipher = Cipher.getInstance("DES");
            cipher.init(Cipher.DECRYPT_MODE, key, sr);
            // 把字符串进行解码，解码为为字节数组，并解密
            decryptedData = new String(cipher.doFinal(new sun.misc.BASE64Decoder().decodeBuffer(cryptData)));
        } catch (Exception e) {
            throw new RuntimeException("解密错误，错误信息：", e);
        }
        return decryptedData;
    }
    /**EDS的加密解密代码*/
}

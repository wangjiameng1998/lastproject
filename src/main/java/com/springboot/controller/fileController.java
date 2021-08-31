package com.springboot.controller;

import com.springboot.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by  on 2019/5/6 0006.
 */
@Controller
@RequestMapping("/")
@CrossOrigin
public class fileController {
    private String FILE_DIR="D://workspace/lastproject/src/main/resources/static/img/upload";


    @Autowired
    private ManagerService mService;
    @PostMapping("/uploadFile")
    String singleFileUpload(HttpServletRequest request,@RequestParam("file") MultipartFile file){
        //判断文件是否为空
        if(file.isEmpty()){ return "manager/errorempty"; }
        try{//获得文件的字节流
            byte[] bytes=file.getBytes();
            Integer houseid=(Integer)request.getSession().getAttribute("houseid");
            //获得path对象，也即是文件保存的路径对象
            String fll=FILE_DIR+"/"+houseid+"/";File f=new File(fll);
            //如果文件夹不存在则创建
            if  (!f .exists()  && !f .isDirectory()) { f .mkdir(); }
            Path path= Paths.get(fll+file.getOriginalFilename());
            String path1=String.valueOf(file.getOriginalFilename());path1=houseid+"/"+path1;
            //调用静态方法完成将文件写入到目标路径
            Files.write(path,bytes);  int r=mService.addhousepicture(houseid,path1);
            List list=(List)mService.selectbyhid(houseid);
            request.getSession().setAttribute("addpicture",list);
            return "manager/success";
        }catch (IOException e){
            e.printStackTrace();
        }
        return "manager/errorup";
    }
    @RequestMapping(value="/download",method = RequestMethod.GET)
    public void download( HttpServletResponse response){
        //要上传的文件名字
        String fileName="com.seven.xuanshang.apk";
        //通过文件的保存文件夹路径加上文件的名字来获得文件
        File file=new File(FILE_DIR,fileName);
        //当文件存在
        if(file.exists()){
            //首先设置响应的内容格式是force-download，那么你一旦点击下载按钮就会自动下载文件了
            response.setContentType("application/force-download");
            //通过设置头信息给文件命名，也即是，在前端，文件流被接受完还原成原文件的时候会以你传递的文件名来命名
            response.addHeader("Content-Disposition",String.format("attachment; filename=\"%s\"", file.getName()));
            //进行读写操作
            byte[]buffer=new byte[1024];
            FileInputStream fis=null;
            BufferedInputStream bis=null;
            try{
                fis=new FileInputStream(file);
                bis=new BufferedInputStream(fis);
                OutputStream os=response.getOutputStream();
                //从源文件中读
                int i=bis.read(buffer);
                while(i!=-1){
                    //写到response的输出流中
                    os.write(buffer,0,i);
                    i=bis.read(buffer);
                }
            }catch (IOException e){
                e.printStackTrace();
            }finally {
                //善后工作，关闭各种流
                try {
                    if(bis!=null){
                        bis.close();
                    }
                    if(fis!=null){
                        fis.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
    }

}
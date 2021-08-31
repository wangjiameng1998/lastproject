package com.springboot.service.Model;

/**
 * Created by  on 2019/4/16 0016.
 */
public class UserModel {
    private Integer userid;

    private String username;

    private String usertele;

    private String usersex;

    private String userhead;

    private String useraddress;

    private String usermail;

    private Integer userpower;

    private String field1;

    private String field2;

 private String onepassword;

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsertele() {
        return usertele;
    }

    public void setUsertele(String usertele) {
        this.usertele = usertele;
    }

    public String getUsersex() {
        return usersex;
    }

    public void setUsersex(String usersex) {
        this.usersex = usersex;
    }

    public String getUserhead() {
        return userhead;
    }

    public void setUserhead(String userhead) {
        this.userhead = userhead;
    }

    public String getUseraddress() {
        return useraddress;
    }

    public void setUseraddress(String useraddress) {
        this.useraddress = useraddress;
    }

    public String getUsermail() {
        return usermail;
    }

    public void setUsermail(String usermail) {
        this.usermail = usermail;
    }

    public Integer getUserpower() {
        return userpower;
    }

    public void setUserpower(Integer userpower) {
        this.userpower = userpower;
    }

    public String getField1() {
        return field1;
    }

    public void setField1(String field1) {
        this.field1 = field1;
    }

    public String getField2() {
        return field2;
    }

    public void setField2(String field2) {
        this.field2 = field2;
    }

    public String getOnepassword() {
        return onepassword;
    }

    public void setOnepassword(String onepassword) {
        this.onepassword = onepassword;
    }

    @Override
    public String toString() {
        return "UserModel{" +
                "userid=" + userid +
                ", username='" + username + '\'' +
                ", usertele='" + usertele + '\'' +
                ", usersex='" + usersex + '\'' +
                ", userhead='" + userhead + '\'' +
                ", useraddress='" + useraddress + '\'' +
                ", usermail='" + usermail + '\'' +
                ", userpower=" + userpower +
                ", onepassword='" + onepassword + '\'' +
                '}';
    }
}

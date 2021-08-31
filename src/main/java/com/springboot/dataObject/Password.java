package com.springboot.dataObject;

import java.util.Date;

public class Password {
    private Integer pid;

    private Integer oneid;

    private Integer onepower;

    private String onepassword;

    private Date onetime;

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getOneid() {
        return oneid;
    }

    public void setOneid(Integer oneid) {
        this.oneid = oneid;
    }

    public Integer getOnepower() {
        return onepower;
    }

    public void setOnepower(Integer onepower) {
        this.onepower = onepower;
    }

    public String getOnepassword() {
        return onepassword;
    }

    public void setOnepassword(String onepassword) {
        this.onepassword = onepassword == null ? null : onepassword.trim();
    }

    public Date getOnetime() {
        return onetime;
    }

    public void setOnetime(Date onetime) {
        this.onetime = onetime;
    }
}
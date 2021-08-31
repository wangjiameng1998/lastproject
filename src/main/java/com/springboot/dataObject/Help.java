package com.springboot.dataObject;

import java.util.Date;

public class Help {
    private Integer helpid;

    private Integer helpuser;

    private Integer helpmanager;

    private String helpques;

    private Date helptime;

    private Integer helpsend;

    public Integer getHelpid() {
        return helpid;
    }

    public void setHelpid(Integer helpid) {
        this.helpid = helpid;
    }

    public Integer getHelpuser() {
        return helpuser;
    }

    public void setHelpuser(Integer helpuser) {
        this.helpuser = helpuser;
    }

    public Integer getHelpmanager() {
        return helpmanager;
    }

    public void setHelpmanager(Integer helpmanager) {
        this.helpmanager = helpmanager;
    }

    public String getHelpques() {
        return helpques;
    }

    public void setHelpques(String helpques) {
        this.helpques = helpques == null ? null : helpques.trim();
    }

    public Date getHelptime() {
        return helptime;
    }

    public void setHelptime(Date helptime) {
        this.helptime = helptime;
    }

    public Integer getHelpsend() {
        return helpsend;
    }

    public void setHelpsend(Integer helpsend) {
        this.helpsend = helpsend;
    }
}
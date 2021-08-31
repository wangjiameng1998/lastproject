package com.springboot.dataObject;

import java.util.Date;

public class Complaint {
    private Integer comid;

    private Integer userid1;

    private Integer managerid2;

    private String comreason;

    private Integer comstate;

    private Integer managerid;

    private Date comtime;

    public Integer getComid() {
        return comid;
    }

    public void setComid(Integer comid) {
        this.comid = comid;
    }

    public Integer getUserid1() {
        return userid1;
    }

    public void setUserid1(Integer userid1) {
        this.userid1 = userid1;
    }

    public Integer getManagerid2() {
        return managerid2;
    }

    public void setManagerid2(Integer managerid2) {
        this.managerid2 = managerid2;
    }

    public String getComreason() {
        return comreason;
    }

    public void setComreason(String comreason) {
        this.comreason = comreason == null ? null : comreason.trim();
    }

    public Integer getComstate() {
        return comstate;
    }

    public void setComstate(Integer comstate) {
        this.comstate = comstate;
    }

    public Integer getManagerid() {
        return managerid;
    }

    public void setManagerid(Integer managerid) {
        this.managerid = managerid;
    }

    public Date getComtime() {
        return comtime;
    }

    public void setComtime(Date comtime) {
        this.comtime = comtime;
    }
}
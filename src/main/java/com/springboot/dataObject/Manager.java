package com.springboot.dataObject;

public class Manager {
    private Integer managerid;

    private String managersex;

    private String managername;

    private  Integer managerpower;

    public Integer getManagerid() {
        return managerid;
    }

    public void setManagerid(Integer managerid) {
        this.managerid = managerid;
    }

    public String getManagersex() {
        return managersex;
    }

    public void setManagersex(String managersex) {
        this.managersex = managersex == null ? null : managersex.trim();
    }

    public String getManagername() {
        return managername;
    }

    public void setManagername(String managername) {
        this.managername = managername == null ? null : managername.trim();
    }

    public  Integer getmanagerpower() {
        return managerpower;
    }

    public void setmanagerpower( Integer managerpower) {
        this.managerpower = managerpower;
    }
}
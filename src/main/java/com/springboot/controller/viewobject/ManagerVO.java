package com.springboot.controller.viewobject;

/**
 * Created by  on 2019/4/23 0023.
 */
public class ManagerVO {
    public Integer getManagerpower() {
        return managerpower;
    }

    public void setManagerpower(Integer managerpower) {
        this.managerpower = managerpower;
    }

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
        this.managersex = managersex;
    }

    public String getManagername() {
        return managername;
    }

    public void setManagername(String managername) {
        this.managername = managername;
    }

    private Integer managerid;

    private String managersex;

    private String managername;

    private Integer managerpower;
}

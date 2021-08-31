package com.springboot.service.Model;

/**
 * Created by  on 2019/4/23 0023.
 */
public class ManagerModel {
    private Integer managerid;

    private String managersex;

    private String managername;

    private String onepassword;

    private Integer managerpower;
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

    public String getOnepassword() {
        return onepassword;
    }

    public void setOnepassword(String onepassword) {
        this.onepassword = onepassword;
    }


    public Integer getManagerpower() {
        return managerpower;
    }

    public void setManagerpower(Integer managerpower) {
        this.managerpower = managerpower;
    }

    @Override
    public String toString() {
        return "ManagerModel{" +
                "managerid=" + managerid +
                ", managersex='" + managersex + '\'' +
                ", managername='" + managername + '\'' +
                ", onepassword='" + onepassword + '\'' +
                ", managerpower=" + managerpower +
                '}';
    }
}

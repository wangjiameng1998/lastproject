package com.springboot.dataObject;

public class House {
    private Integer houseid;

    private String houseaddress;

    private Integer housearea;

    private Integer houseprice;

    private String houseface;

    private Integer houselift;

    private Integer housefloor;

    private Integer houseage;

    private String houseuse;

    private Integer housestate;

    private Integer houselike;

    private Integer houseowner;

    private Integer kichen;

    private Integer bedroom;

    private Integer bathroom;

    public Integer getHouseid() {
        return houseid;
    }

    public void setHouseid(Integer houseid) {
        this.houseid = houseid;
    }

    public String getHouseaddress() {
        return houseaddress;
    }

    public void setHouseaddress(String houseaddress) {
        this.houseaddress = houseaddress == null ? null : houseaddress.trim();
    }

    public Integer getHousearea() {
        return housearea;
    }

    public void setHousearea(Integer housearea) {
        this.housearea = housearea;
    }

    public Integer getHouseprice() {
        return houseprice;
    }

    public void setHouseprice(Integer houseprice) {
        this.houseprice = houseprice;
    }

    public String getHouseface() {
        return houseface;
    }

    public void setHouseface(String houseface) {
        this.houseface = houseface == null ? null : houseface.trim();
    }

    public Integer getHouselift() {
        return houselift;
    }

    public void setHouselift(Integer houselift) {
        this.houselift = houselift;
    }

    public Integer getHousefloor() {
        return housefloor;
    }

    public void setHousefloor(Integer housefloor) {
        this.housefloor = housefloor;
    }

    public Integer getHouseage() {
        return houseage;
    }

    public void setHouseage(Integer houseage) {
        this.houseage = houseage;
    }

    public String getHouseuse() {
        return houseuse;
    }

    public void setHouseuse(String houseuse) {
        this.houseuse = houseuse == null ? null : houseuse.trim();
    }

    public Integer getHousestate() {
        return housestate;
    }

    public void setHousestate(Integer housestate) {
        this.housestate = housestate;
    }

    public Integer getHouselike() {
        return houselike;
    }

    public void setHouselike(Integer houselike) {
        this.houselike = houselike;
    }

    public Integer getHouseowner() {
        return houseowner;
    }

    public void setHouseowner(Integer houseowner) {
        this.houseowner = houseowner;
    }

    public Integer getKichen() {
        return kichen;
    }

    public void setKichen(Integer kichen) {
        this.kichen = kichen;
    }


    public Integer getBathroom() {
        return bathroom;
    }

    public void setBathroom(Integer bathroom) {
        this.bathroom = bathroom;
    }

    public Integer getBedroom() {
        return bedroom;
    }

    public void setBedroom(Integer bedroom) {
        this.bedroom = bedroom;
    }
}
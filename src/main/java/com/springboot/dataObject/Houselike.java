package com.springboot.dataObject;

import java.util.Date;

public class Houselike {
    private Integer houselikeid;

    private Date field;

    private Integer houseliker;

    private Integer houseid;

    private Integer state;

    public Integer getHouselikeid() {
        return houselikeid;
    }

    public void setHouselikeid(Integer houselikeid) {
        this.houselikeid = houselikeid;
    }

    public Date getField() {
        return field;
    }

    public void setField(Date field) {
        this.field = field;
    }

    public Integer getHouseliker() {
        return houseliker;
    }

    public void setHouseliker(Integer houseliker) {
        this.houseliker = houseliker;
    }

    public Integer getHouseid() {
        return houseid;
    }

    public void setHouseid(Integer houseid) {
        this.houseid = houseid;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }
}
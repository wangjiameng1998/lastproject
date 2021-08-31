package com.springboot.dataObject;

import java.util.Date;

public class Notice {
    private Integer noticeid;

    private Date noticetime;

    private String noticecontent;

    private Integer noticemanager;

    private Integer field2;

    private String noticetitle;

    public Integer getNoticeid() {
        return noticeid;
    }

    public void setNoticeid(Integer noticeid) {
        this.noticeid = noticeid;
    }

    public Date getNoticetime() {
        return noticetime;
    }

    public void setNoticetime(Date noticetime) {
        this.noticetime = noticetime;
    }

    public String getNoticecontent() {
        return noticecontent;
    }

    public void setNoticecontent(String noticecontent) {
        this.noticecontent = noticecontent == null ? null : noticecontent.trim();
    }

    public Integer getNoticemanager() {
        return noticemanager;
    }

    public void setNoticemanager(Integer noticemanager) {
        this.noticemanager = noticemanager;
    }



    public String getNoticetitle() {
        return noticetitle;
    }

    public void setNoticetitle(String noticetitle) {
        this.noticetitle = noticetitle == null ? null : noticetitle.trim();
    }

    @Override
    public String toString() {
        return "Notice{" +
                "noticeid=" + noticeid +
                ", noticetime=" + noticetime +
                ", noticecontent='" + noticecontent + '\'' +
                ", noticemanager=" + noticemanager +
                ", noticetitle='" + noticetitle + '\'' +
                '}';
    }

    public Integer getField2() {
        return field2;
    }

    public void setField2(Integer field2) {
        this.field2 = field2;
    }
}
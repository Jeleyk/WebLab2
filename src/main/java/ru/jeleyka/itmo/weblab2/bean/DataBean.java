package ru.jeleyka.itmo.weblab2.bean;

import lombok.Getter;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Getter
public class DataBean implements Serializable {
    List<RequestBean> data = new ArrayList<>();
}

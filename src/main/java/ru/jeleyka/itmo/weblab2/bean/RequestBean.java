package ru.jeleyka.itmo.weblab2.bean;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@NoArgsConstructor
@AllArgsConstructor
@Getter
public class RequestBean implements Serializable {
    int num;
    double x, y, r;
    boolean inZone;
    long time;
    double execTime;
}
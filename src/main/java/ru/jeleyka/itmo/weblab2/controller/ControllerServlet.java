package ru.jeleyka.itmo.weblab2.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.Map;

@WebServlet(name = "controller", value = "")
public class ControllerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, String[]> parameters = request.getParameterMap();
        if (
                parameters.containsKey("x") &&
                parameters.containsKey("y") &&
                parameters.containsKey("r")
        ) {
            getServletContext().getNamedDispatcher("areaCheck").forward(request, response);
        } else {
            getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }

}
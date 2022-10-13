package ru.jeleyka.itmo.weblab2.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ru.jeleyka.itmo.weblab2.bean.DataBean;
import ru.jeleyka.itmo.weblab2.bean.RequestBean;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet(name = "areaCheck")
public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        long startTime = System.nanoTime();
        double x, y, r;
        try {
            x = getDouble("x", request);
            y = getDouble("y", request);
            r = getDouble("r", request);
        } catch (NumberFormatException exception) {
            response.setStatus(400);
            response.setContentType("text/html;charset=utf-8");
            response.getWriter().print("Неверные входные данные");
            return;
        }
        double execTime = (System.nanoTime() - startTime) / 1000D;
        long time = System.currentTimeMillis();
        if (request.getSession().getAttribute("data") == null) {
            request.getSession().setAttribute("data", new DataBean());
        }
        DataBean data = (DataBean) request.getSession().getAttribute("data");
        RequestBean requestBean = new RequestBean(data.getData().size() + 1, x, y, r, isInZone(x, y, r), time, execTime);
        data.getData().add(requestBean);

        response.getWriter().printf("<tr>" + "<td>%s</td>".repeat(7) + "</tr>",
                requestBean.getNum(), requestBean.getX(), requestBean.getY(), requestBean.getR(), requestBean.isInZone() ? "+" : "-", new Timestamp(requestBean.getTime()), requestBean.getExecTime());
    }

    private double getDouble(String name, HttpServletRequest request) {
        return Double.parseDouble(request.getParameter(name));
    }

    private boolean isInZone(double x, double y, double r) {
        return
                (x >= 0 && y >= 0 && y <= r && x <= r / 2) ||
                        (x <= 0 && y <= 0 && y >= -x - r) ||
                        (x <= 0 && y >= 0 && y * y + x * x <= r * r);
    }
}

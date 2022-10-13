<%@ page import="ru.jeleyka.itmo.weblab2.bean.RequestBean" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page %>
<jsp:useBean id="data" class="ru.jeleyka.itmo.weblab2.bean.DataBean" scope="session"/>
<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>Lab 2</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="script/client.js"></script>
    <link rel="stylesheet" href="style/style.css">
</head>
<body>
<table id="content">
    <tr class="header">
        <th colspan="3">Долгих Александр P32092 Вариант №1805</th>
    </tr>
    <tr>
        <td width="30%">
            <svg height="300" width="300" xmlns="http://www.w3.org/2000/svg">

                <line stroke="black" x1="0" x2="300" y1="150" y2="150"></line>
                <line stroke="black" x1="150" x2="150" y1="0" y2="300"></line>
                <polygon fill="black" points="150,0 144,15 156,15" stroke="white"></polygon>
                <polygon fill="black" points="300,150 285,156 285,144" stroke="white"></polygon>

                <line stroke="black" x1="200" x2="200" y1="155" y2="145"></line>
                <line stroke="black" x1="250" x2="250" y1="155" y2="145"></line>

                <line stroke="black" x1="50" x2="50" y1="155" y2="145"></line>
                <line stroke="black" x1="100" x2="100" y1="155" y2="145"></line>

                <line stroke="black" x1="145" x2="155" y1="100" y2="100"></line>
                <line stroke="black" x1="145" x2="155" y1="50" y2="50"></line>

                <line stroke="black" x1="145" x2="155" y1="200" y2="200"></line>
                <line stroke="black" x1="145" x2="155" y1="250" y2="250"></line>

                <text fill="black" x="195" y="140">R/2</text>
                <text fill="black" x="248" y="140">R</text>

                <text fill="black" x="40" y="140">-R</text>
                <text fill="black" x="90" y="140">-R/2</text>

                <text fill="black" x="160" y="105">R/2</text>
                <text fill="black" x="160" y="55">R</text>

                <text fill="black" x="160" y="205">-R/2</text>
                <text fill="black" x="160" y="255">-R</text>

                <text fill="black" x="160" y="10">Y</text>
                <text fill="black" x="290" y="140">X</text>

                <polygon fill="blue" fill-opacity="0.3" points="150,250 150,150 50,150" stroke="blue"></polygon>

                <polygon fill="blue" fill-opacity="0.3" points="200,150 200,50 150,50 150,150" stroke="blue"></polygon>

                <path d="M 50 150 A 100 100 0 0 1 150 50 L 150 150 Z" fill="blue" fill-opacity="0.3"
                      stroke="blue"></path>
            </svg>
        </td>
        <td width="40%"></td>
        <td width="30%">
            <form id="form">
                <label>
                    Выберите X:
                    <select name="x" id="x">
                        <%
                            for (double i = -2; i <= 2; i += 0.5) {
                                out.println("<option value=\"" + i + "\">" + i + "</option>");
                            }
                        %>
                    </select>
                </label>
                <br>

                <label>
                    Введите Y:
                    <input autocomplete="off" maxlength="4" type="text" name="y" size="19"
                           placeholder="От -5 до 3" id="y">
                </label>
                <br>

                <label>
                    Выберите R:
                </label>
                <%
                    for (int i = 1; i <= 5; ++i) {
                        out.print("<input type=\"checkbox\" name=\"r\" value=\"" + i + "\"" + (i == 1 ? "checked" : "") + ">" + i);
                    }
                %>
                <br>


                <input type="submit" value='Отправить'/>

                <div id="error"></div>

            </form>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <table id="data" cellspacing="0" cellpadding="0">
                <tr>
                    <th>№</th>
                    <th>X</th>
                    <th>Y</th>
                    <th>R</th>
                    <th>Попадение в зону</th>
                    <th>Время запроса</th>
                    <th>Время исполнения запроса, мкс</th>
                </tr>
                <%
                    for (RequestBean bean : data.getData()) {
                        out.print(String.format("<tr>" + "<td>%s</td>".repeat(7) + "</tr>",
                                bean.getNum(), bean.getX(), bean.getY(), bean.getR(), bean.isInZone() ? "+" : "-", new Timestamp(bean.getTime()), bean.getExecTime()));
                    }
                %>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
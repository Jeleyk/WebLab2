let errorField
let svg

function validateY(tag, min, max) {
    let errorNotification = null
    if (tag.value) {
        const n = parseFloat(tag.value.replace(',', '.'))
        if (isNaN(n) || !isFinite(n)) {
            errorNotification = 'Укажите число'
        } else if (n > max || n < min) {
            errorNotification = 'Укажите число в пределах от ' + min + ' до ' + max
        }
    } else {
        errorNotification = 'Поле не может быть пустым'
    }

    if (errorNotification != null) {
        errorField.html(errorNotification)
        return false
    }
    errorField.html("")
    return true
}

function validateR() {
    let count = $('input[name="r"]:checked').length
    if (count === 1) {
        errorField.html("")
        return true
    }
    if (count === 0)
        errorField.html('Выберите радиус')
    else
        errorField.html('Выберите один радиус')
}

function getCurrentRadius() {
    let checked = $('input[name="r"]:checked');
    if (checked.length !== 1) return -1
    return checked.val();

}

function validateForm() {
    if (!validateY(document.getElementById("y"), -5, 3))
        return false
    return validateR()
}

function drawPoint(row, num, r = getCurrentRadius()) {
    if (r === -1) {
        return
    }
    let x = row.cells[1].innerHTML
    let y = row.cells[2].innerHTML

    let xPixel = 150 + 100 * x / r;
    let yPixel = 150 - 100 * y / r;

    if (xPixel < 0 || xPixel >= 300 || yPixel < 0 || yPixel >= 300)
        return

    let dot = document.createElementNS("http://www.w3.org/2000/svg", 'circle');
    dot.setAttribute('id', 'dot_' + num)
    dot.setAttribute('cx', xPixel.toString())
    dot.setAttribute('cy', yPixel.toString())
    dot.setAttribute('r', '3')
    dot.setAttribute('stroke', 'black')
    dot.setAttribute('fill', 'black')
    svg.appendChild(dot)
}

function reloadGraph() {
    $("circle").remove()
    let table = document.getElementById("data");
    let r = getCurrentRadius()
    for (let i = 1; i < table.rows.length; i++) {
        drawPoint(table.rows[i], i, r)
    }
}

function sendRequest(data = "") {
    $.ajax({
        url: '/WebLab2',
        method: "GET",
        data: data,
        dataType: "html",
        statusCode: {
            200: function (data) {
                $('#data').append(data)

                let table = document.getElementById("data");
                drawPoint(table.rows[table.rows.length - 1], table.rows.length - 1)
            },
            400: function (xhr) {
                $("#error").html(xhr.responseText)
            },
        }
    })
}

$(document).ready(function () {
    /*$.ajax({
        url: '/WebLab2',
        method: "POST",
        data: 'timezone=' + new Date().getTimezoneOffset(),
        dataType: "html",
        success: function(){
            sendRequest();
        },
    })*/

    errorField = $("#error")
    svg = document.querySelector("svg")

    reloadGraph()

    $("#form").on("submit", function () {
        if (!validateForm())
            return false

        sendRequest($(this).serialize())
        return false
    })

    $("input[type=checkbox]").change(() => {
        reloadGraph()
    })

    $('svg').on('click', e => {
        if (!validateR()) return
        let r = getCurrentRadius()
        let x = e.clientX - svg.getBoundingClientRect().left
        x = (x - 150) * r / 100
        let y = e.clientY - svg.getBoundingClientRect().top
        y = (150 - y) * r / 100
        sendRequest(`x=${x}&y=${y}&r=${r}`)
    })

    let table = $('#data');

    table.on("mouseenter", "tr", function () {
        let data = parseInt($(this).find('td:first').text());
        if (isNaN(data) || !isFinite(data)) return
        $(this).toggleClass("hover")
        $('#dot_' + data).attr('style', "fill:red;stroke:red;")
    })

    table.on("mouseleave", "tr", function () {
        let data = parseInt($(this).find('td:first').text());
        if (isNaN(data) || !isFinite(data)) return
        $(this).toggleClass("hover")
        $('#dot_' + data).attr('style', "fill:black;stroke:black;")
    })


})
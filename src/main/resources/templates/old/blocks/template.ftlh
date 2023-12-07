<#macro template user,page>
    <!doctype html>
    <html lang="ru">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="/static/css/style.css">
        <link rel="stylesheet" href="/static/css/${page}.css">
        <meta name="_csrf" content="${_csrf.token}">
        <meta name="_csrf_header" content="${_csrf.headerName}">


        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
              integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn"
              crossorigin="anonymous">
        <!-- Подключение Dropzone CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.css" rel="stylesheet">

        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">


        <!-- Подключение Dropzone JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.js"></script>


        <title>BookStore</title>
    </head>
    <body>
    <nav class="navbar navbar-expand-lg" style="border-color: pink; background-color: pink; color: black">
        <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
            <a class="navbar-brand" style="color: black" href="/">BookStore</a>
            <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                <li class="nav-item active">
                    <a class="nav-link" style="color: black" href="/">Главная <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" style="color: black" href="/articles">Новинки</a>
                </li>
                <#if user.email??>
                    <li class="nav-item">
                        <a class="nav-link" style="color: black" href="/favorites">Избранное</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" style="color: black" href="/cart">Корзина</a>
                    </li>
                <#else>
                    <li class="nav-item">
                        <a class="nav-link disabled" style="color: black" href="/favorites">Избранное</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled" style="color: black" href="/cart">Корзина</a>
                    </li>
                </#if>
            </ul>
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Поиск" aria-label="Поиск">
                <button class="btn my-2 my-sm-0" style="margin-right: 100px; border-color: white; color:black" type="submit">Найти</button>
            </form>
            <#if user.email??>
                <div class="dropdown text-end">
                    <a href="/profile">
                        <#if user.image??>
                            <img src="/images/${user.image.id}" alt="mdo"
                                 width="32" height="32" class="rounded-circle">
                        <#else>
                            <img src="/static/images/avatar.png" alt="mdo"
                                 width="32" height="32" class="rounded-circle">
                        </#if>
                    </a>
                </div>
            <#else>
                <button class="btn btn-light my-2 my-sm-0"  type="button"
                        onclick="window.location.href = '/login'">
                    Войти
                </button>
            </#if>
        </div>
    </nav>

    <#-- Сообщение об успехе -->
    <#if successMessage?has_content>
        <div class="alert alert-success" role="alert">${successMessage}</div>
    </#if>

    <#-- Сообщение об ошибке -->
    <#if errorMessage?has_content>
        <div class="alert alert-danger" role="alert">${errorMessage}</div>
    </#if>

    <div class="container mt-4">
        <#nested/>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
            integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
            integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
            crossorigin="anonymous"></script>
    </body>
    </html>
</#macro>
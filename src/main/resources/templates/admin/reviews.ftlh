<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <title>Управление комментариями</title>
</head>
<body>

<#include "../parts/navbar.ftlh">

<div class="container mt-4">
    <h3 class="text-center mb-4">Отзывы пользователей</h3>

    <table class="table table-bordered table-striped text-center">
        <thead class="table-dark">
        <tr>
            <th>ID пользователя</th>
            <th>Ссылка на телефон</th>
            <th>Оценка</th>
            <th>Сообщение</th>
            <th>Пользователь</th>
            <th>Отзыв</th>
        </tr>
        </thead>
        <tbody>
        <#list reviews as review>
            <tr>
                <td>${review.user.id?c}</td>
                <td><a href="/phone/${review.phone.id?c}" class="btn btn-info">Посмотреть</a></td>
                <td>${review.rating}</td>
                <td>${review.message}</td>
                <td>
                    <#if review.user.active == true>
                        <form action="/admin/user/ban/${review.user.id?c}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button type="submit" class="btn btn-danger">Бан</button>
                        </form>
                    <#else>
                        <form action="/admin/user/unban/${review.user.id?c}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button type="submit" class="btn btn-success">Разбан</button>
                        </form>
                    </#if>
                </td>
                <td>
                    <form action="/admin/delete/review/${review.phone.id}/${review.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <button type="submit" class="btn btn-danger">Удалить</button>
                    </form>
                </td>
            </tr>
        <#else>
            <tr>
                <td colspan="5" class="text-center">Отзывов нет</td>
            </tr>
        </#list>
        </tbody>
    </table>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

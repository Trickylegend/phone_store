<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <title>Управление пользователями</title>
</head>
<body>

<#include "../../parts/navbar.ftlh">

<div class="container mt-4">
    <h3 class="text-center mb-4">Аккаунты пользователей</h3>

    <table class="table table-striped table-bordered text-center">
        <thead class="table-dark">
        <tr>
            <th>Уникальный номер</th>
            <th>Электронная почта</th>
            <th>Номер телефона</th>
            <th>Активность</th>
            <th>Роль</th>
            <th>Действие с аккаунтом</th>
            <th>Редактирование</th>
        </tr>
        </thead>
        <tbody>
        <#list users as usr>
            <tr>
                <td>${usr.id}</td>
                <td>${usr.email}</td>
                <td>${usr.person.phoneNumber}</td>
                <td>${usr.active?string("Да", "Нет")}</td>
                <td><#list usr.roles as role>${role}<br></#list></td>
                <td>
                    <#if usr.active == true>
                        <form action="/admin/user/ban/${usr.id?c}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button type="submit" class="btn btn-warning">Блокировать</button>
                        </form>
                    <#else>
                        <form action="/admin/user/unban/${usr.id?c}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button type="submit" class="btn btn-success">Разблокировать</button>
                        </form>
                    </#if>
                </td>
                <td>
                    <a href="/admin/edit/user/${usr.id?c}" class="btn btn-info">Редактирование</a>
                </td>
            </tr>
        <#else>
            <tr>
                <td colspan="7">Пользователей нет</td>
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

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <title>Редактирование аккаунта</title>
</head>
<body>

<#include "../parts/navbar.ftlh">

<div class="container mt-4">
    <h1>Редактирование аккаунта</h1>
    <hr>

    <form action="/user/edit" method="post" class="mb-3">
        <div class="mb-3">
            <input type="text" class="form-control" name="name" value="${user.person.name}" placeholder="Имя">
        </div>
        <div class="mb-3">
            <input type="text" class="form-control" name="surname" value="${user.person.surname}" placeholder="Фамилия">
        </div>
        <div class="mb-3">
            <input type="email" class="form-control" name="email" value="${user.email}" placeholder="Email">
        </div>
        <div class="mb-3">
            <input type="text" class="form-control" name="phoneNumber" value="${user.person.phoneNumber}" placeholder="Номер телефона">
        </div>
        <div class="mb-3">
            <input type="password" class="form-control" name="password" placeholder="Новый пароль">
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn btn-primary">Изменить</button>
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

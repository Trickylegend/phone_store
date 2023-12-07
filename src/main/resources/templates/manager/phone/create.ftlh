<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <title>Добавление телефона</title>
</head>
<body>

<#include "../../parts/navbar.ftlh">

<div class="container mt-4">
    <h3 class="text-center mb-3">Добавить новый телефон</h3>

    <form action="/manager/create/phone" method="post" enctype="multipart/form-data" class="mb-3">
        <div class="mb-3">
            <input type="text" name="brand" class="form-control" placeholder="Бренд" required>
        </div>
        <div class="mb-3">
            <input type="text" name="model" class="form-control" placeholder="Модель" required>
        </div>
        <div class="mb-3">
            <input type="number" name="ram" class="form-control" placeholder="RAM (GB)" required>
        </div>
        <div class="mb-3">
            <textarea class="form-control" name="description" maxlength="1000" placeholder="Описание" required></textarea>
        </div>
        <div class="mb-3">
            <select name="type" id="type" class="form-select">
                <option value="Игровой">Игровой</option>
                <option value="Мобильный">Мобильный</option>
                <option value="Кнопочный">Кнопочный телефон</option>
            </select>
        </div>
        <div class="mb-3">
            <input type="number" step="0.01" name="price" class="form-control" placeholder="Цена" required>
        </div>
        <div class="mb-3">
            <input type="number" name="amount" class="form-control" placeholder="Количество" required>
        </div>
        <div class="mb-3">
            <input type="file" name="file" class="form-control">
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn btn-primary">Добавить телефон</button>
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

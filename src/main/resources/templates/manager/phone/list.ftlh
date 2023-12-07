<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <title>Управление телефонами</title>
</head>
<body>

<#include "../../parts/navbar.ftlh">

<div class="container mt-4">
    <h2 class="text-center mb-4">Управление телефонами</h2>

    <#list phones as phone>
        <div class="card mb-3">
            <div class="row g-0">
                <div class="col-md-4">
                    <img src="/images/${phone.image.id}" class="img-fluid rounded-start" alt="Телефон">
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title">${phone.brand} ${phone.model}</h5>
                        <p class="card-text">${phone.description}</p>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">RAM: ${phone.ram} GB</li>
                            <li class="list-group-item">Цена: ${phone.price} ₽</li>
                            <li class="list-group-item">Рейтинг: ${phone.averageRating}</li>
                            <li class="list-group-item">${phone.inventoryItem.quantity} в наличии</li>
                            <#if phone.bestseller>
                                <li class="list-group-item">BestSeller</li>
                            </#if>
                        </ul>
                        <div class="card-footer">
                            <a href="/manager/edit/phone/${phone.id}" class="btn btn-primary">Редактировать</a>
                            <form action="/manager/delete/phone/${phone.id}" class="d-inline">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <button type="submit" class="btn btn-danger">Удалить</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </#list>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

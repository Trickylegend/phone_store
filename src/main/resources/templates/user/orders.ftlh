<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
    <title>Мои заказы</title>
</head>
<body>

<#include "../parts/navbar.ftlh">

<div class="container mt-4">

    <h2 class="mt-5">Мои заказы</h2>
    <#list oldOrders as order>
        <div class="card mb-3">
            <div class="card-body">
                <h5 class="card-title">Заказ №${order.id}</h5>
                <p>Время заказа: ${order.orderTime}</p>
                <p>Итоговая цена: ${order.totalPrice} ₽</p>
                <p>Статус: <#if order.confirmed>Подтвержден<#else>Не подтвержден</#if></p>
                <ul class="list-group list-group-flush">
                    <#list order.orderItems as item>
                        <li class="list-group-item">${item.phone.brand} ${item.phone.model} - ${item.phone.price} ₽</li>
                    </#list>
                </ul>
                <p>Адрес доставки: ${order.store.address}</p>
            </div>
        </div>
    </#list>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

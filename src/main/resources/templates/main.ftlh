<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">

    <title>Главная</title>
</head>
<body>

<style>
    .card-img-top {
        height: 200px;
        object-fit: cover;
    }

    .post-link:hover .card {
        transform: scale(1.03);
        transition: transform .2s ease-in-out;
    }

    .star-rating .fa-star, .star-rating .fa-star-half-alt {
        color: gold;
    }
</style>

<#include "parts/navbar.ftlh">

<div class="container mt-4">
    <form action="/" method="get" class="mb-4">
        <select class="form-select">
            <option value="">Выберите тип</option>
            <option value="Игровой">Игровой</option>
            <option value="Мобильный">Мобильный</option>
            <option value="Кнопочный">Кнопочный телефон</option>
        </select>
    </form>

    <div class="row">
        <#list phones as phone>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <a href="/phone/${phone.id}">
                        <img src="/images/${phone.image.id?c}" class="card-img-top">
                        <div class="card-body">
                            <#if phone.bestseller>
                                <h5 class="text-success">Лидер продаж</h5>
                            </#if>
                            <h5 class="card-title">${phone.brand} ${phone.model}</h5>
                            <p class="card-text">${phone.type}</p>
                            <p class="card-text">${phone.ram}</p>
                            <p class="card-text">${phone.price}</p>
                            <!-- Добавление в избранное и корзину -->
                            <#if user.email??>
                                <#if isFavoriteList[phone_index]>
                                    <form action="/favorites/delete/${phone.id?c}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                        <button type="submit" class="btn btn-warning btn-sm">
                                            Убрать из избранного
                                        </button>
                                    </form>
                                <#else>
                                    <form action="/favorites/add/${phone.id?c}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                        <button type="submit" class="btn btn-info btn-sm">
                                            В избранное
                                        </button>
                                    </form>
                                </#if>
                            </#if>
                            <form action="/cart/add/${phone.id?c}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-primary btn-sm">
                                    В корзину
                                </button>
                            </form>
                        </div>
                        <div class="card-footer">
                            <div class="star-rating">
                                <#list 1..5 as i>
                                    <#if (phone.averageRating >= i )>
                                        <i class="fas fa-star text-warning"></i>
                                    <#elseif (phone.averageRating > i - 1)>
                                        <i class="fas fa-star-half-alt text-warning"></i>
                                    <#else>
                                        <i class="far fa-star"></i>
                                    </#if>
                                </#list>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </#list>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

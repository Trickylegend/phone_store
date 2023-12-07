<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <title>Избранное</title>
</head>
<body>

<#include "../parts/navbar.ftlh">

<div class="row">
    <#if favorites?has_content>
        <#list favorites as favorite>
            <div class="col-md-4 mb-4">
                <div class="card">
                    <a href="/phone/${favorite.phone.id}">
                        <img src="/images/${favorite.phone.image.id?c}" class="card-img-top">
                        <div class="card-body">
                            <#if favorite.phone.bestseller>
                                <h5 class="text-success">Лидер продаж</h5>
                            </#if>
                            <h5 class="card-title">${favorite.phone.brand} ${favorite.phone.model}</h5>
                            <p class="card-text">${favorite.phone.type}</p>
                            <p class="card-text">${favorite.phone.ram}</p>
                            <p class="card-text">${favorite.phone.price}</p>

                            <form action="/favorites/delete/${favorite.phone.id?c}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-warning btn-sm">
                                    Убрать из избранного
                                </button>
                            </form>

                            <form action="/cart/add/${favorite.phone.id?c}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-primary btn-sm">
                                    В корзину
                                </button>
                            </form>
                        </div>
                        <div class="card-footer">
                            <div class="star-rating">
                                <#-- Цикл для отображения звезд рейтинга -->
                                <#list 1..5 as i>
                                    <#if (favorite.phone.averageRating >= i )>
                                        <i class="fas fa-star text-warning"></i> <!-- Полная звезда -->
                                    <#elseif (favorite.phone.averageRating > i - 1)>
                                        <i class="fas fa-star-half-alt text-warning"></i> <!-- Половина звезды -->
                                    <#else>
                                        <i class="far fa-star"></i> <!-- Пустая звезда -->
                                    </#if>
                                </#list>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </#list>
    <#else>
        <h3>Пока ничего нет</h3>
    </#if>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
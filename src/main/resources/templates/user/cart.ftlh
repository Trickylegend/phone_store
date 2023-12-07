<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
            crossorigin="anonymous"></script>
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    <title>Корзина</title>
</head>
<body>

<#include "../parts/navbar.ftlh">

<div class="container mt-4">
    <h1 class="text-center">Корзина</h1>
    <hr>
    <#if cart??>
        <div class="row">
            <div class="col-md-8">
                <div class="list-group">
                    <#-- ... Предыдущий код ... -->

                    <#list cart.cartItems as item>
                        <div class="list-group-item list-group-item-action flex-column align-items-start">
                            <div class="d-flex w-100 justify-content-between">
                                <img src="/images/${item.phone.image.id?c}" class="img-fluid" style="width: 100px; height: 100px;">
                                <div>
                                    <h5 class="mb-1">${item.phone.brand} ${item.phone.model}</h5>
                                    <small>${item.phone.price} ₽</small>
                                </div>
                                <div>
                                    <form action="/cart/update/${item.phone.id}/${item.quantity - 1}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <button type="submit" class="btn btn-secondary btn-sm">-</button>
                                    </form>
                                    <span>Количество: ${item.quantity}</span>
                                    <form action="/cart/update/${item.phone.id}/${item.quantity + 1}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <button type="submit" class="btn btn-secondary btn-sm">+</button>
                                    </form>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input product-checkbox" type="checkbox" value="${item.id}" id="check-${item.id}" <#if item.selected> checked </#if>>
                                    <label class="form-check-label" for="check-${item.id}">Выбрать для заказа</label>
                                </div>
                            </div>
                        </div>
                    </#list>

                    <#-- ... Остальной код ... -->

                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Детали заказа</h5>

                        <p class="card-text" id="totalPrice">Итоговая стоимость: ${totalPrice}</p>

                        <form action="/order/create" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <div class="form-group">
                                <label for="storeId">Выберите пункт самовывоза:</label>
                                <select class="form-control" id="storeId" name="storeId">
                                    <#list stores as store>
                                        <option value="${store.id}">${store.name} - ${store.address}</option>
                                    </#list>
                                </select>
                            </div>
                            <button class="btn btn-primary my-2 my-sm-0" type="submit">Заказать</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    <#else>
        <h3 class="text-center">Пока ничего нет</h3>
    </#if>
</div>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="/static/js/script.js"></script>
</body>
</html>
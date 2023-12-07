<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
    <title>${phone.model}</title>
</head>
<body>

<#include "parts/navbar.ftlh">

<div class="container mt-4">
    <img src="/images/${phone.image.id?c}" class="img-fluid">
    <#if phone.bestseller>
        <h2 class="text-success">Лидер продаж</h2>
    </#if>
    <h5>${phone.brand} ${phone.model}</h5>
    <h5>${phone.ram}</h5>
    <h5>${phone.type}</h5>
    <h5>${phone.description}</h5>
    <p>${phone.price}</p>

    <br><br>
    <#if user.email??>
        <form action="/phone/${phone.id}/review/create" method="post" id="reviewForm">
            <div class="star-rating-input">
                <#list 1..5 as i>
                    <input type="radio" id="star-${i}" name="rating" value="${i}" class="d-none"/>
                    <label for="star-${i}" title="${i} stars" class="fa fa-star"></label>
                </#list>
            </div>
            <br><br>
            <div class="form-group">
                <label for="message">Сообщение</label>
                <textarea class="form-control" id="message" name="message"></textarea>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" class="btn btn-primary">Отправить</button>
        </form>
    </#if>

    <br><br>
    <#list reviews as review>
        <div class="review-section">
            <h2>${review.user.person.name}</h2>
            <div class="star-rating">
                <#-- Цикл для отображения звезд рейтинга -->
                <#list 1..5 as i>
                    <#if (review.rating >= i )>
                        <i class="fas fa-star"></i> <!-- Полная звезда -->
                    <#elseif (review.rating > i - 1)>
                        <i class="fas fa-star-half-alt"></i> <!-- Половина звезды -->
                    <#else>
                        <i class="far fa-star"></i> <!-- Пустая звезда -->
                    </#if>
                </#list>
            </div>
            <p>${review.message}</p>
        </div>
        <hr>
    </#list>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    document.querySelectorAll('.star-rating-input label').forEach(label => {
        label.addEventListener('mouseover', () => {
            let hoverValue = parseInt(label.htmlFor.split('-')[1]);
            document.querySelectorAll('.star-rating-input label').forEach(innerLabel => {
                let labelValue = parseInt(innerLabel.htmlFor.split('-')[1]);
                innerLabel.style.color = labelValue <= hoverValue ? 'gold' : '#ccc';
            });
        });
    });

    document.querySelector('.star-rating-input').addEventListener('mouseout', () => {
        let checkedValue = document.querySelector('.star-rating-input input:checked') ?
            parseInt(document.querySelector('.star-rating-input input:checked').value) : 0;
        document.querySelectorAll('.star-rating-input label').forEach(label => {
            let labelValue = parseInt(label.htmlFor.split('-')[1]);
            label.style.color = labelValue <= checkedValue ? 'gold' : '#ccc';
        });
    });

</script>

</body>
</html>
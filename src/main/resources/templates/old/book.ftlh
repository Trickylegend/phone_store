<#import "blocks/template.ftlh" as t>
<@t.template user, "phone">

    <div class="card text-white bg-dark my-3 post" style="position: relative; width: 45%">

        <img src="/images/${phone.image.id?c}" class="card-img-top">
        <div class="card-body">
            <#if phone.bestseller> <h2>Лидер продаж</h2></#if>
            <h5 class="card-title">${phone.title}</h5>
            <p class="card-text">${phone.price} ₽</p>

        </div>
        <div class="card-footer">
            ${phone.author}
        </div>
    </div>

    <br><br>
    <#if user.email??>
        <form action="/phone/${phone.id}/review/create" method="post" id="reviewForm">
            <div class="star-rating-input">
                <#list 1..5 as i>
                    <input type="radio" id="star-${i}" name="rating" value="${i}" />
                    <label for="star-${i}" title="${i} stars" class="fa fa-star"></label>
                </#list>
            </div>
            <br><br>
            Message <input type="text" name="message"> <br><br>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit">Отправить</button>
        </form>
    </#if>



    <#list reviews as review>
        <h2>${review.user.person.name}</h2>
        <div class="star-rating">
            <#-- Цикл для отображения полных звезд -->
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
        <p>${review.message}</p> <br><br>
    </#list>

    <script>
        document.querySelectorAll('.star-rating-input input').forEach(input => {
            input.addEventListener('change', () => {
                document.querySelectorAll('.star-rating-input label').forEach(label => {
                    label.style.color = label.htmlFor <= document.querySelector('.star-rating-input input:checked').id ? 'gold' : '#ccc';
                });
            });
        });

    </script>

</@t.template>
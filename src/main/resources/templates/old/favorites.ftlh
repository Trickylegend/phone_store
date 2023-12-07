<#import "blocks/template.ftlh" as t>
<@t.template user, "favorites">

    <h1 style="text-align: center;">Избранные объявления</h1>
    <br>
    <hr>
    <br>
    <#if favorites?has_content>
        <div class="card-columns">
            <#list favorites as favorite>
                <a href="/phone/${favorite.phone.id}" class="post-link">
                    <div class="card text-white bg-dark my-3 post" style="position: relative;">

                        <div style="position: absolute; top: 0; right: 0;">
                            <form action="/favorites/delete/${favorite.phone.id?c}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-danger">
                                    Убрать из избранного
                                </button>
                            </form>
                        </div>

                        <img src="/images/${favorite.phone.image.id?c}" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">${favorite.phone.title}</h5>
                            <p class="card-text">${favorite.phone.price} ₽</p>
                        </div>
                        <div class="card-footer">
                            ${favorite.phone.author}

                            <form action="/cart/add/${favorite.phone.id?c}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-success">
                                    В корзину
                                </button>
                            </form>
                        </div>
                    </div>
                </a>
            </#list>
        </div>
    <#else>
        <h3 style="text-align: center;">Пока ничего нет</h3>
    </#if>
</@t.template>

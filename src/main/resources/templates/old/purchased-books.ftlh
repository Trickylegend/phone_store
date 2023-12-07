<#import "blocks/template.ftlh" as t>
<@t.template user, "purchased-phones">

    <main role="main" class="container mt-4">


        <div class="card-columns">
            <#list phones as phone>
                <a href="/phone/${phone.id}" class="post-link">
                    <div class="card text-white bg-dark my-3 post" style="position: relative;">
                        <div style="position: absolute; top: 0; right: 0;">

                            <#if user.email??>
                                <#if isFavoriteList[book_index]>
                                    <form action="/favorites/delete/${phone.id?c}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                        <button type="submit" class="btn btn-danger">
                                            Убрать из избранного
                                        </button>
                                    </form>
                                <#else>
                                    <form action="/favorites/add/${phone.id?c}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                        <button type="submit" class="btn btn-success">
                                            В избранное
                                        </button>
                                    </form>
                                </#if>
                            </#if>

                        </div>

                        <img src="/images/${phone.image.id?c}" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">${phone.title}</h5>
                            <p class="card-text">${phone.price} ₽</p>
                        </div>
                        <div class="card-footer">
                            ${phone.author}
                            <form action="/cart/add/${phone.id?c}" method="post">
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
    </main>

</@t.template>
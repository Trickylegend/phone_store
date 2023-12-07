<#import "../blocks/template.ftlh" as t>
<@t.template user, "phones">

    <h1 style="text-align: center;">Книги</h1>

    <a href="/admin/create/phone">
        <button>Добавить книгу</button>
    </a>

    <div class="card-columns">
        <#list phones as phone>
            <a href="/phone/${phone.id}" class="post-link">
                <div class="card text-white bg-dark my-3 post" style="position: relative;">
                    <div style="position: absolute; top: 0; left: 0;">
                        <h3 class="btn btn-primary">
                            <#if phone.inventoryItem.quantity != 0>
                                В наличии(${phone.inventoryItem.quantity})
                            <#else>
                                Нет в наличии
                            </#if>
                        </h3>
                    </div>

                    <img src="/images/${phone.image.id?c}" class="card-img-top">
                    <div class="card-body">
                        <h5 class="card-title">${phone.title}</h5>
                        <p class="card-text">${phone.price} ₽</p>
                    </div>
                    <div class="card-footer">
                        ${phone.author}
                    </div>
                    <form action="/admin/delete/phone/${phone.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Удалить">
                    </form>
                    <a href="/admin/edit/phone/${phone.id}">
                        <button>Редактировать</button>
                    </a>
                </div>
            </a>
        </#list>
    </div>

</@t.template>
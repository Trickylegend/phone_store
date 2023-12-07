<#import "../blocks/template.ftlh" as t>
<@t.template user, "delivery-points">

    <a href="/create/delivery-point">
        <button>Добавить новый</button>
    </a>

    <#list deliveryPoints as point>
        <p>${point.name}</p>
        <p>${point.address}</p>
        <p><#if point.active> Активен <#else> Неактивен</#if></p>
        <a href="/edit/delivery-point/${point.id}">
            <button>Редактировать</button>
        </a>

        <form action="/delete/delivery-point/${point.id}">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Удалить">
        </form>

        <#if point.active>
            <form action="/deactivate/delivery-point/${point.id}" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Деактивировать">
            </form>
        <#else>
            <form action="/activate/delivery-point/${point.id}" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Активировать">
            </form>
        </#if>

        <br><br>
    </#list>

</@t.template>
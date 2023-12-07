<#import "blocks/template.ftlh" as t>
<@t.template user, "profile">
    <h1 style="text-align: center">Личный кабинет</h1>
    <hr>
    <br>
    <div style="text-align: center">
        <#if user.image??>
            <img src="/images/${user.image.id}"
                 style="border:2px solid black; border-radius: 20px" height="120">
        <#else>
            <img src="/static/images/avatar.png"
                 style="border:2px solid black; border-radius: 20px" height="120">
        </#if>

        <br>
        <br>
        <h2>${user.person.name} ${user.person.surname}</h2>
        <br>
        Электоронная почта: <b>${user.email}</b>
        <br>
        Номер телефона: <b>${user.person.phoneNumber}</b>
        <br>
        Персональная скидка <b>${user.discount}%</b>
        <br>
        <br>
        <#if user.roles?seq_contains("ROLE_ADMIN")>
            <a class="btn btn-dark mb-3" style="width: 30%; background-color:pink; border-color: pink; color: black" href="/admin">
                Панель администратора
            </a>
        </#if>
        <#if user.roles?seq_contains("ROLE_EDITOR")>
            <a class="btn btn-dark mb-1" style="width: 30%; background-color:pink; border-color: pink; color: black" href="/editor">
                Панель новостного сотрудника
            </a>
        </#if>
        <a class="btn btn-dark mb-1" style="width: 30%; background-color:pink; border-color: pink; color: black" href="/user/orders">
            Мои заказы
        </a>

        <a class="btn btn-dark mb-1" style="width: 30%; background-color:pink; border-color: pink; color: black" href="/user/purchases">
            Купленные книги
        </a>
        <a class="btn btn-dark mb-3" style="width: 30%; background-color:pink; border-color: pink; color: black" href="/user/edit">
            Редактировать аккаунт
        </a>
        <form action="/logout" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button type="submit" style="width: 40%; background-color:mediumpurple; border-color: mediumpurple; color: black" class="btn btn-danger mb-2">
                Выйти из аккаунта
            </button>
        </form>
    </div>
</@t.template>
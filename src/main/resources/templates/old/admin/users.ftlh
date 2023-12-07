
<#import "../blocks/template.ftlh" as t>
<@t.template user, "users">


    <h3 style="text-align: center;">Аккаунты пользователей</h3>
    <table border="1" cellpadding=7 style="margin-right: auto; width:100%; margin-left: auto; border-collapse: collapse; border: 1px solid black; text-align: center">
        <thead style="background-color: mediumpurple">
        <tr>
            <th>Уникальный номер</th>
            <th>Электронная почта</th>
            <th>Номер телефона</th>
            <th>Активность</th>
            <th>Роль</th>
            <th>Действие с аккаунтом</th>
            <th>Редактирование</th>
        </tr>
        </thead>
        <#list users as usr>
            <tr>
                <th>${usr.id}</th>
                <th>${usr.email}</th>
                <th>${usr.person.phoneNumber}</th>
                <th>${usr.active?string('Да', 'Нет')}
                </th>
                <th><#list usr.roles as role>${role}<br></#list></th>
                <th>
                    <#if usr.active == true>
                        <form action="/admin/user/ban/${usr.id?c}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input class="btn btn-success" style="background-color:pink; border-color: pink; color: black" type="submit" value="Блокировать">
                        </form>
                    <#else>
                        <form action="/admin/user/unban/${usr.id?c}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input class="btn btn-success" type="submit" value="Разблокировать">
                        </form>
                    </#if>
                </th>
                <th><a href="/admin/edit/user/${usr.id?c}" style="color: deeppink">Редактирование</a></th>
            </tr>
        <#else>
            <h3>Пользователей нет</h3>
        </#list>
    </table>
    <br>

</@t.template>
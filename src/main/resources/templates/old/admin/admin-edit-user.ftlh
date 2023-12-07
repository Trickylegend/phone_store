<#import "../blocks/template.ftlh" as t>
<@t.template user, "admin/admin-user-edit">
    <h1 style="text-align: center">Редактирование пользователя</h1>
    <hr>
    <form action="/admin/edit/user" method="post">
        <#list roles as role>
            <div>
                <label> <input type="checkbox" name="${role}" ${usr.roles?seq_contains(role)?string("checked", "")}>${role}</label>
            </div>
        </#list>
        <input type="hidden" value="${usr.id}" name="userId">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit">Сохранить</button>
    </form>

    <#if errorMessage??>
        <h2 style="color: red">${errorMessage}</h2>
    </#if>
</@t.template>
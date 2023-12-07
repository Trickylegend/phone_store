<#import "../blocks/template.ftlh" as t>
<@t.template user, "editor/articles">

    <h2>Управление новостями</h2>
    <br>
    <br>

    <a href="/editor/create/article">
        <button>Создать новость</button>
    </a>

<#if articles??>
    <#list articles as article>
        <img style="width: 300px" src="/images/${article.preview.id}" alt="Новости">
        <h3>${article.title}</h3>
        <h5>${article.description}</h5>
        <h5>${article.dateOfCreated}</h5>
        <form action="/editor/delete/article/${article.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Удалить">
        </form>
        <a href="/editor/edit/article/${article.id}"><button>Редактировать</button></a>
        <br>
        <br>
    </#list>
    <#else>
    Новостей пока нет
</#if>

</@t.template>
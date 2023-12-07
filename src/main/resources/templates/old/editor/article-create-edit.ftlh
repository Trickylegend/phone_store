<#import "../blocks/template.ftlh" as t>
<@t.template user, "article-create">


    <#if article??>
        <h2>Отредактируйте новость</h2>

        <form action="/editor/edit/article/${article.id}" method="post" enctype="multipart/form-data">
            Заголовок <input type="text" name="title" value="${article.title}"> <br>
            Описание <input type="text" name="description" value="${article.description}"> <br>
            Превью <input type="file" name="image"> <br>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Изменить">
        </form>

        <#else>
            <h2>Создайте новость</h2>
            <form action="/editor/create/article" method="post" enctype="multipart/form-data">
                Заголовок <input type="text" name="title"> <br>
                Описание <input type="text" name="description"> <br>
                Превью <input type="file" name="image"> <br>
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Создать">
            </form>
    </#if>




</@t.template>

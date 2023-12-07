<#import "blocks/template.ftlh" as t>
<@t.template user, "articles">

    <h2> Новости </h2> <br> <br>


    <#list articles as article>
        <img style="width: 300px" src="/images/${article.preview.id}" alt="Новости">
        <h3>${article.title}</h3>
        <h5>${article.description}</h5>
        <h5>${article.dateOfCreated}</h5>
        <br>
        <br>
    </#list>
</@t.template>
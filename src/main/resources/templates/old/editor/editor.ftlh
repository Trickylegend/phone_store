<#import "../blocks/template.ftlh" as t>
<@t.template user, "editor">

    <h2>Новостной редактор</h2>

    <a href="/editor/create/article">
        <button>Создать новость</button>
    </a>

    <a href="/editor/articles">
        <button>Управление новостями</button>
    </a>

</@t.template>
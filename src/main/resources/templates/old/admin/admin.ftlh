<#import "../blocks/template.ftlh" as t>
<@t.template user, "admin">

    <body>
    <h1 style="text-align: center;">Панель администратора</h1>
    <br><br>

    <a href="/admin/users">
        <button>Управление пользователями</button>
    </a>

    <a href="/admin/reviews">
        <button>Управление отзывами</button>
    </a>


    <a href="/admin/phones">
        <button>Управление книгами</button>
    </a>


    <a href="/admin/delivery-points">
        <button>Управление пунктами самовывоза</button>
    </a>


    <a href="/editor/articles">
        <button>Управление новостями</button>
    </a>


    </body>
</@t.template>
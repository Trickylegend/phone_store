<#import "../blocks/template.ftlh" as t>
<@t.template user, "reviews">


    <br>
    <h3 style="text-align: center;">Отзывы пользователей</h3>
    <br>

    <table border="1" cellpadding=7 style="margin-right: auto; width: 100%; margin-left: auto; border-collapse: collapse; border: 1px solid black; text-align: center">
        <thead style="background-color: mediumpurple">
        <tr>
            <th>user_id</th>
            <th>Ссылка на пользователя</th>
            <th>Ссылка на пост</th>
            <th>Сообщение</th>
            <th>Пользователь</th>
            <th>Сообщение</th>

        </tr>
        </thead>
        <#list reviews as review>

            <tr>
                <th>${review.user.id?c}</th>
                <th><a href="/user/${review.user.id?c}" class="btn btn-info">Посмотреть</a></th>
                <th><a href="/phone/${review.phone.id?c}" class="btn btn-info">Посмотреть</a></th>
                <th>${review.message}</th>
                <th>
                    <#if review.user.active == true>
                        <form action="/admin/user/ban/${review.user.id?c}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input class="btn btn-danger" type="submit" value="Бан">
                        </form>
                    <#else>
                        <form action="/admin/user/unban/${review.user.id?c}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input class="btn btn-success" type="submit" value="Разбан">
                        </form>
                    </#if>
                </th>
                <th>
                    <form action="/admin/comment/delete/${review.id?c}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input class="btn btn-danger" type="submit" value="Удалить">
                    </form>
                </th>
            </tr>
        <#else>
            <br><br>
            <h3 style="text-align: center;">Сообщений нет</h3>
            <br>
            <br>
        </#list>
    </table>
    <br>

</@t.template>
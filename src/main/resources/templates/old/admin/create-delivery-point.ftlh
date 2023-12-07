<#import "../blocks/template.ftlh" as t>
<@t.template user, "create-delivery-point">

        <h3>Добавить новый пункт самовывоза</h3>
        <form action ="/create/delivery-point" method="post">

            <div class="form-group">
                <label for="name">Название пункта</label>
                <input type="text" id="name" name="name" class="form-control"/>
            </div>

            <div class="form-group">
                <label for="address">Адрес пункта</label>
                <input type="text" id="address" name="address" class="form-control"/>
            </div>

            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" class="btn btn-primary" style="background-color:pink; border-color: pink; color: black">Добавить пункт</button>
        </form>


</@t.template>
<#import "../blocks/template.ftlh" as t>
<@t.template user, "edit-delivery-point">

    <h3>Редактирование пункта самомовывоза</h3>

    <form action ="/edit/delivery-point/${deliveryPoint.id}" method="post">

        <div class="form-group">
            <label for="name">Название пункта</label>
            <input type="text" id="name" name="name" class="form-control" value="${deliveryPoint.name}"/>
        </div>

        <div class="form-group">
            <label for="address">Адрес пункта</label>
            <input type="text" id="address" name="address" class="form-control" value="${deliveryPoint.address}" />
        </div>

        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn btn-primary" style="background-color:pink; border-color: pink; color: black">Изменить пункт</button>
    </form>

</@t.template>
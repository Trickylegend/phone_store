<#import "blocks/template.ftlh" as t>
<@t.template user, "my-orders">

    <h2>Активные заказы</h2>
    <br>
    <br>
    <#if activeOrders??>
        <#list activeOrders as order>
            <#if order.confirmed>
                <h3>Статус: Подтвержден</h3>
            <#else>
                <h3>Статус: Не подтвержден</h3>
            </#if>
            <h3>Итоговая стоимость: ${order.totalPrice}</h3>
<#--            Убрать!-->
            <#if order.deliveryPoint??>
                <p>Пункт самовывоза: ${order.deliveryPoint.name} ${order.deliveryPoint.address}</p>
            </#if>

            <h3>Товары:</h3>
            <#list order.orderItems as item>
                <p>Название: ${item.phone.title}</p>
                <p>Кол-во: ${item.quantity}</p>
                <p>Цена за шт: ${item.phone.price}</p>
            </#list>
            <p>Дата заказа: ${order.orderTime}</p>
            <br>
            <br>
        </#list>
    <#else>
        <h2>Активных заказов пока нет</h2>
    </#if>

    <#if oldOrders??>
        <h2>Прошлые заказы</h2>
        <br>
        <br>
        <#list oldOrders as order>
            <#if order.confirmed>
                <h3>Статус: Подтвержден</h3>
            <#else>
                <h3>Статус: Не подтвержден</h3>
            </#if>
            <p>Итоговая стоимость: ${order.totalPrice}</p>
            <p>Пункт самовывоза: ${order.deliveryPoint.name} ${order.deliveryPoint.address}</p>

            <h3>Товары:</h3>
            <#list order.orderItems as item>
                <p>Название: ${item.phone.title}</p>
                <p>Кол-во: ${item.quantity}</p>
                <p>Цена за шт: ${item.phone.price}</p>
            </#list>
            <p>Дата заказа: ${order.orderTime}</p>
            <br>
            <br>
        </#list>
        <#else>
        <h2>Старых заказов пока нет </h2>
    </#if>



</@t.template>

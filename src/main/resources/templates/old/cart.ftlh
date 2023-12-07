<#import "blocks/template.ftlh" as t>
<@t.template user, "cart">
    <h1 style="text-align: center;">Корзина</h1>
    <hr>
    <#if cart?has_content>
        <div class="row">
            <div class="col-md-8">
                <div class="list-group">
                    <#list cart.cartItems as item>
                        <div class="list-group-item list-group-item-action flex-column align-items-start">
                            <div class="d-flex w-100 justify-content-between">
                                <img src="/images/${item.phone.image.id?c}" class="img-fluid" style="width: 100px; height: 100px;">
                                <div>
                                    <h5 class="mb-1">${item.phone.title}</h5>
                                    <small>${item.phone.price} ₽</small>
                                </div>
                                <div>
                                    <form action="/cart/update/${item.phone.id}/${item.quantity - 1}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <button type="submit" class="btn btn-secondary btn-sm">-</button>
                                    </form>
                                    <span>Количество: ${item.quantity}</span>
                                    <form action="/cart/update/${item.phone.id}/${item.quantity + 1}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <button type="submit" class="btn btn-secondary btn-sm">+</button>
                                    </form>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input product-checkbox" type="checkbox" value="${item.id}" id="check-${item.id}"
                                            <#if item.selected> checked </#if>
                                    >
                                    <p class="form-check-label" for="check-${item.id}" style="width: 150px">
                                        Выбрать для заказа
                                    </p>
                                </div>
                            </div>
                        </div>
                    </#list>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Детали заказа</h5>
                        <#if oldPrice == totalPrice>
                            <p class="card-text" id="totalPrice">Итоговая стоимость : ${totalPrice}</p>
                        <#else>
                            <p>Персональная скидка - ${discount}%</p>
                            <p>Старая цена - <s>${oldPrice}</s>р</p>
                            <p class="card-text" id="totalPrice">Итоговая стоимость : ${totalPrice}</p>
                        </#if>


                        <form action="/order/create" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">

                            <div class="form-group">
                                <label for="deliveryPoint">Выберите пункт самовывоза:</label>
                                <select class="form-control" id="deliveryPoint" name="deliveryPointId">
                                    <#list points as point>
                                        <option value="${point.id}">${point.name} - ${point.address}</option>
                                    </#list>
                                </select>
                            </div>

                            <button class="btn my-2 my-sm-0" style="margin-right: 100px; border-color: white; color:black; background-color: pink" type="submit">Заказать</button>
                        </form>
                    </div>
                </div>
            </div>

        </div>
    <#else>
        <h3 style="text-align: center;">Пока ничего нет</h3>
    </#if>

<#-- Использование директивы FreeMarker для игнорирования обработки JavaScript кода -->
    <script src="/static/js/script.js"></script>


</@t.template>
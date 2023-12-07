<#import "blocks/template.ftlh" as t>
<@t.template user, "registration">
    <h1 style="text-align: center">Регистрация</h1>
    <hr>
    <form action="/registration" method="post" style="text-align:center; width: 50%; margin-left: auto; margin-right: auto;">
        <div class="form-group">
            <label for="name">Имя пользователя</label>
            <input type="text" class="form-control" required id="name" name="name">
        </div>
        <div class="form-group">
            <label for="surname">Фамилия пользователя</label>
            <input type="text" class="form-control" required id="surname" name="surname">
        </div>
        <div class="form-group">
            <label for="email">Электронная почта</label>
            <input type="email" class="form-control" id="email" required name="email">
        </div>
        <div class="form-group">
            <label for="phoneNumber">Номер телефона</label>
            <input type="text" class="form-control" id="phoneNumber" required name="phoneNumber">
        </div>
        <div class="form-group">
            <label for="password">Пароль</label>
            <input type="password" class="form-control" id="password" required name="password">
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" style="width: 50%; background-color:pink; border-color: pink; color: black" class="btn btn-dark">Зарегистрироваться</button>
    </form>
</@t.template>
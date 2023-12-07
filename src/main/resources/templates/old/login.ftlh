<#import "blocks/template.ftlh" as t>
<@t.template user, "login">
    <h1 style="text-align: center">Авторизация</h1>

    <form action="/login" method="post" style="text-align:center; width: 50%; margin-left: auto; margin-right: auto;">
        <div class="form-group" >
            <label for="email" style="text-align:center">Электронная почта</label>
            <input type="email" class="form-control" id="email" name="email"  >
            <div id="email" class="invalid-feedback">
                Неверная электронная почта
            </div>
        </div>
        <div class="form-group">
            <label for="password">Пароль</label>
            <input type="password" class="form-control" id="password" name="password" >
            <div id="password" class="invalid-feedback">
                Неверный пароль
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" style="width: 50%; background-color:pink; border-color: pink; color: black" class="btn btn-info">Войти</button>
    </form>

    <hr>
    <h4 style="text-align:center">Нет аккаунта? <a href="/registration" style="color:pink">Зарегистрироваться</a></h4>
</@t.template>
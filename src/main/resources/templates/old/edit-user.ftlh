<#import "blocks/template.ftlh" as t>
<@t.template user, "edit-user">
    <h1 style="text-align: center">Редактирование аккаунта</h1>
    <hr>
    <form action="/user/edit" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="name">Имя пользователя</label>
            <input type="text" class="form-control" id="name" name="name" value="${user.person.name}">
        </div>
        <div class="form-group">
            <label for="surname">Фамилия пользователя</label>
            <input type="text" class="form-control" id="surname" name="surname" value="${user.person.surname}">
        </div>
        <div class="form-group">
            <label for="email">Электронная почта</label>
            <input type="email" class="form-control" id="email" name="email" value="${user.email}">
        </div>
        <div class="form-group">
            <label for="phoneNumber">Номер телефона</label>
            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${user.person.phoneNumber}">
        </div>
        <div class="form-group">
            <label for="password">Пароль</label>
            <input type="password" class="form-control" id="password" name="password">
        </div>

        <div class="form-group">
            <div class="custom-file">
                <input type="file" name="file1" id="file1">
                <label class="custom-file-label" for="file1">Аватар</label>
            </div>
        </div>


        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" style="width: 100%" class="btn btn-dark">Изменить</button>
    </form>
</@t.template>
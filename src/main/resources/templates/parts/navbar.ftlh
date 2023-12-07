<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <!-- Логотип или иконка слева -->
        <a class="navbar-brand" href="/">Компания</a>

        <!-- Кнопка "бургер" для мобильных устройств -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Ссылки в центре -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <!-- Общие ссылки -->
                <li class="nav-item">
                    <a class="nav-link" href="/">Главная</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/articles">Новости</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/cart">Корзина</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/favorites">Избранное</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/feedback">Нашли проблему?</a>
                </li>
            </ul>
        </div>

        <#if user.email??>

            <div class="dropdown">
                <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Аккаунт
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">

                    <#if user.roles?seq_contains("ROLE_USER")>
                        <a class="dropdown-item" href="/user/edit">Редактирование аккаунта</a>
                        <a class="dropdown-item" href="/user/orders">Мои заказы</a>
                        <a class="dropdown-item" href="/user/purchases">Мои покупки</a>
                    </#if>

                    <#if user.roles?seq_contains("ROLE_ADMIN")>
                        <a class="dropdown-item" href="/admin/users">Управление пользователями</a>
                        <a class="dropdown-item" href="/admin/reviews">Управление отзывами</a>
                        <a class="dropdown-item" href="/admin/feedback">Управление обратной связью</a>
                    </#if>

                    <#if user.roles?seq_contains("ROLE_EDITOR")>
                        <a class="dropdown-item" href="/editor/create/article">Добавить новость</a>
                        <a class="dropdown-item" href="/editor/articles">Управление новостями</a>
                    </#if>

                    <#if user.roles?seq_contains("ROLE_MANAGER")>
                        <a class="dropdown-item" href="/manager/create/phone">Добавить телефон</a>
                        <a class="dropdown-item" href="/manager/phones">Управление телефонами</a>
                        <a class="dropdown-item" href="/manager/create/store">Добавить магазин</a>
                        <a class="dropdown-item" href="/manager/stores">Управление магазинами</a>
                        <form action="/manager/calculate/bestseller" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input class="dropdown-item" type="submit" value="Просчитать лидера продаж">
                        </form>
                    </#if>

                </div>
            </div>
        <#else>
            <!-- Кнопка "Войти" для неавторизованных пользователей -->
            <div class="navbar-text">
                <a class="btn btn-primary" href="/login">Войти</a>
            </div>
        </#if>
    </div>
</nav>

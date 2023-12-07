<#import "blocks/template.ftlh" as t>
<@t.template user, page>


    <main role="main" class="container mt-4">
        <h1 class="text-center mb-4">Каталог книг</h1>
        <hr>
        <form method="get" action="/" class="mb-4">
            <div class="form-row">
                <div class="form-group col-md-2">
                    <label for="searchCity">Жанр</label>
                    <select id="searchCity" class="form-control">
                        <option value="">Выберите жанр</option>
                        <option value="Художественный">Художественный</option>
                        <option value="Научный">Научный</option>
                        <option value="Психологический">Психологический</option>
                    </select>
                </div>

            </div>
        </form>

        <div class="card-columns">
            <#list phones as phone>
                <a href="/phone/${phone.id}" class="post-link">
                    <div class="card text-white bg-dark my-3 post" style="position: relative;">
                        <div style="position: absolute; top: 0; right: 0;">

                            <#if user.email??>
                                <#if isFavoriteList[book_index]>
                                    <form action="/favorites/delete/${phone.id?c}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                        <button type="submit" class="btn btn-danger">
                                            Убрать из избранного
                                        </button>
                                    </form>
                                <#else>
                                    <form action="/favorites/add/${phone.id?c}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                        <button type="submit" class="btn btn-success">
                                            В избранное
                                        </button>
                                    </form>
                                </#if>
                            </#if>

                        </div>

                        <img src="/images/${phone.image.id?c}" class="card-img-top">
                        <div class="card-body">
                            <#if phone.bestseller> <h2>Лидер продаж</h2></#if>
                            <h5 class="card-title">${phone.title}</h5>
                            <p class="card-text">${phone.price} ₽</p>
                        </div>
                        <div class="card-footer">
                            ${phone.author}
                            <form action="/cart/add/${phone.id?c}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-success">
                                    В корзину
                                </button>
                            </form>
                        </div>

                        <div class="star-rating">
                            <#-- Цикл для отображения полных звезд -->
                            <#list 1..5 as i>
                                <#if (phone.averageRating >= i )>
                                    <i class="fas fa-star"></i> <!-- Полная звезда -->
                                <#elseif (phone.averageRating > i - 1)>
                                    <i class="fas fa-star-half-alt"></i> <!-- Половина звезды -->
                                <#else>
                                    <i class="far fa-star"></i> <!-- Пустая звезда -->
                                </#if>
                            </#list>
                        </div>

                    </div>
                </a>
            </#list>
        </div>


    </main>








</@t.template>
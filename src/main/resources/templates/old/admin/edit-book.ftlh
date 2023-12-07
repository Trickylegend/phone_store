<#import "../blocks/template.ftlh" as t>
<@t.template user, "edit-phone">

    <h3>Редактирование книги</h3>
    <form action ="/admin/edit/phone/${phone.id}" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="title">Название</label>
            <input type="text" id="title" name="title" class="form-control" value="${phone.title}"/>
        </div>
        <div class="form-group">
            <label for="description">Описание</label>
            <input type="text" id="description" name="description" class="form-control" value="${phone.description}"/>
        </div>
        <div class="form-group">
            <label for="author">Автор</label>
            <input type="text" id="author" name="author" class="form-control" value="${phone.author}"/>
        </div>
        <div class="form-group">
            <label for="type">Жанр</label>
            <select name="type" id="type" class="form-control">
                <option <#if phone.type == "Художественный">selected</#if> value="Художественный">Художественный</option>
                <option <#if phone.type == "Научный">selected</#if> value="Научный">Научный</option>
            </select>
        </div>

        <div class="form-group">
            <label for="price">Цена</label>
            <input type="number" id="price" name="price" class="form-control" value="${phone.price}"/>
        </div>

        <div class="form-group">
            <label for="amount">Количество</label>
            <input type="number" id="amount" name="amount" class="form-control" value="${amount}"/>
        </div>
        <div class="form-group">
            <label for="file">Обложка книги</label>
            <input type="file" id="file" name="file" class="form-control-file"/>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn btn-primary" style="background-color:pink; border-color: pink; color: black">Изменить книгу</button>
    </form>

</@t.template>
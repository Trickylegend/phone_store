<#import "../blocks/template.ftlh" as t>
<@t.template user, "create-phone">

    <div>
        <h3 >Добавить новую книгу</h3>
        <form action ="/admin/create/phone" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title">Название</label>
                <input type="text" id="title" name="title" class="form-control" required/>
            </div>
            <div class="form-group">
                <label for="description">Описание</label>
                <textarea type="text" id="description" name="description"  class="form-control" cols="30" rows="10"></textarea>
            </div>
            <div class="form-group">
                <label for="author">Автор</label>
                <input type="text" id="author" name="author" class="form-control" required/>
            </div>
            <div class="form-group">
                <label for="type">Жанр</label>
                <select name="type" id="type">
                    <option value="Художественный">Художественный</option>
                    <option value="Научный">Научный</option>
                </select>
            </div>

            <div class="form-group">
                <label for="price">Цена</label>
                <input type="number" id="price" name="price" class="form-control" required/>
            </div>

            <div class="form-group">
                <label for="amount">Количество</label>
                <input type="number" id="amount" name="amount" class="form-control" required/>
            </div>
            <div class="form-group">
                <label for="file">Обложка книги</label>
                <input type="file" id="file" name="file" class="form-control-file"/>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" class="btn btn-primary" style="background-color:pink; border-color: pink; color: black">Добавить книгу</button>
        </form>
    </div>

</@t.template>
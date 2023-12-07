document.addEventListener("DOMContentLoaded", function() {
    document.querySelectorAll('.product-checkbox').forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
            console.log("Внутри1")
            const itemId = this.value;
            const selected = this.checked;
            const csrfToken = document.querySelector('meta[name="_csrf"]').content;
            const csrfHeader = document.querySelector('meta[name="_csrf_header"]').content;
            console.log("Внутри2")
            console.log(csrfToken)
            console.log(csrfHeader)

            fetch(`/cart/update-selection/${itemId}/${selected}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    [csrfHeader]: csrfToken  // Добавление CSRF токена в заголовок запроса
                }
            }).then(response => response.json())
                .then(data => {
                    document.getElementById('totalPrice').innerText = "Итоговая стоимость " + data.totalPrice; // Обновление итоговой стоимости
                }).catch(error => {
                console.error('Ошибка:', error);
            });
        });
    });
});

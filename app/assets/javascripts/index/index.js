$("body").on("click", ".new_post input[type=submit]", function (e) {
    e.preventDefault();
   var form = $(e.target).closest("form"),
       url = form.attr("action"),
       form_data = new FormData(form.get(0));

    $.ajax({
        type: "POST",
        url: url,
        dataType: "json",
        data: form_data,
        contentType: false,
        processData: false,
        success: function (data) {
            console.log(data);
        }
    });
});
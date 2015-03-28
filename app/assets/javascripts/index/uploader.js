$(function() {
    var btn = $("#imageBrowse");
    var form = btn.closest("form");
    var wrapper = btn.closest("#uploaderWrapper");
    var url = form.attr("action");
    var uploader = new plupload.Uploader({
        browse_button: btn.get(0),
        url: url,
        multi_selection: false,
        filters : [
            {title : "Image files", extensions : "jpg,gif,png"}
        ],
        multipart_params: {},
        file_data_name: "post[image]"
    });
    uploader.init();


    //Adding new file markup
    uploader.bind('FilesAdded', function(up, files) {
        if(files.length <= 1) {
            var p = $("<p/>").attr("id", files[0].id);
            p.html(files[0].name + ' (' + plupload.formatSize(files[0].size) + ')<b></b>');
            wrapper.empty().append(p);
        }
    });

    //Storing uploaded files id's for later attaching with entity
    uploader.bind("FileUploaded", function(up, file, data) {
        $(".posts_wrapper").html(data.response);
    });

    uploader.bind('UploadProgress', function(up, file) {
        wrapper.find("#"+file.id).find('b').html(file.percent + "%");
    });

    uploader.bind('Error', function(up, err) {
        wrapper.find('.console').innerHTML += "\nError #" + err.code + ": " + err.message;
    });

    $("body").on("click", "#submit_btn", function (e) {
        e.preventDefault();
        setFormData(uploader, form);
        uploader.start();
    });

    function setFormData(up, form) {
        var inputs = form.find("input, textarea");
        console.log(up);
        inputs.each(function(key, el) {
            console.log(el.name);
            up.settings.multipart_params[el.name] = el.value;
        });
    }

});
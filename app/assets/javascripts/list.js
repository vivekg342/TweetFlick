$(function(){

function filterCelebs() {
        if ($(".tagChecked").size() > 0) {
            tagClass = "";
            $(".tagChecked").each(function (index) {
                tag = $(this).text().trim();
                tagClass +=  '.' + tag + '_tag';
            });
            $(tagClass).fadeIn();
            $('.listCeleb').not(tagClass).fadeOut();
        } else {
            $('.listCeleb').fadeIn();
        }

    }
$('#inpSearch').watermark('Search for a celebrity');
    $('#inpSearch').keyup(function () {
        text = $('#inpSearch').val();
        if (text) {
            $('div.listCeleb').not(':contains(' + text + ')').fadeOut();
        } else {
            $('.listCeleb').fadeIn();
        }
    });
    $('#toggleTags').click(function () {
        $('#fixedTags').show('fade', {}, 1000);
    });
    $('#closefixedTag').click(function () {
        $('#fixedTags').hide('fade', {}, 1000);
    });
    $('#fixedTags').blur(function () {
        $('#fixedTags').hide('fade', {}, 1000);
    })

    $(".tags").click(function () {
        if ($(this).hasClass("tagChecked")) {
            $(this).removeClass("tagChecked");
        } else {
            $(this).addClass("tagChecked");
        }

        filterCelebs();
    });

$('#clearTags').click(function(){
$(".tags").removeClass('tagChecked');
filterCelebs();
});

});

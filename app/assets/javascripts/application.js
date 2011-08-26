//= require jquery
//= require jquery_ujs

jQuery.expr[':'].contains = function (a, i, m) {
    return jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
};

function showMessage(message) {
    $("div#divMessage").fadeToggle('slow');
    $("#message").html(message);
}

function hideMessage() {
    $("#divMessage").fadeToggle('slow');
    $("#message").html('');
}

function showLoadingImage() {

    //  $('.blockElements').block({ message: null, overlayCSS: { backgroundColor: 'transparent'} });
    $('div#loading').css('display', 'block');
}

function getDate(epoch) {
    var myDate = new Date(epoch * 1);
    // myDate.toLocaleString();
    // myDate.toGMTString();
    return humane_date(myDate);
}

function hideLoadingImage() {
    $('div#loading').css('display', 'none');
    //$('.blockElements').unblock();
    // $.unblockUI();
}



var tweetURL = '';

function openTweetDialog(ele, id) {
    element = $(ele);
    val = (element.parents('div.tweetBody').find('div.divName').html());
    $('#tweet').val('@' + val + ' ');
    tweetURL = "/tweets/reply/" + id;
    $("#dialog-tweet").dialog("open");
}
var showDate = function showDate() {
        $('.divTime').each(function (index) {
            epoch = $(this).find('span.epoch');
            ltime=$(this).find('span.ltime');
            ltime.html(getDate(epoch.html()));
            
        });

    }



function showPreview(id) {
    $('.preview').hide();
    $(id).show();

}
//= require jquery
//= require jquery_ujs
//= require "jquery.watermark.min"
$(function(){
jQuery.expr[':'].contains = function (a, i, m) {
    return jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
};

$("body").not('#divSearch').click(function (evt) {
 $('div#searchResults').html('');
$('div#searchResults').hide();  
$('#inpSrch').val('');
});
$('#divSearch').blur(function() {
 $('div#searchResults').html('');
$('div#searchResults').hide();
});
$('#inpSrch').watermark('Search for a celebrity');
$('#inpSrch').keyup(function (event) {

key=event.keyCode;
keychar = String.fromCharCode(key);
keychar = keychar.toLowerCase();

// alphas and numbers
 if ((("abcdefghijklmnopqrstuvwxyz0123456789").indexOf(keychar) > -1))
refreshSearch();


  
});
function positionFocus(key){
if ((key==null) || (key==0) || (key==8) || 
    (key==9) || (key==13) || (key==27) )
return;
}
function refreshSearch(){
 $('div#searchResults').html('');
   text = $('#inpSrch').val();

        if (text) {
           $('div#searchResults').addClass('loading');
		$('div#searchResults').show();
		keySearch(text);
        } else {
           $('div#searchResults').removeClass('loading');
	   $('div#searchResults').html('');
	   $('div#searchResults').hide();
        }
}
    $('.celeb_ajax').live('ajax:beforeSend', function (event, xhr, status) {
        showLoadingImage();
    });

    $('.celeb_ajax').live('ajax:complete', function (event, xhr, status) {
        json = $.parseJSON(xhr.responseText);
        hideLoadingImage();
        showMessage(json.message);
if(json.success=='login'){
window.location='/auth/twitter';
}

    });
    $('.celeb_ajax').live('ajax:error', function (event, xhr, status) {
        json = $.parseJSON(xhr.responseText);
        hideLoadingImage();
        showMessage("failed !");
    });


$("#dialog:ui-dialog").dialog("destroy");

    var tweet = $("#tweet"),
        allFields = $([]).add(tweet);
    tips = $(".validateTips");

    function updateTips(t) {
        tips.text(t).addClass("ui-state-highlight");
        setTimeout(function () {
            tips.removeClass("ui-state-highlight", 1500);
        }, 500);
    }

    function checkLength(o, n, min, max) {
        if (o.val().length > max || o.val().length < min) {
            o.addClass("ui-state-error");
            updateTips("Length of " + n + " must be between " + min + " and " + max + ".");
            return false;
        } else {
            return true;
        }
    }
    $("#dialog-tweet").dialog({
        autoOpen: false,
        height: 280,
        width: 650,
        modal: true,
        buttons: {
            "Reply": function () {
                var bValid = true;
                allFields.removeClass("ui-state-error");
                bValid = bValid && checkLength(tweet, "Tweet", 0, 139);
                if (bValid) {
                    showLoadingImage();
                    $.ajax({
                        type: 'POST',
                        url: tweetURL,
                        data: {
                            tweet: tweet.val()
                        },
                        dataType: 'json',
                        success: function (response, textStatus, XMLHttpRequest) {
                            hideLoadingImage();
                            showMessage(response.message);
			    if(json.success=='login'){
				window.location='/auth/twitter';
			     }
                        }
                    });
                    $(this).dialog("close");
                }
            },
            Cancel: function () {
                $(this).dialog("close");
            }
        },
        close: function () {
            allFields.val("").removeClass("ui-state-error");
        }
      });



$('#divCollapse').live('click',function(){
if($('#divLeft').hasClass('widthList')){
$('#divLeft').removeClass('widthList');
$('#divLeft').tinyscrollbar();
//$('#divCollapse').removeClass('widthCollapse');
}else{
$('#divLeft').addClass('widthList');
//$('#divCollapse').addClass('widthCollapse');

}
});
});
//if(!($.cookie('timezone'))) {
//  current_time = new Date();
//  $.cookie('timezone', current_time.getTimezoneOffset(), { path: '/', expires: 10 } );
//}
var searchresult=null;
function keySearch(s){
if(searchresult!=null){
$('div#searchResults').html('');
searchresult.abort();
}
searchresult =  $.ajax({
                        url: '/celebs/search/'+s,
                        dataType: 'json',
                        success: function (response, textStatus, XMLHttpRequest) {
			$('div#searchResults').removeClass('loading'); 			  
			displayResults(response);                       
			  
                        }
                    });

}
var focusElement=0;
function displayResults(response){
for (var i = 0; i <= response.length; i++) {
try{
var div=$('<a  class="display_box" href="/'+response[i].screenName+'"></a>');
div.html('<img style="float:left" src="'+response[i].profileImgUrl+'" width="32" height="32" />' + response[i].name +'</span>');
$('div#searchResults').append(div);
}catch(err){}
}
$('div#searchResults display_box:first').focus();
focusElement=0;
$('div#searchResults').append('<div class="display_box" align="center"><a href="/celebs/list"> <h2>View all celebs</h2></a></div>');

}
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
                            showLoadingImage();
    element = $(ele);
    val = (element.parents('div.tweetBody').find('input.screenName').val());
    tweetURL = "/tweets/reply/" + id;
  		$.ajax({
                        type: 'POST',
                        url: '/auth/check',
                        dataType: 'json',
                        success: function (response, textStatus, XMLHttpRequest) {
                            hideLoadingImage();
			    if(response.success=='true'){
				  $("#dialog-tweet").dialog("open");
				$('#tweet').focus();
				$('#tweet').val('@' + val + ' ');
			     }else{
				showMessage('Login required');
				window.location='/auth/twitter';
			     }
                        }
                    });
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

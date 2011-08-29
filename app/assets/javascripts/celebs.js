function fanCarousel(){
    showDate();
    if(!selectedDiv)
    selectedDiv=$('.divProfile');
selectedDiv.find('.divScrollable').jcarousel({
    vertical: true,
    start: 9,
	auto: 2,
        scroll: 1,
        itemFallbackDimension:75
  });
  }
$(function(){
 selectedDiv = $(".divProfile:first");
 flag=false;
path= selectedDiv.find('.hdnPath').val();

$(window).scroll(function () {
    if ($(window).scrollTop() >= $('#divTabs').height() - $(window).height()) {
        gettweets();
    }
});

fanCarousel();
var  images= $.parseJSON($('#hdnImages').val());
if(images && images.length>0){
      $('.ulGallery').jcarousel({
        scroll: 1,
        size:images.length,
        itemLoadCallback: {onBeforeAnimation: mycarousel_itemLoadCallback}
    });
  }
    $("#divLeft").tinyscrollbar();


    function mycarousel_itemLoadCallback(carousel, state) {
        for (var i = carousel.first; i <= carousel.last; i++) {
            if (carousel.has(i)) {
                continue;
            }

            if (i > images.length) {
                break;
            }

            carousel.add(i, images[i - 1]);
        }
    }

    function filterCelebs() {
        if ($(".tagChecked").size() > 0) {
            tagClass = "";
            $(".tagChecked").each(function (index) {
                tag = $(this).text().trim();
                tagClass += "," + '.' + tag + '_tag';
            });
            $(tagClass).fadeIn();
            $('.alphaCeleb').not(tagClass.substr(1, tagClass.length - 1)).fadeOut();
        } else {
            $('.alphaCeleb').fadeIn();
        }

    }
    $('#inpSearch').keyup(function () {
        text = $('#inpSearch').val();
        if (text) {
            $('div.alphaCeleb').not(':contains(' + text + ')').fadeOut();
        } else {
            $('.alphaCeleb').fadeIn();
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
    

    $('.celeb_ajax').live('ajax:beforeSend', function (event, xhr, status) {
        showLoadingImage();
    });

    $('.celeb_ajax').live('ajax:complete', function (event, xhr, status) {
        json = $.parseJSON(xhr.responseText);
        hideLoadingImage();
        showMessage(json.message);
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
        height: 300,
        width: 350,
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
    //Auto update every min
    window.setInterval(autoUpdate, 60000);

});
var autoUpdate=function autoupdate(){
getLatest();
}

function getLatest(){
lastTime = selectedDiv.find('.hdnLtstTime:first').val();
id=selectedDiv.find('.hdnprofile:first').val();
ltPath='/tweets/latest/'+lastTime+'/'+id;
$.get(ltPath, function (data) {
updateClient(data);
showDate();
        },"json"
);

}

function updateClient(data){
 selectedDiv.find('.hdnLtstTime').val(data.time);
celebs=data.celebs;
fans=data.fans;
if(celebs){
  
  tempdiv=$('<div style="display:none"></div>').html(celebs);
  tempdiv.prependTo(selectedDiv.find('.column1'));
  tempdiv.fadeIn(3000);
}
var carousel = $('.divScrollable').data('jcarousel');
if(fans){
tempdiv=$('<div style="display:none"></div>').html(fans);
pos=tempdiv.find('li').size()+carousel.first;
//tempdiv.find('li').each(function (index) {
//carousel.add(0, $(this).html());
//$('.divScrollable li:first').addClass('divFan divTweet ui-corner-all');
//});
//tempdiv.remove();
$('.divScrollable').prepend(fans);
carousel.reload();
carousel.scroll(pos,true);
}

}



function getmorefantweets() {
    fts = $(selectedDiv).find('.divScrollable');
    $.get(fanpath, function (data) {
        fts.append(data);
    });
}

function gettweets() {
    //pt=$(this).parents('.divFeedLast');
            path= selectedDiv.find('.hdnPath:last').val();
    if (!flag) {
        flag = true;
        pt = $(selectedDiv).find('.column1');
        pt.append('<div class="loading"></div>')
        $.get(path, function (data) {
            pt.append(data);
            pt.find('.loading').remove();
            flag = false;
        });
    }
}

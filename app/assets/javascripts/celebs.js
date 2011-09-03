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
var carousel=selectedDiv.find('.divScrollable').data('jcarousel');
if(carousel){
carousel.clip.hover(function() {
carousel.stopAuto();
}, function() {
carousel.startAuto();
});
}
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
$('#noteImage').show();
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

if(fans){
var carousel = $('.divScrollable').data('jcarousel');
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

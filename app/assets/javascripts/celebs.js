function fanCarousel(){
    showDate();
    if(!selectedDiv)
    selectedDiv=$('.divProfile');
selectedDiv.find('.divScrollable').jcarousel({
    vertical: true,
    size:50,
    start: 9,
	auto: 3,
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
        showDate();
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
tempdiv=$('<div style="display:none"></div>').html(fans);
pos=tempdiv.find('li').size();
   
var li = carousel.list.children('li');

        if (li.size() > 0) {
		wh = 0, j =pos+1;
		divScroll.find('li').each(function() {
                carousel.format(this, j++);
           	 });
        }
liFans=tempdiv.find('li');
for (var i = 1; i <= liFans.size(); i++) {
            if (carousel.has(i)) {
                continue;
            }

         

            carousel.add(i, liFans[i - 1]);
        }
size= li.size()+liFans.size();
if(size>50)size=50;
carousel.options.size =size;
carousel.scroll(pos+carousel.first,false);

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

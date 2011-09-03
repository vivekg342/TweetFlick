
function getmorefantweets() {
    fts = selectedDiv.find('.divScrollable');
    $.get(fanpath, function (data) {
        fts.append(data);
    });
}
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

function gettweets() {
    //pt=$(this).parents('.divFeedLast');
            path= selectedDiv.find('.hdnPath:last').val();
    if (!flag) {
        flag = true;
        pt = selectedDiv.find('.column1');
        pt.append('<div class="loading"></div>')
        $.get(path, function (data) {
            pt.append(data);
            pt.find('.loading').remove();
            flag = false;
        });
    }
}


  
  

$(function(){

 selectedDiv = $("#divFeed");
 flag=false;
var path= selectedDiv.find('.hdnPath:last').val();
        
$(window).scroll(function () {
    if ($(window).scrollTop() >= $('#divTabs').height() - $(window).height()) {
        gettweets();
    }
});
//Fan Carousel
fanCarousel();
//Gallery carousel
var  images= $.parseJSON($('#hdnImages').val());
      selectedDiv.find('.ulGallery').jcarousel({
        scroll: 1,
         size:images.length,
        itemLoadCallback: {onBeforeAnimation: mycarousel_itemLoadCallback}
    });
    
var weekstats=$.parseJSON($('#hdnweekstats').val());
//var fanweekstats=$.parseJSON($('#hdnfanweekstats').val());
var jqArray=[];
var fanArray=[];
var ticks=[];
for (var i = 0; i < weekstats.length; i++) {
//weekstats[i].day
//ticks.push(weekstats[i].day);
 d=new Date();
d.setFullYear(weekstats[i].year,weekstats[i].month,weekstats[i].index);
str='<a href="/tweets/archive/'+weekstats[i].epoch +'">'+weekstats[i].day+'</a>';
ticks.push(unescape(str));
        jqArray.push(weekstats[i].tweets);
//  fanArray.push(fanweekstats[i].tweets);
    }
    
     var plot1 = $.jqplot ('divChartStats', [jqArray],{
      axes: {
            // Use a category axis on the x axis and use our custom ticks.
            xaxis: {
                renderer: $.jqplot.CategoryAxisRenderer,
                ticks: ticks,
                escapeHTML:true
            },
            yaxis:{min:0,
                tickOptions: {formatString: '%d'}}
            },
            seriesDefaults: {
        showMarker:false,
        pointLabels: { show:true }
      }
});

var vertTabs=$("#vertTabs").tabs({fx: { opacity: "toggle"}
                                   })
                            .addClass('ui-tabs-vertical ui-helper-clearfix')
                           .tabs("rotate", 2000, false);
               $("#vertTabs").removeClass('ui-corner-top').removeClass('ui-widget-content ui-widget').addClass('ui-corner-left');



  


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

    //Auto update every min
    window.setInterval(autoUpdate, 60000);

});

var autoUpdate=function autoupdate(){

getLatest();

}
function getLatest(){
lastTime = selectedDiv.find('.hdnLtstTime:first').val();
iddiv=selectedDiv.attr('id');
if(iddiv!='divFeed'){
id=iddiv.substr(3,iddiv.length-1);
ltPath='/tweets/latest/'+lastTime+'/'+id;
}
else {
ltPath='/tweets/latest/'+lastTime;
}
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
 divScroll=selectedDiv.find('.divScrollable');
var carousel = divScroll.data('jcarousel');
if(fans){
tempdiv=$('<div style="display:none"></div>').html(fans);
pos=tempdiv.find('li').size()+carousel.first;
//tempdiv.find('li').each(function (index) {
//carousel.add(0, $(this).html());
//$('.divScrollable li:first').addClass('divFan divTweet ui-corner-all');
//});
//tempdiv.remove();
divScroll.prepend(fans);
carousel.reload();
carousel.scroll(pos,true);
}

}


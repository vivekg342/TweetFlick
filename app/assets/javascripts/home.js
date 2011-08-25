
  
  function showCeleb(path,id,label){
     //showLoadingImage();
    tabCount = $('#divTabs ul li').size();
    if($('#div'+id).length>0){
$('#divTabs').tabs("select",'div'+id);
     
    }
    else {

       $('#divTabs').append("<div id=\"div"+id+"\" class=\"loading tabCeleb\"></div>");
       $('#divTabs').tabs("add","#div"+id,label);
$('#divTabs').tabs("select",'div'+id);
    }
    selectedDiv.find('.ulGallery').jcarousel({scroll: 1 });
    
  selectedDiv = $("#div"+id);
  $("#div"+id).load(path,function(){
          $("#div"+id).removeClass("loading");
        });
  }
  function getmorefantweets(){
    fts=selectedDiv.find('.divScrollable');
    $.get(fanpath, function(data) {
    fts.append(data);
    });
  }

  function gettweets(path){
    //pt=$(this).parents('.divFeedLast');
if(!flag){
flag=true;
    pt=selectedDiv.find('.column1');
    pt.append('<div class="loading"></div>')
    $.get(path, function(data) {
    pt.append(data);
    pt.find('.loading').remove();
     flag=false;
  });
}
  }



  $(window).scroll(function(){
		if($(window).scrollTop() >= $('#divTabs').height() - $(window).height()){
                        gettweets(path);
		}
	});

 var tweetURL='';
function openTweetDialog(ele,id) {
  element =$(ele);
  val=(element.parents('div.tweetBody').find('div.divName').html());
  $('#tweet').val('@'+val+' ');
      tweetURL= "/tweets/reply/"+id;
	$( "#dialog-tweet" ).dialog( "open" );
			}
var showDate=function showDate(){
  $('.divTime span.epoch').each(function(index)
    {
      epoch= $(this);
        epoch.html(getDate(epoch.html()));
        epoch.removeClass('epoch');
    });

 }
  $(function(){
     selectedDiv = $("#divFeed");
 flag=false;
      selectedDiv.find('.ulGallery').jcarousel({scroll: 1 });
    
$("#divLeft").tinyscrollbar();
var $tabs=$('#divTabs').tabs(
{tabTemplate: "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close' style='float:right'>Remove Tab</span></li>"}
);

function filterCelebs(){
  if($(".tagChecked").size()>0){
tagClass="";
    $(".tagChecked").each(function(index){
      tag=$(this).text().trim();
      tagClass+=","+'.'+tag+'_tag';
    });
    $(tagClass).fadeIn();
    $('.alphaCeleb').not(tagClass.substr(1,tagClass.length -1)).fadeOut();
  }
  else{
    $('.alphaCeleb').fadeIn();
  }

}
$('#inpSearch').keyup(function() {
text=$('#inpSearch').val();
if(text){
$('div.alphaCeleb').not(':contains('+text+')').fadeOut();
  }
  else{
    $('.alphaCeleb').fadeIn();
  }
});
$('#toggleTags').click(function(){
$('#fixedTags').show('fade',{},1000);
});
$('#closefixedTag').click(function(){
$('#fixedTags').hide('fade',{},1000);
});
$('#fixedTags').blur(function(){
$('#fixedTags').hide('fade',{},1000);
})

$( ".tags" ).click(function(){
  if($(this).hasClass("tagChecked")){
    $(this).removeClass("tagChecked");
  }else{
    $(this).addClass("tagChecked");
  }

  filterCelebs();
});
  $( "#divTabs span.ui-icon-close" ).live( "click", function() {
			var index = $( "li", $tabs ).index( $( this ).parent() );
			$tabs.tabs( "remove", index );
		});
                
        $('.celeb_ajax').live('ajax:beforeSend', function(event, xhr, status) {
    showLoadingImage();
});

$('.celeb_ajax').live('ajax:complete', function(event, xhr, status) {
    json=$.parseJSON(xhr.responseText);
    hideLoadingImage();
    showMessage(json.message);
});
$('.celeb_ajax').live('ajax:error', function(event, xhr, status) {
    json=$.parseJSON(xhr.responseText);
    hideLoadingImage();
    showMessage("failed !");
});

$( "#dialog:ui-dialog" ).dialog( "destroy" );

		var tweet = $( "#tweet" ),
                allFields = $( [] ).add( tweet );
			tips = $( ".validateTips" );

		function updateTips( t ) {
			tips
				.text( t )
				.addClass( "ui-state-highlight" );
			setTimeout(function() {
				tips.removeClass( "ui-state-highlight", 1500 );
			}, 500 );
		}

		function checkLength( o, n, min, max ) {
			if ( o.val().length > max || o.val().length < min ) {
				o.addClass( "ui-state-error" );
				updateTips( "Length of " + n + " must be between " +
					min + " and " + max + "." );
				return false;
			} else {
				return true;
			}
		}
		$( "#dialog-tweet" ).dialog({
			autoOpen: false,
			height: 300,
			width: 350,
			modal: true,
			buttons: {
				"Reply": function() {
					var bValid = true;
					allFields.removeClass( "ui-state-error" );
					bValid = bValid && checkLength( tweet, "Tweet", 0, 139 );
					if ( bValid ) {
                                          showLoadingImage();
                                          $.ajax({
                                          type: 'POST',
                                          url: tweetURL,
                                          data: {
                                              tweet: tweet.val()
                                          },
                                          dataType:'json',
                                          success: function(response, textStatus, XMLHttpRequest) {
                                              hideLoadingImage();
                                              showMessage(response.message);
                                          }
                                      });
						$( this ).dialog( "close" );
					}
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
			}
		});
//UPdate time every min
	window.setInterval(showDate, 60000);

  });
 

  function showPreview(id){
$('.preview').hide();
$(id).show();

  }

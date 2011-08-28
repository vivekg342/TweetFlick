
$(function(){
  
      $("#divLeft").tinyscrollbar();
      
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
    
  });
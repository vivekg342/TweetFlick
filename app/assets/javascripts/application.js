//= require jquery
//= require jquery_ujs
//= require_tree



jQuery.expr[':'].contains = function (a, i, m)
{
    return jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase())>=0;
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
function getDate(epoch)
 {
 var myDate = new Date(epoch *1);
 time = myDate.toLocaleString();
 
 //return prettyDate(myDate);
 //return time;
 return humane_date(myDate.toString());
 }

    function hideLoadingImage() {
        $('div#loading').css('display', 'none');
         //$('.blockElements').unblock();
       // $.unblockUI();
    }

   



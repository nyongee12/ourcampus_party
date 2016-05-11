$(document).ready(function(){
  
  var footer_height = $('#footer').height();

  var window_height = $(window).height(); 
  var container_box_height = $('.container-box').height();
  
//   var bottom_margin_window_short = window_height - container_box_height;
  
  var window_width = $(window).width();

    //  내용이 윈도우 한페이지에 들어갈 때

     if( window_height > container_box_height) {
      
        // 웹
        if ( window_width  > 600 ) {            
            $("#footer").css("margin-top", "168px");  
        } 
                
     }
});

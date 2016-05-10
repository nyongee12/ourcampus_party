$(document).ready(function(){
  
  var footer_height = $('#footer').height();

  var box1 = $(".background-filter").height();
  var box2 = $(".navbar").height();
  var box3 = $(".content-box").height();
  var box4 = $(".paginate").height();
  var box5 = $(".fb-like").height();
  
  var window_height = $(window).height(); 
  var container_box_height = $('.container-box').height();
  
  var bottom_padding_window_short = window_height - container_box_height;
  var bottom_padding_window_long = (box1 + box2 + box3 + box4 + box5) - container_box_height + footer_height;
  
  
  var window_width = $(window).width();

     if( window_height > container_box_height) {
      //웹에서 늘리기
        if ( window_width  > 600 ) {
            $(".content-box").css("padding-bottom", bottom_padding_window_short);
        } else {
            $(".content-box").css("padding-bottom", bottom_padding_window_long+60);
        }
     } else {
       if( window_width  > 600) {
        //웹용
         $(".content-box").css("padding-bottom", bottom_padding_window_long);
       }
       else {
           //모바일용
         $(".content-box").css("padding-bottom", bottom_padding_window_long+30);
       }

     }
});

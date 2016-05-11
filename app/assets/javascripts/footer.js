$(document).ready(function(){
  
  var footer_height = $('#footer').height();

  var box1 = $(".background-filter").height();
  var box2 = $(".navbar").height();
  var box3 = $(".content-box").height();
  var box4 = $(".paginate").height();
  var box5 = $(".fb-like").height();
  
  var box6 = $("#detail-title").height();
  var box7 = $(".map-icon").height();
  
  var window_height = $(window).height(); 
  var container_box_height = $('.container-box').height();
  
  var bottom_padding_window_short = window_height - container_box_height;
  var bottom_padding_window_long1 = (box1 + box2 + box3 + box4 + box5 ) - container_box_height + footer_height;
  var bottom_padding_window_long2 = (box2 + box3 + box6 + box7 + 50 ) - container_box_height + footer_height;
  
  var window_width = $(window).width();
<<<<<<< HEAD
  
    //  내용이 윈도우 한페이지에 들어갈 때
=======

>>>>>>> 88c290017c909107aecfc285145ee28bf5b39545
     if( window_height > container_box_height) {
      
        // 웹
        if ( window_width  > 600 ) {
<<<<<<< HEAD
            $(".content-box").css("padding-bottom", bottom_padding_window_short);  
        } 
        // 모바일
        else {
            $(".content-box").css("padding-bottom", bottom_padding_window_long2);  
=======
            $(".content-box").css("padding-bottom", bottom_padding_window_short);
        } else {
            $(".content-box").css("padding-bottom", bottom_padding_window_long+60);
>>>>>>> 88c290017c909107aecfc285145ee28bf5b39545
        }
        
     }
    //  내용이 윈도우 한페이지에 안 들어갈 때
     else {
        //웹용
<<<<<<< HEAD
       if( window_width  > 600) {
         $(".content-box").css("padding-bottom", bottom_padding_window_long1 + 10);   
       }
       //모바일용
       else { 
         $(".content-box").css("padding-bottom", bottom_padding_window_long1 + 30);   
=======
         $(".content-box").css("padding-bottom", bottom_padding_window_long);
       }
       else {
           //모바일용
         $(".content-box").css("padding-bottom", bottom_padding_window_long+30);
>>>>>>> 88c290017c909107aecfc285145ee28bf5b39545
       }

     }
});

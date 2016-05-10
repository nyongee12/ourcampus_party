function submitForm() {
    $.ajax({
      url: '/home/add_search',
      data: {
        univ: $('form #univ').val(),
        from: $('form #from').val(),
        to: $('form #to').val(),
        celeb: $('form #celeb').val(),
        keyword: $('form #keyword').val()
      },
      success: function(data) {
        if( data.result == true )
          $('#search-result tr.result-item').remove();
      },
      error : function(xhr, status, error) {
        alert("에러발생");
      }
    });
}

$(document).ready(function() {
  $('nav.pagination a.avail').click(function() {
    $('#loading').fadeIn('fast');
  });
});


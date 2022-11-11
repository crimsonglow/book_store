$(document).ready(function () {
  $('.minus').click(function(e){
    var current_value = $('.input-count-book').val();
    if (current_value >= 2) {
      var new_value = Number(current_value) - 1;
      $('.input-count-book').val(new_value);
    }
  })

  $('.plus').click(function(e){
    var current_value = $('.input-count-book').val();
    if (current_value < 10) {
      var new_value = Number(current_value) + 1;
      $('.input-count-book').val(new_value);
    }
  })

$('.read-more').click(function(element) {
  element.preventDefault()
  $(this).parent().find('.truncated-paragraph').hide()
  $(this).parent().find('.normal-paragraph').show()
  $(this).hide()
  $(this).parent().find('.read-less').show()
})
$(".read-less").hide(); 
  $('.read-less').click(function(element) {
    element.preventDefault()
    $(".read-less").toggle();
    $(this).parent().find('.truncated-paragraph').show()
    $(this).parent().find('.normal-paragraph').hide()
    $(this).hide()
    $(this).parent().find('.read-more').show()
  })

function elId(element) {
  let elClassName = element.attr('class').split('-')
  return elClassName[elClassName.length - 1]
}

})

$(function() {
  $(".home-title").click(function(){
    var $ht=$(".home-text");
    if($ht.hasClass("active")){
      $ht.slideDown();
      $ht.removeClass("active");
    }else{
      $ht.addClass("active");
      $ht.slideUp();
    }
  });
});

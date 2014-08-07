$(document).on('page:change', function () {
  setTimeout(function() {
      $(".quero").height($('.heinzhd').innerHeight());
      $(".heinz").height($('.querohd').innerHeight());
  }, 10)
  setTimeout(function() {
      $(".quero").height($('.heinzhd').innerHeight());
      $(".heinz").height($('.querohd').innerHeight());
  }, 100)
  setTimeout(function() {
      $(".quero").height($('.heinzhd').innerHeight());
      $(".heinz").height($('.querohd').innerHeight());
  }, 300)
  setTimeout(function() {
      $(".quero").height($('.heinzhd').innerHeight());
      $(".heinz").height($('.querohd').innerHeight());
  }, 500)
  setTimeout(function() {
      $(".quero").height($('.heinzhd').innerHeight());
      $(".heinz").height($('.querohd').innerHeight());
  }, 1000)
  $( window ).resize(function() {
    $(".quero").height($('.heinzhd').innerHeight());
    $(".heinz").height($('.querohd').innerHeight());
  });
  $(".field_with_errors").addClass("has-error");
  $('.heinzsmall').on('click', function(e) {
    e.preventDefault();
    $('.heinz').children().toggle();
    $('.querohd').children().toggle();
    $('.querohd').toggleClass('col-sm-10 col-sm-2');
    $('.heinz').toggleClass('col-sm-2 col-sm-10');
    setTimeout(function() {
      window.location = "/heinz"
    }, 500);
  });
  $('.querosmall').on('click', function(e) {
    e.preventDefault();
    $('.heinzhd').children().toggle();
    $('.quero').children().toggle();
    $('.quero').toggleClass('col-sm-10 col-sm-2');
    $('.heinzhd').toggleClass('col-sm-2 col-sm-10');
    setTimeout(function() {
      window.location = "/quero"
    }, 500);
  });
  $('.queroopt').on('click', function(e) {
    e.preventDefault();
    $('.heinz').children().toggle();
    $('.quero').children().toggle();
    $('.quero').toggleClass('col-sm-6 col-sm-10');
    $('.heinz').toggleClass('col-sm-6 col-sm-2');
    setTimeout(function() {
      window.location = "/quero"
    }, 400);
  });
  $('.heinzopt').on('click', function(e) {
    e.preventDefault();
    $('.heinz').children().toggle();
    $('.quero').children().toggle();
    $('.quero').toggleClass('col-sm-6 col-sm-2');
    $('.heinz').toggleClass('col-sm-6 col-sm-10');
    setTimeout(function() {
      window.location = "/heinz"
    }, 400);
  });
});

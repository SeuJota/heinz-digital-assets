$(document).on('page:change', function () {
  $(".field_with_errors").addClass("has-error");
  $('.heinzsmall').on('click', function(e) {
    e.preventDefault();
    $('.heinz').children().fadeOut("fast");
    $('.querohd').children().fadeOut("fast");
    $('.querohd').toggleClass('col-sm-10 col-sm-2');
    $('.heinz').toggleClass('col-sm-2 col-sm-10');
    setTimeout(function() {
      window.location = "/heinz"
    }, 500);
  });
  $('.querosmall').on('click', function(e) {
    e.preventDefault();
    $('.heinzhd').children().fadeOut("fast");
    $('.quero').children().fadeOut("fast");
    $('.quero').toggleClass('col-sm-10 col-sm-2');
    $('.heinzhd').toggleClass('col-sm-2 col-sm-10');
    setTimeout(function() {
      window.location = "/quero"
    }, 500);
  });
  $('.queroopt').on('click', function(e) {
    e.preventDefault();
    $('.heinzhd').children().fadeOut("fast");
    $('.querohd').children().fadeOut("fast");
    $('.querohd').toggleClass('col-sm-6 col-sm-10');
    $('.heinzhd').toggleClass('col-sm-6 col-sm-2');
    setTimeout(function() {
      window.location = "/quero"
    }, 500);
  });
  $('.heinzopt').on('click', function(e) {
    e.preventDefault();
    $('.heinzhd').children().fadeOut("fast");
    $('.querohd').children().fadeOut("fast");
    $('.querohd').toggleClass('col-sm-6 col-sm-2');
    $('.heinzhd').toggleClass('col-sm-6 col-sm-10');
    setTimeout(function() {
      window.location = "/heinz"
    }, 500);
  });
});

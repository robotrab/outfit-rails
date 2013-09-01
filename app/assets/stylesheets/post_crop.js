$(function() {
  var global_x;
  var global_y;
  var global_w;
  var global_h;
  var jcrop_api;

  function blackNote() {
    return $(document.createElement('span'))
      .text('TEST');
  }

  $('div.viewport').annotatableImage(blackNote);

  $('#cropButton').click(function(){
    var that = $(this);
    var img = $('#uploadPreview');
    if( that.text() === "Crop" ) {
      setViewport(img[0], 0, 0, img.naturalWidth, img.naturalHeight);
      $('div.viewport').css({ 'width': '', 'height': '' });
      img.Jcrop({
        onChange: update_crop,
        onSelect: update_crop
      }, function(){
        jcrop_api = this;
      });
      that.text("Done Cropping");
    }
    else {
      jcrop_api.destroy();
      setViewport(img[0], global_x, global_y, global_w, global_h);
      that.text("Crop");
      var annotations = $('div.viewport span').seralizeAnnotations();
      $('div.viewport').addAnnotations(blackNote, annotations);
    }
  });

  function setViewport(img, x, y, width, height) {
    img.style.left = "-" + x + "px";
    img.style.top  = "-" + y + "px";

    if (width !== undefined) {
        img.parentNode.style.width  = width  + "px";
        img.parentNode.style.height = height + "px";
    }
    $(img).css({'display' : '', 'visibility' : '',
      'max-width': 'auto', 'position': 'absolute'});
  }

  function update_crop(coords) {
    var img = $('#uploadPreview');
    var ratio = img[0].naturalWidth / img.width();
    $('#crop_x').val(Math.round(coords.x * ratio));
    $('#crop_y').val(Math.round(coords.y * ratio));
    $('#crop_w').val(Math.round(coords.w * ratio));
    $('#crop_h').val(Math.round(coords.h * ratio));

    global_x = coords.x;
    global_y = coords.y;
    global_w = coords.w;
    global_h = coords.h;
    //SHIFT LEFT AND TOP OF ANNOTATIONS BASED ON NEW IMAGE WIDTHS
    // $('div.viewport.span').each(function() {
    //   $(this).css("left", "+="+coords.x);
    //   $(this).css("top", "+="+coords.y);
    // });
  }
});

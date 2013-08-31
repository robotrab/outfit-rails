$(function() {
  $('#cropbox').Jcrop({
    onChange: update_crop,
    onSelect: update_crop
  });

  function update_crop(coords) {
    var rx = 100/coords.w;
    var ry = 100/coords.h;
    $('#preview').css({
      width: Math.round(rx * <%= @post.image_geometry(:profile).width %>) + 'px',
      height: Math.round(ry * <%= @post.image_geometry(:profile).height %>) + 'px',
      marginLeft: '-' + Math.round(rx * coords.x) + 'px',
      marginTop: '-' + Math.round(ry * coords.y) + 'px'
    });

    var ratio = <%= @post.image_geometry(:original).width %> / <%= @post.image_geometry(:profile).width %>;
    $('#crop_x').val(Math.floor(coords.x * ratio));
    $('#crop_y').val(Math.floor(coords.y * ratio));
    $('#crop_w').val(Math.floor(coords.w * ratio));
    $('#crop_h').val(Math.floor(coords.h * ratio));
  }

  // var global_x;
  // var global_y;
  // var global_w;
  // var global_h;
  // var jcrop_api;


  // $('#cropButton').click(function(){
  //   var that = $(this);
  //   var img = $('#uploadPreview');
  //   if( that.text() === "Crop" ) {
  //     setViewport(img[0], 0, 0, img.naturalWidth, img.naturalHeight);
  //     $('div.viewport').css({ 'width': '', 'height': '' });
  //     img.Jcrop({
  //       onChange: update_crop,
  //       onSelect: update_crop
  //     }, function(){
  //       jcrop_api = this;
  //     });
  //     that.text("Done Cropping");
  //   }
  //   else {
  //     jcrop_api.destroy();
  //     setViewport(img[0], global_x, global_y, global_w, global_h);
  //     that.text("Crop");
  //   }
  // });

  // function setViewport(img, x, y, width, height) {
  //   img.style.left = "-" + x + "px";
  //   img.style.top  = "-" + y + "px";

  //   if (width !== undefined) {
  //       img.parentNode.style.width  = width  + "px";
  //       img.parentNode.style.height = height + "px";
  //   }
  //   $(img).css({'display' : '', 'visibility' : '',
  //     'max-width': 'auto', 'position': 'absolute'});
  // }

  // function update_crop(coords) {
  //   var img = $('#uploadPreview');
  //   var ratio = img[0].naturalWidth / img.width();
  //   $('#crop_x').val(Math.round(coords.x * ratio));
  //   $('#crop_y').val(Math.round(coords.y * ratio));
  //   $('#crop_w').val(Math.round(coords.w * ratio));
  //   $('#crop_h').val(Math.round(coords.h * ratio));

  //   global_x = coords.x;
  //   global_y = coords.y;
  //   global_w = coords.w;
  //   global_h = coords.h;
  //   //SHIFT LEFT AND TOP OF ANNOTATIONS BASED ON NEW IMAGE WIDTHS
  // }
});

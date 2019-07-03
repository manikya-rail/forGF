$(document).on('turbolinks:load', function() {
  $(".logo-field").change(function(){
    var imageDiv = $('.logo.image-division');
    if (this.files.length > 0) {
      var reader = new FileReader();
      reader.onload = function (e) {
        if (window.location.href.indexOf('edit') < 0){
          $('.uploaded-logo-image.course-create-image').attr('src', e.target.result).removeClass('hide');
          $(imageDiv).find('.close-cross').removeClass('hide');
        }else{
          if ($('.logo .course-logo-image.cimage').length != 0){
            $('.logo .course-logo-image.cimage').attr('src', e.target.result);
          }else{
            $(imageDiv).append("<span class='close-cross'>&times;</span> <img src='"+e.target.result+"' class='course-logo-image cimage'>");
          }
        }
      }
      reader.readAsDataURL(this.files[0]);
    }
  });

  $(".cover-field").change(function(){
    var imageDiv = $('.cover.image-division');
    if (this.files.length > 0) {
      var reader = new FileReader();
      reader.onload = function (e) {
        if (window.location.href.indexOf('edit') < 0){
          $('.uploaded-cover-image.course-create-image').attr('src', e.target.result).removeClass('hide');
          $(imageDiv).find('.close-cross').removeClass('hide');
        }else{
          if ($('.cover .course-logo-image.cimage').length != 0){
            $('.cover .course-logo-image.cimage').attr('src', e.target.result);
          }else{
            $(imageDiv).append("<span class='close-cross'>&times;</span> <img src='"+e.target.result+"' class='course-logo-image cimage'>");
          }
        }
      }
      reader.readAsDataURL(this.files[0]);
    }
  });

  $(".score-card-field").change(function(){
    var PhotoCollection, divClass, imageClass;
    if (window.location.href.indexOf('edit') < 0){
      PhotoCollection = $('.score-collection');
      divClass = 'image-division';
      imageClass = 'course-create-image uploaded-photo-image';
    }else{
      PhotoCollection = $('.temp-score-collection');
      divClass = 'upload-division';
      imageClass = 'edit-temp-uploaded-photos';
    }
    if (this.files && this.files[0]) {
      $.each(this.files, function(index, data) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $(PhotoCollection).append("<div class='"+ divClass +"'><span class='close-cross'>&times;</span> <img src='"+e.target.result+"' class='"+ imageClass +"'><br></div>");
        }
        reader.readAsDataURL(data);
      });
    }
  });

  $(".trans-logo-field").change(function(){
    var imageDiv = $('.trans.image-division');
    if (this.files.length > 0) {
      var reader = new FileReader();
      reader.onload = function (e) {
        if (window.location.href.indexOf('edit') < 0){
          $('.uploaded-trans-image.course-create-image').attr('src', e.target.result).removeClass('hide');
          $(imageDiv).find('.close-cross').removeClass('hide');
        }else{
          if ($('.trans .course-logo-image.cimage').length != 0){
            $('.trans .course-logo-image.cimage').attr('src', e.target.result);
          }else{
            $(imageDiv).append("<span class='close-cross'>&times;</span> <img src='"+e.target.result+"' class='course-transparent-logo-image cimage'>");
          }
        }
      }
      reader.readAsDataURL(this.files[0]);
    }
  });

  $(".edit_course").on('click', '.remove_logo', function(){
    var course_id = $(this).attr('data-course-id');
    $(this).addClass('hide');
    $(this).closest('div.logo-preview').find("img.course-photo-images").remove();
    $.ajax({
      url: "/admin/courses/remove_course_image",
      type: "POST",
      data: {course_id: course_id, for: "transparent"},
      success: function(data){

      }
    });
  });

  $(".edit_course").on('click', '.close-scorecard-photos', function(){
    var scorecard_image_id = $(this).attr('data-photo-id');
    $(this).closest('div.photo-division').remove();
    $.ajax({
      url: "/admin/courses/remove_scorecard_image",
      type: "POST",
      data: {scorecard_image_id: scorecard_image_id},
      success: function(data){

      }
    });
  });

  $(".edit_course").on('click', '.close-course-photos', function(){
    var image_id = $(this).attr('data-photo-id');
    $(this).closest('div.photo-division').remove();
    $.ajax({
      url: "/admin/courses/remove_course_image",
      type: "POST",
      data: {course_image_id: image_id},
      success: function(data){

      }
    });
  });
  // $('.course-photos-field').change(function(){
  //   var PhotoCollection, divClass, imageClass;
  //   if (window.location.href.indexOf('edit') < 0){
  //     PhotoCollection = $('.photos-collection');
  //     divClass = 'image-division';
  //     imageClass = 'course-create-image uploaded-photo-image';
  //   }else{
  //     PhotoCollection = $('.temp-photos-collection');
  //     divClass = 'upload-division';
  //     imageClass = 'edit-temp-uploaded-photos';
  //   }
  //   if (this.files && this.files[0]) {
  //     $.each(this.files, function(index, data) {
  //       var reader = new FileReader();
  //       reader.onload = function (e) {
  //         $(PhotoCollection).append("<div class='"+ divClass +"'><img src='"+e.target.result+"' class='"+ imageClass +"'><br></div>");
  //       }
  //       reader.readAsDataURL(data);
  //     });
  //   }
  // });

  $(document).on("click", ".video-reorder-up", function(){
    var $current = $(this).closest('div.video_item')
    var current_rank = parseInt($current.find('.rank-field').val());
    var $previous = $current.prev('div.video_item');
    if($previous.length !== 0){
      $current.insertBefore($previous);
      var new_current_rank = current_rank - 1;
      $current.find('.rank-field').val(new_current_rank);
      $current.find('.item_title').text("Item #"+new_current_rank);
      $previous.find('.rank-field').val(current_rank);
      $previous.find('.item_title').text("Item #"+current_rank);
    }
    return false;
  });

  $(document).on("click", ".video-reorder-down", function(){
    var $current = $(this).closest('div.video_item')
    var current_rank = parseInt($current.find('.rank-field').val());
    var $next = $current.next('div.video_item');
    if($next.length !== 0){
      $current.insertAfter($next);
      var new_current_rank = current_rank + 1;
      $current.find('.rank-field').val(new_current_rank);
      $current.find('.item_title').text("Item #"+new_current_rank);
      $next.find('.rank-field').val(current_rank);
      $next.find('.item_title').text("Item #"+current_rank);
    }
    return false;
  });


  $(document).on("click", ".scorecard-reorder-up", function(){
    var $current = $(this).closest('div.scorecard_container')
    var current_rank = parseInt($current.find('.rank-field').val());
    var $previous = $current.prev('div.scorecard_container');
    if($previous.length !== 0){
      $current.insertBefore($previous);
      var new_current_rank = current_rank - 1;
      $current.find('.rank-field').val(new_current_rank);
      $previous.find('.rank-field').val(current_rank);
    }
    return false;
  });

  $(document).on("click", ".scorecard-reorder-down", function(){
    var $current = $(this).closest('div.scorecard_container')
    var current_rank = parseInt($current.find('.rank-field').val());
    var $next = $current.next('div.scorecard_container');
    if($next.length !== 0){
      $current.insertAfter($next);
      var new_current_rank = current_rank + 1;
      $current.find('.rank-field').val(new_current_rank);
      $next.find('.rank-field').val(current_rank);
    }
    return false;
  });



  $(document).on("click", ".hole_image-reorder-right", function(){
    var $current = $(this).closest('div.gallery_list');
    var current_rank = parseInt($current.find('.rank-field').val());
    var $next = $current.next('div.gallery_list');
    if($next.length !== 0){
      $current.insertAfter($next);
      var new_current_rank = current_rank + 1;
      $current.find('.rank-field').val(new_current_rank);
      $next.find('.rank-field').val(current_rank);
    }
    return false;
  });

  $(document).on("click", ".hole_image-reorder-left", function(){
    var $current = $(this).closest('div.gallery_list')
    var current_rank = parseInt($current.find('.rank-field').val());
    var $previous = $current.prev('div.gallery_list');
    if($previous.length !== 0){
      $current.insertBefore($previous);
      var new_current_rank = current_rank - 1;
      $current.find('.rank-field').val(new_current_rank);
      $previous.find('.rank-field').val(current_rank);
    }
    return false;
  });

  $(document).on("click", ".course_image-reorder-right", function(){
    var $current = $(this).closest('div.course_image_cont');
    var current_rank = parseInt($current.find('.rank-field').val());
    var $next = $current.next('div.course_image_cont');
    if($next.length !== 0){
      $current.insertAfter($next);
      var new_current_rank = current_rank + 1;
      $current.find('.rank-field').val(new_current_rank);
      $next.find('.rank-field').val(current_rank);
    }
    return false;
  });

  $(document).on("click", ".course_image-reorder-left", function(){
    var $current = $(this).closest('div.course_image_cont')
    var current_rank = parseInt($current.find('.rank-field').val());
    var $previous = $current.prev('div.course_image_cont');
    if($previous.length !== 0){
      $current.insertBefore($previous);
      var new_current_rank = current_rank - 1;
      $current.find('.rank-field').val(new_current_rank);
      $previous.find('.rank-field').val(current_rank);
    }
    return false;
  });
});

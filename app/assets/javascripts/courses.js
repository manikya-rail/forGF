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
    var imageDiv = $('.score.image-division');
    if (this.files.length > 0) {
      var reader = new FileReader();
      reader.onload = function (e) {
        if (window.location.href.indexOf('edit') < 0){
          $('.uploaded-score-image.course-create-image').attr('src', e.target.result).removeClass('hide');
          $(imageDiv).find('.close-cross').removeClass('hide');
        }else{
          if ($('.score .course-logo-image.cimage').length != 0){
            $('.score .course-logo-image.cimage').attr('src', e.target.result);
          }else{
            $(imageDiv).append("<span class='close-cross'>&times;</span> <img src='"+e.target.result+"' class='course-logo-image cimage'>");
          }
        }
      }
      reader.readAsDataURL(this.files[0]);
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

  $('.course-photos-field').change(function(){
    var PhotoCollection, divClass, imageClass;
    if (window.location.href.indexOf('edit') < 0){
      PhotoCollection = $('.photos-collection');
      divClass = 'image-division';
      imageClass = 'course-create-image uploaded-photo-image';
    }else{
      PhotoCollection = $('.temp-photos-collection');
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
});

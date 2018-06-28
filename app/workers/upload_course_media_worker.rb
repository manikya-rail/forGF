class UploadCourseMediaWorker
  include Sidekiq::Worker

  def perform(images_path_arr, course_id)
    course = Course.find(course_id)
    images_path_arr.each do |image_path|
      image_file = File.open(image_path)
      course.course_images.create(photo: image_file)
      FileUtils.rm image_path
    end
  end
end

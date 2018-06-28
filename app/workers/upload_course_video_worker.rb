class UploadCourseVideoWorker
  include Sidekiq::Worker

  def perform(course_id, videos_details_arr)
    course = Course.find(course_id)
    videos_details_arr.each do |video_params|
      video_file = File.open(video_params["file_path"])
      course.videos.create(title: video_params["title"], description: video_params["description"], video: video_file)
      FileUtils.rm video_params["file_path"]
    end
  end
end

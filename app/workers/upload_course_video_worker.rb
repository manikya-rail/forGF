class UploadCourseVideoWorker
  include Sidekiq::Worker

  def perform(course_id, videos_details_arr)
    course = Course.find(course_id)
    videos_details_arr.each do |video_params|
      video_file = File.open(video_params["file_path"]) rescue nil
      thumbnail_file = File.open(video_params["thumbnail_path"]) rescue nil
      if video_file.present?
        course_video = course.videos.create(title: video_params["title"], description: video_params["description"])
        course_video.video = video_file
        course_video.thumbnail_image = thumbnail_file if thumbnail_file.present?
        course_video.save
      end
      FileUtils.rm video_params["file_path"] if video_file.present?
      FileUtils.rm video_params["thumbnail_path"] if thumbnail_file.present?
    end
  end
end

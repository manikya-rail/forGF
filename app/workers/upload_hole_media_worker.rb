class UploadHoleMediaWorker
  include Sidekiq::Worker

  def perform(hole_params)
    memory_output = %x(free)
    free_memory = memory_output.split(" ")[9]
    if free_memory.to_i < 1000000
      UploadHoleMediaWorker.perform_in(10.minutes, hole_params)
      return
    end
  	hole = Hole.find(hole_params["hole_id"])
    video_file = File.open(hole_params["video_file_path"]) rescue nil

    hole_video = hole.build_video(video: video_file) if video_file.present?
    hole_video.save if hole_video.present?
    if hole_params["hole_images_paths"].present?
      hole_params["hole_images_paths"].each do |image|
        image_file = File.open(image) rescue nil
        if image_file.present?
          hole.hole_images.create(image: image_file)
        end
      end
    end
    FileUtils.rm_rf("public/hole_#{hole_params["hole_id"]}")
  end
end

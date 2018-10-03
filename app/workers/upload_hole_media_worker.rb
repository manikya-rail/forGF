class UploadHoleMediaWorker
  include Sidekiq::Worker

  def perform(hole_params)
    memory_output = %x(free)
    free_memory = memory_output.split(" ")[9].to_i + memory_output.split(" ")[12].to_i
    if free_memory.to_i < 1048576
      # stats = Sidekiq::Stats.new
      # if stats.processes_size < 4
      #   system('echo ubox52 | sudo -S sync && echo 3 | sudo tee /proc/sys/vm/drop_caches')
      #   system('echo ubox52 | sudo -S sysctl -w vm.drop_caches=3')
      # end
      UploadHoleMediaWorker.perform_in(10.minutes, hole_params)
      return
    end
    hole = Hole.find_by_id(hole_params["hole_id"])
    if hole.present?
      video_file = File.open(hole_params["video_file_path"]) rescue nil
      if video_file.present?
        hole_video = Video.find(hole_params["video_id"]) rescue nil
        hole_video.update(status: "uploading")
        hole_video = hole.build_video(status: "processing") if hole_video.nil?
        hole_video.video = video_file
        hole_video.status = "completed"
      end
      hole_video.save if hole_video.present?
      if hole_params["hole_images_paths"].present?
        hole_params["hole_images_paths"].each do |image|
          image_file = File.open(image) rescue nil
          if image_file.present?
            hole.hole_images.create(image: image_file)
          end
        end
        FileUtils.rm_rf("public/hole_#{hole_params["hole_id"]}")
      end
    end
  end
end

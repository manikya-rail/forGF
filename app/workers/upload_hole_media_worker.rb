class UploadHoleMediaWorker
  include Sidekiq::Worker

  def perform(all_hole_details)
  	all_hole_details.each do |hole_params|
  	  hole = Hole.find(hole_params["hole_id"])
  	  video_file = File.open(hole_params["video_file_path"]) if hole_params["video_file_path"].present?
  	  cover_file = File.open(hole_params["cover_file_path"]) if hole_params["cover_file_path"].present?
  	  map_file = File.open(hole_params["map_file_path"]) if hole_params["map_file_path"].present?

  	  hole.build_video(video: video_file) if video_file.present?
  	  hole.image = cover_file if cover_file.present?
  	  hole.map = map_file if map_file.present?
  	  hole.description = hole_params["description"]
  	  hole.save
  	  if hole_params["hole_images_paths"].present?
  	    hole_params["hole_images_paths"].each do |image|
  	      image_file = map_file = File.open(image)
  	      hole.hole_images.create(image: image_file)
  	    end
  	  end
  	end
  end
end

namespace :app do
  desc "Convert video geometry"
  task :convert_videos_style => :environment do
    video_geomentry_logger = Logger.new("#{Rails.root}/log/video_geomentry_logger.log")
    videos = Video.all
    videos.each do |video|
      uri = URI(video.video.url)
      request = Net::HTTP.new uri.host
      response = request.request_head uri.path
      if (response.code.to_i == 200)
        video.video.reprocess!(:medium)
        puts "Video #{video.id} has processed."
        video_geomentry_logger.info("Video #{video.id} has processed.\n")
      else
        puts "Video #{video.id} not available."
        video_geomentry_logger.info("Video #{video.id} has processed.\n")
      end
    end
  end
end

namespace :app do
  desc "Convert video geometry"
  task :convert_videos_style => :environment do
    video_geomentry_logger = Logger.new("#{Rails.root}/log/video_geomentry_logger.log")
    videos = Video.select{|v| v if (v.id > 0 && v.id <= 50)}
    videos.each do |video|
      if video.video.url.include?('missing')
        puts "Video #{video.id} is missing."
        video_geomentry_logger.info("Video #{video.id} is missing.\n")
      else
        uri = URI(video.video.url)
        request = Net::HTTP.new uri.host
        response = request.request_head(uri.path)
        if (response.code.to_i == 200)
          video.video.reprocess!(:mobile)
          puts "Video #{video.id} has processed."
          video_geomentry_logger.info("Video #{video.id} has processed.\n")
        else
          puts "Video #{video.id} not available."
          video_geomentry_logger.info("Video #{video.id} has processed.\n")
        end
      end
    end
  end
end

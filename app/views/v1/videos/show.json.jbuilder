json.data do
    json.video  do
        json.hole_id @hole.id 
        json.hole_number @hole.hole_num
        json.url @video.video.url
        json.video_file_name @video.video_file_name

        json.tags @video.tags do |tag|
            json.tag tag.tag
            json.time tag.time
            json.created_at tag.created_at
            json.updated_at tag.updated_at
        end
    end
end

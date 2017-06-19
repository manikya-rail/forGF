json.data do
    json.user do
        json.(@user,
            :id, 
            :email,
            :authentication_token
        )
    end
end
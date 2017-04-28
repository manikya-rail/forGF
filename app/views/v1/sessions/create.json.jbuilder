json.data do
    json.user do
        json.(@user, 
            :email,
            :authentication_token
        )
    end
end
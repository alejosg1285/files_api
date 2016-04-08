json.array!(@users) do |user|
  json.(user,:id, :name, :email, :phone, :avatar)
  json.data_files(user.data_files) do |data_file|
    json.(data_file, :id, :file_identifier)
    json.uri api_v1_data_file_path(data_file)
  end
end

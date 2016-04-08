json.array!(@data_files) do |data_file|
  json.(data_file,:id, :file_identifier)
  json.url api_v1_data_file_path(data_file)
end

# :url, :size, :content_type
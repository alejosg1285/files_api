class DataFile < ActiveRecord::Base
  has_and_belongs_to_many :users
  mount_uploader :file, FileUploader

  delegate :size, to: :file
  delegate :url, to: :file
  delegate :content_type, to: :file
end

# Sube una imagen/archivo mediante curl
# curl -X PUT -F "user[avatar]=@/home/server/Imágenes/minidemon.png" http://localhost:4000/api/v1/users/1.json

# Sube multiples archivos
# curl -X POST -F "user[name]=The Rubyst" -F "user[email]=the.rubyst@gmail.com" -F "user[data_files_attributes][]file=@/home/server/Descargas/Libros/I-Love-Ruby.pdf" -F "user[data_files_attributes][]file=@/home/server/Descargas/Libros/LPIC-1.pdf" -F "user[data_files_attributes][]file=@/home/server/Descargas/Libros/progit-es.806.pdf" http://localhost:4000/api/v1/users.json



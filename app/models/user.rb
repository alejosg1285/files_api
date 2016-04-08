class User < ActiveRecord::Base
  has_and_belongs_to_many :data_files, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  mount_uploader :avatar, AvatarUploader

  accepts_nested_attributes_for :data_files, reject_if: proc { |attributes| attributes[:file].blank? }

end

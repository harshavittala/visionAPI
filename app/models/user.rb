class User
  include Mongoid::Document
  #include Mongoid:timestamps
  field :text, type: String
  mount_uploader :avatar, AvatarUploader
end

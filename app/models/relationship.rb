class Relationship < ApplicationRecord
  #フォローするユーザに結びついてる
  belongs_to :followed, class_name: "Customer"
  #フォローされるユーザに結びついてる
  belongs_to :follower, class_name: "Customer"
end

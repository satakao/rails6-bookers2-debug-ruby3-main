class Relationship < ApplicationRecord
  #ユーザーモデルへのアソシエーション。follower(id)カラムがユーザーモデルに所属していることを定義する
  belongs_to :follower, class_name:"User"
  belongs_to :followed, class_name:"User"
end

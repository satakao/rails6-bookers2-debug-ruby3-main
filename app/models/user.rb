class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  #自分がフォロー、アンフォローする記述、されたの関係。ユーザーモデルが多くのRelationshipのレコードを持つためhas_manyで記述している。１つ目の記述は仮想のテーブル名で名前自分で命名する。2つ目で紐付けるモデル名。３つ目はこの外部キーに保存してといった記述relationshipsは中間テーブル
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #相手がフォロー、アンフォローする記述(一覧画面で使う)上の記述のみでフォローアンフォローはできるようになる
  has_many :reverse_of_relationships, class_name:"Relationship", foreign_key: "followed_id", dependent: :destroy
  #一覧画面で使う
  #フォローした人を上記で定義したrelationshipsメソッドを使ってフォローしてくれてる人(followed)の情報を引っ張ってこれる
  has_many :followings, through: :relationships, source: :followed
  #フォローされている人を上記で定義したreverse_of_relationshipsメソッドを使ってフォローした人の情報を引っ張ってこれる(followerテーブルを元に)
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  #フォローした時の処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  #フォロー外す時の処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  #フォローしているかの判定
  def following?(user)
    followings.include?(user)
  end
  def self.looks(search,word)
    if search =="perfect_match"
      @user = User.where("name LIKE ?", "#{word}")#nameカラムからwhereでUserモデルから、LIKEで後ろに書かれた同じ文字列(wordから)を探してくる（？は入力で指定された値になる）
    elsif search == "pertial_match"
      @user = User.where("name LIKE ?", "%#{word}%")
    else
      @user =User.all
    end
  end
end

class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts
  #ユーザーから見た時にmicropostがたくさんあるという表現をする
  
  has_many :relationships
  #フォローしているユーザーがたくさんいる(relationshipsを参照している)
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  #自分をフォローしているユーザーがたくさんいる(relationshipsを参照している)
  #foreign_keyでモデルを参照しているユーザーを設定する
  has_many :followings, through: :relationships, source: :follow
  has_many :followers, through: :reverses_of_relationship, source: :user
  #sourceで取得するカラムを指定する
  
  has_many :favos
  has_many :likes, through: :favos, source: :micropost
  has_many :reverses_of_favos, class_name: 'Favo',foreign_key: 'micropost_id'
  has_many :favouser, through: :reverses_of_relationship, source: :user
  #互いに１対多の関係でモデルを参照し合う
  
  def favo(favo_micropost)
    self.favos.find_or_create_by(micropost_id: favo_micropost.id)
    #micropostのidを挿入する
  end
  
  def unfavo(favo_micropost)
    favoo = self.favos.find_by(micropost_id: favo_micropost.id)
    favoo.destroy if favoo
    #unfavoメソッドが発動してfavooがnilでなかったら消去する
  end
  #rubyはselfを省略できるので
  
  def favoing?(favo_micropost)
    self.likes.include?(favo_micropost)
    #micropostが入っているかどうか
  end
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
   Micropost.where(user_id: self.following_ids + [self.id])
   #自分がフォローしているユーザーidと自分のidが条件
  end
  
end

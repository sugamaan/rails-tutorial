class User < ApplicationRecord
  before_save { self.email = email.downcase }
  # validates :name,  presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, length: { maximum: 255 },
  #                   format: { with: VALID_EMAIL_REGEX },
  #                   uniqueness: true
  # validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  attr_accessor :remember_token

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    # 属性にアクセスするためにselfを記述する
    self.remember_token = User.new_token
    # 記憶ダイジェストを更新する
    update_attribute(:remember_digest, User.digest(remember_token))
  end
end

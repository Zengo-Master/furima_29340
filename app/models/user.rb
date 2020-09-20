class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchases
  has_many :reviews

  with_options presence: true do
    validates :nickname
    # メールアドレスの正規表現、一意性
    validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "does not contain '@'" }, uniqueness: { case_sensitive: false, message: 'has already been taken' }
    # パスワードは6文字以上、半角英数字混合
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'is not mixed with half-width alphanumeric characters' }, length: { minimum: 6, message: 'is too short (minimum is 6 characters)' }
    # 姓はひらがな、カタカナ、漢字
    validates :password_confirmation
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'is invalid. Input in kanji.' }
    # 名はひらがな、カタカナ、漢字
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'is invalid. Input in hiragana or katakana or kanji.' }
    # 姓の読みはカタカナ
    validates :family_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input in katakana.' }
    # 名の読みはカタカナ
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input in katakana.' }
    validates :birthday
  end
end

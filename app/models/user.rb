class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # 0: admin, 1: mcm, 2: auteur, 3:verificateur

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,presence:true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password,presence: true, length: {minimum: 6}, allow_nil: true
  devise :database_authenticatable,:rememberable #, :trackable # :validatable
  has_many :sesses
  has_many :historiques
  has_many :projects
end

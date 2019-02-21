class Project < ActiveRecord::Base

  validates_presence_of :name, :fichier

  mount_uploader :fichier
  has_many :corrections
  has_many :sesses
  belongs_to :user

end

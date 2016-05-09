class Keyword < ActiveRecord::Base
  has_many :univ_keywords
  has_many :univs, through: :univ_keywords
end

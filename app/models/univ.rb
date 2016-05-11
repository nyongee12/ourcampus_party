class Univ < ActiveRecord::Base
  has_many :festivals
  has_many :univ_keywords
  has_many :keywords, through: :univ_keywords

  require 'csv'
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      univ_hash = row.to_hash
      univ = Univ.find_or_create_by(id: univ_hash[:id])

      univ.update_attributes(univ_hash)
    end
  end
end

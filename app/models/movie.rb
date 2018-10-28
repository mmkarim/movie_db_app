class Movie < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :ratings, dependent: :destroy

  validates_presence_of :name, :user_id
  validates :name, uniqueness: { scope: :user }

  class << self
    def per_page
      10
    end

    def total_pages(per_page = self.per_page)
      pages = count / per_page.to_f
      pages += 1 if pages % 1 > 0
      pages.to_i
    end

    def paginate page = 1, per_page=  self.per_page
      page = page.to_i
      per_page = per_page.to_i

      offset = (page - 1) * per_page
      limit(per_page).offset(offset)
    end
  end

  def average_ratings
    self.ratings.average(:value).to_i
  end
end

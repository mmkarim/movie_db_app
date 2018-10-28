require 'rails_helper'

RSpec.describe Movie, type: :model do
  let!(:movie){create(:movie)}
  let!(:user){create(:user)}
  let!(:rating){create(:rating, user: user, movie: movie)}

  describe 'Associations' do
    it { should have_many(:ratings) }
    it { should have_and_belong_to_many (:categories) }
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }
  end

  # Instance Methods
  describe '#update_average_rating!' do
    it "should always keep updating average_rating according to its ratings" do
      expect(movie.average_rating).to eq(movie.ratings.average(:value).round(1))
    end
  end

  # Class Methods
  describe '.total_pages' do
    it "should give total page numbers for given count and page limit" do
      expect(Movie.total_pages(5, 10)).to eq(calculate_total_pages(5, 10))
      expect(Movie.total_pages(12, 10)).to eq(calculate_total_pages(12, 10))
      expect(Movie.total_pages(20, 10)).to eq(calculate_total_pages(20, 10))
    end
  end

  describe '.paginate' do
    before{FactoryBot.create_list(:movie, 10)}
    it "should return correct number of records according to the offset " do
      expect(Movie.paginate(1, 10).count).to eq(10)
      expect(Movie.paginate(2, 10).count).to eq(Movie.count%10)
    end
  end

  # Helper Methods
  def calculate_total_pages(count, per_page)
    pages = count / per_page.to_f
    pages += 1 if pages % 1 > 0
    pages.to_i
  end
end

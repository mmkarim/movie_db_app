require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'Associations' do
    it { should belong_to(:movie) }
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:value) }
  end
end

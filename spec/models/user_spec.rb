require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:movies) }
    it { should have_many(:ratings) }
  end
end

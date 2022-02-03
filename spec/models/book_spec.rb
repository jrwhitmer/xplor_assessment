require 'rails_helper'
RSpec.describe Book, type: :model do
  describe 'relationships' do
    it { should belong_to(:library) }
  end
  describe 'validations' do
    it { should validate_presence_of(:current_user) }
    it { should validate_inclusion_of(:status).in_array(["checked out", "available"]) }
  end
end

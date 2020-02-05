require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'validation' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

end

require 'rails_helper'

RSpec.describe Blog, type: :model do


  describe 'validations' do
    it { should belong_to(:user)}
    it { should validate_presence_of (:name and :body and :user_id )}
  end

  




end

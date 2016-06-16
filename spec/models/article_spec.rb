require 'rails_helper'

RSpec.describe Article, type: :model do

  describe 'validates' do
    it { should validate_uniqueness_of(:name).scoped_to(:blog_id).with_message("you can't have two articles with same name")}
    it { should validate_presence_of (:body and :name and :blog_id and :user_id ) }
  end

end

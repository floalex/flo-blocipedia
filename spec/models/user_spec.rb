require 'rails_helper'

describe User do 
  before do
    @user = create(:user)
    @wiki = create(:wiki)
  end
  it { should respond_to(:collaborators) }
end
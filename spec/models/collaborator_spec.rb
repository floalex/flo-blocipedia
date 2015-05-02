require 'rails_helper'

describe Collaborator do
  
  let(:user) { FactoryGirl.create(:user)}
  let(:wiki) { FactoryGirl.create(:wiki)}
  let(:collaborator) { wiki.collaborators.build(user_id: user.id)}

  subject { collaborator }

  it { should be_valid }

end
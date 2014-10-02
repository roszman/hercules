require 'rails_helper'

RSpec.describe User, :type => :model do
  
  let(:user){ User.new(email: "valid@example.com")}
  it {expect(user).to respond_to(:email)}

  context 'when providing valid email' do
    
  let(:valid_user){ User.new(email: "valid@example.com")}

    it 'user should be valid' do
      expect(valid_user).to be_valid
    end
  end

  context 'when providing empty email' do
    let(:empty_email_user){User.create(email: '')}
    it 'user should be invalid' do
      expect(empty_email_user).not_to be_valid
    end
  end

  context 'when providing existing email' do
    let(:invalid_user){User.create(email: 'invalid_email')}

    it 'user should be invalid' do
      expect(invalid_user).not_to be_valid
    end

  end

  context 'email adres with mixed case' do
    let(:mixed_case_email) {'vAlId@email.coM'}

    it 'should be saved as all lower-case' do
      user.email = mixed_case_email
      user.save
      expect(user.reload.email).to eq mixed_case_email.downcase
    end
  end

end

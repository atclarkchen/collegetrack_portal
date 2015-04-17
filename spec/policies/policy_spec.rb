 require 'rails_helper'
 require 'pundit/rspec'
 
 describe UserPolicy do
    subject { UserPolicy }
   
    let(:user) { FactoryGirl.create(:user) }

    permissions :edit? do
      it 'should not allow a user to see things from other accounts' do
        expect(subject).to_not permit(user, user)
      end
      it 'should not allow a user to see things from other accounts' do
      	user.role = "Admin"
        expect(subject).to permit(user, user)
      end
    end
 end
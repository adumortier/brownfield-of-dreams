require 'rails_helper'

RSpec.describe RegistrationNotifierMailer, type: :mailer do
  # describe 'instructions' do
  #   let(:user) { mock_model User, name: 'Alexis', email: 'dumortier.alexis@email.com' }
  #   let(:mail) { described_class.instructions(user).deliver_now }

  #   it 'renders the subject' do
  #     expect(mail.subject).to eq("Active your Brownfield of Dreams account")
  #   end

  #   it 'renders the receiver email' do
  #     expect(mail.to).to eq([user.email])
  #   end

  #   it 'renders the sender email' do
  #     expect(mail.from).to eq(['no-reply@example.com'])
  #   end

  #   it 'assigns @name' do
  #     expect(mail.body.encoded).to match(user.name)
  #   end

  # end
end

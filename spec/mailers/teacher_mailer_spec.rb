# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeacherMailer, type: :mailer do
  describe 'account_activation' do
    let(:school) { create(:school, name: 'test_school') }
    let(:teacher) { create(:teacher, school: school) }
    let(:mail) { TeacherMailer.account_activation(teacher) }
    let(:html_body) do
      part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8' }
      part.body.raw_source
    end
    let(:text_body) do
      part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8' }
      part.body.raw_source
    end

    it 'renders the headers' do
      # expect(mail.subject).to eq("Account activation")
      expect(mail.to).to eq([teacher.email])
      # expect(mail.from).to eq(["from@example.com"])
    end

    it 'renders the body' do
      expect(html_body).to match("#{teacher.name}さん")
      expect(text_body).to match("#{teacher.name}さん")
    end
  end

  # describe 'password_reset' do
  #   let(:mail) { TeacherMailer.password_reset }

  #   it 'renders the headers' do
  #     expect(mail.subject).to eq('Password reset')
  #     expect(mail.to).to eq(['to@example.org'])
  #     expect(mail.from).to eq(['from@example.com'])
  #   end

  #   it 'renders the body' do
  #     expect(mail.body.encoded).to match('Hi')
  #   end
  # end
end

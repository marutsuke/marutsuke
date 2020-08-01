require "rails_helper"

RSpec.describe UserInvitationMailer, type: :mailer do
  describe "user_invitation" do
    let(:mail) { UserInvitationMailer.user_invitation }

    it "renders the headers" do
      expect(mail.subject).to eq("User invitation")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end

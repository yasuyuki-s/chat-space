require 'rails_helper'
describe Message do
  describe "#create" do
    context "valid" do
      it "is valid with body and image" do
        message = build(:message)
        expect(message).to be_valid
      end
      it "is valid without body but with image" do
        message = build(:message, body: "")
        expect(message).to be_valid
      end
      it "is valid without image but with body" do
        message = build(:message, image: "")
        expect(message).to be_valid
      end
    end
    context "invalid" do
      it "is invalid without body nor image" do
        message = build(:message, body: "", image: "")
        message.valid?
        expect(message.errors[:body_or_image]).to include("を入力してください")
      end
      it "is invalid without user_id" do
        message = build(:message, user_id: "")
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
      it "is invalid without group_id" do
        message = build(:message, group_id: "")
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end
    end
  end
end

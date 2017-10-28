require 'rails_helper'
describe Message do
  describe "#create" do
    describe "valid" do
      it "is valid with body and image" do
        user = create(:user)
        group = create(:group)
        message = build(:message, user_id: user.id, group_id: group.id)
        expect(message).to be_valid
      end
      it "is valid without body but with image" do
        user = create(:user)
        group = create(:group)
        message = build(:message, body: "" ,user_id: user.id, group_id: group.id)
        expect(message).to be_valid
      end
      it "is valid without image but with body" do
        user = create(:user)
        group = create(:group)
        message = build(:message, image: "" ,user_id: user.id, group_id: group.id)
        expect(message).to be_valid
      end
    end
    describe "invalid" do
      it "is invalid without body nor image" do
        user = create(:user)
        group = create(:group)
        message = build(:message, body: "", image: "", user_id: user.id, group_id: group.id)
        message.valid?
        expect(message.errors[:body_or_image]).to include("を入力してください")
      end
      it "is invalid without user_id" do
        user = create(:user)
        group = create(:group)
        message = build(:message, user_id: "", group_id: group.id)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end
      it "is invalid without group_id" do
        user = create(:user)
        group = create(:group)
        message = build(:message, user_id: user.id, group_id: "")
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end
    end
  end
end

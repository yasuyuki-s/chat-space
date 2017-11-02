require "rails_helper"

describe MessagesController do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:messages) { create_list(:message, 3, user: user, group: group) }
  let(:message) { build(:message, user: user, group: group) }

  describe "GET #index" do
    context "logged in" do
      before do
        login_user user
        create(:member, user: user, group: group)
      end

      it "populates an array of @group_messages ordered by created_at ASC" do
        messages.sort!{|a,b| a.created_at <=> b.created_at}
        get :index, params: {group_id: group.id}
        expect(assigns(:group_messages)).to match(messages)
      end

      it "renders the :index template" do
        get :index, params: {group_id: group.id}
        expect(response).to render_template :index
      end
    end

    context "not logged in" do
      before do
        create(:member, user: user, group: group)
      end

      it "redirects to users/sign_in" do
        get :index, params: {group_id: group.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #create" do
    context "logged in" do
      before do
        login_user user
        create(:member, user: user, group: group)
      end

      context "passed validation" do

        it "success to save message" do
          expect do
            post :create, params: {message: {body: message.body, image: message.image }, group_id: group.id }
          end.to change(Message, :count).by(1)
        end

        it "renders the :index template" do
          post :create, params: {message: {body: message.body, image: message.image }, group_id: group.id }
          expect(response).to redirect_to(group_messages_path(group))
        end
      end


      context "failed validation" do

        it "should not save message if it has neither body nor image" do
          expect do
            post :create, params: {message: {body: "", image: "" }, group_id: group.id }
          end.to change(Message, :count).by(0)
        end

        it "renders the :index template and alert" do
          post :create, params: {message: {body: "", image: "" }, group_id: group.id }
          expect(response).to redirect_to(group_messages_path(group))
          expect(flash[:alert]).to eq "メッセージを入力してください。"
        end
      end


    end

    context "not logged in" do
      before do
        create(:member, user: user, group: group)
      end

      it "redirects to users/sign_in" do
        post :create, params: {message: {body: message.body, image: message.image }, group_id: group.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end

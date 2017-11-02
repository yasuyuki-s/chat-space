require "rails_helper"

describe MessagesController do
  let(:user) { create(:user) }
  let(:group) { create(:group) }

  describe "GET #index" do
    context "logged in" do
      before do
        login_user user
        create(:member, user: user, group: group)
      end

      it "populates an array of @group_messages ordered by created_at ASC" do
        messages = create_list(:message, 3, user: user, group: group)
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

end

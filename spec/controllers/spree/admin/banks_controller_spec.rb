require 'spec_helper'

describe Spree::Admin::BanksController do
  routes { Spree::Core::Engine.routes }

  let(:role) { Spree::Role.create!(:name => 'user') }
  let(:roles) { [role] }

  before(:each) do
    @user = mock_model(Spree::User, :generate_spree_api_key! => false)
    @user.stub_chain(:roles, :includes).and_return([])
    @user.stub(:has_spree_role?).with('admin').and_return(true)
    allow_any_instance_of(Spree::Admin::BanksController).to receive(:spree_user_signed_in?).and_return(true)
    allow_any_instance_of(Spree::Admin::BanksController).to receive(:spree_current_user).and_return(@user)
    @user.stub(:roles).and_return(roles)
    roles.stub(:includes).with(:permissions).and_return(roles)
    allow_any_instance_of(Spree::Admin::BanksController).to receive(:authorize_admin).and_return(true)
    allow_any_instance_of(Spree::Admin::BanksController).to receive(:authorize!).and_return(true)
  end

  describe "GET index" do
    before(:each) do
      @bank1 = mock_model(Spree::Bank)
      allow_any_instance_of(Spree::Bank).to receive(:page).and_return([@bank1])
    end

    def send_request
      get :index
    end

    it "assigns @banks" do
      send_request
      expect(assigns(:banks)).to eq([@bank1])
    end

    it "paginates banks" do
      Spree::Bank.should_receive(:page)
      send_request
    end

    it "renders index template" do
      send_request
      response.should render_template(:index)
    end
  end

  describe "PUT toggle_activation" do
    before(:each) do
      @bank = mock_model(Spree::Bank, :toggle! => true)
      Spree::Bank.stub(:find).with("1").and_return(@bank)
    end

    def send_request
      put :toggle_activation, :id => "1", :use_route => 'spree', :format => :js
    end

    it "toggles activation status of bank" do
      @bank.should_receive(:toggle!).with(:active)
      send_request
    end

    context "when activation status toggled successfully" do
      it "sets @success to true" do
        send_request
        assigns(:success).should be_true
      end
    end

    context "when activation status not toggled successfully" do
      before(:each) do
        @bank.stub(:toggle!).and_return(false)
      end

      it "sets @success to false" do
        send_request
        assigns(:success).should be_false
      end
    end
  end
end
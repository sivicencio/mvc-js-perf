require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe FrameworksController do

  # This should return the minimal set of attributes required to create a valid
  # Framework. As you add validations to Framework, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FrameworksController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all frameworks as @frameworks" do
      framework = Framework.create! valid_attributes
      get :index, {}, valid_session
      assigns(:frameworks).should eq([framework])
    end
  end

  describe "GET show" do
    it "assigns the requested framework as @framework" do
      framework = Framework.create! valid_attributes
      get :show, {:id => framework.to_param}, valid_session
      assigns(:framework).should eq(framework)
    end
  end

  describe "GET new" do
    it "assigns a new framework as @framework" do
      get :new, {}, valid_session
      assigns(:framework).should be_a_new(Framework)
    end
  end

  describe "GET edit" do
    it "assigns the requested framework as @framework" do
      framework = Framework.create! valid_attributes
      get :edit, {:id => framework.to_param}, valid_session
      assigns(:framework).should eq(framework)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Framework" do
        expect {
          post :create, {:framework => valid_attributes}, valid_session
        }.to change(Framework, :count).by(1)
      end

      it "assigns a newly created framework as @framework" do
        post :create, {:framework => valid_attributes}, valid_session
        assigns(:framework).should be_a(Framework)
        assigns(:framework).should be_persisted
      end

      it "redirects to the created framework" do
        post :create, {:framework => valid_attributes}, valid_session
        response.should redirect_to(Framework.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved framework as @framework" do
        # Trigger the behavior that occurs when invalid params are submitted
        Framework.any_instance.stub(:save).and_return(false)
        post :create, {:framework => { "name" => "invalid value" }}, valid_session
        assigns(:framework).should be_a_new(Framework)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Framework.any_instance.stub(:save).and_return(false)
        post :create, {:framework => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested framework" do
        framework = Framework.create! valid_attributes
        # Assuming there are no other frameworks in the database, this
        # specifies that the Framework created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Framework.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => framework.to_param, :framework => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested framework as @framework" do
        framework = Framework.create! valid_attributes
        put :update, {:id => framework.to_param, :framework => valid_attributes}, valid_session
        assigns(:framework).should eq(framework)
      end

      it "redirects to the framework" do
        framework = Framework.create! valid_attributes
        put :update, {:id => framework.to_param, :framework => valid_attributes}, valid_session
        response.should redirect_to(framework)
      end
    end

    describe "with invalid params" do
      it "assigns the framework as @framework" do
        framework = Framework.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Framework.any_instance.stub(:save).and_return(false)
        put :update, {:id => framework.to_param, :framework => { "name" => "invalid value" }}, valid_session
        assigns(:framework).should eq(framework)
      end

      it "re-renders the 'edit' template" do
        framework = Framework.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Framework.any_instance.stub(:save).and_return(false)
        put :update, {:id => framework.to_param, :framework => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested framework" do
      framework = Framework.create! valid_attributes
      expect {
        delete :destroy, {:id => framework.to_param}, valid_session
      }.to change(Framework, :count).by(-1)
    end

    it "redirects to the frameworks list" do
      framework = Framework.create! valid_attributes
      delete :destroy, {:id => framework.to_param}, valid_session
      response.should redirect_to(frameworks_url)
    end
  end

end

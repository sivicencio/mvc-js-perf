require "spec_helper"

describe FrameworksController do
  describe "routing" do

    it "routes to #index" do
      get("/frameworks").should route_to("frameworks#index")
    end

    it "routes to #new" do
      get("/frameworks/new").should route_to("frameworks#new")
    end

    it "routes to #show" do
      get("/frameworks/1").should route_to("frameworks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/frameworks/1/edit").should route_to("frameworks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/frameworks").should route_to("frameworks#create")
    end

    it "routes to #update" do
      put("/frameworks/1").should route_to("frameworks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/frameworks/1").should route_to("frameworks#destroy", :id => "1")
    end

  end
end

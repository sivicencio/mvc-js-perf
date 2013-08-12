class HomeController < ApplicationController
  def index
    @apps = App.all
    @frameworks = Framework.all
  end
end

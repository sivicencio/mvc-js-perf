class AppsController < ApplicationController
  def index
    @apps = App.all
  end

  def new
  end
end

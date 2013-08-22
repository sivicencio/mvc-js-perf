class Run < ActiveRecord::Base
  belongs_to :instance
  belongs_to :test

  #Virtual attribute for setting run data
  def data
    @data
  end

  def data=(data)
    @data = data
  end
end

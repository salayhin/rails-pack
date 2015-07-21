module Admin
  class DashboardController < ApplicationController
    layout 'admin'
    def index
      @users = User.all
    end
  end
end




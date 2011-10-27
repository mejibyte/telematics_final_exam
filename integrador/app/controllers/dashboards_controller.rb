class DashboardsController < ApplicationController
  def show
    @courses = Api::Course.all(current_token)
  end
end

class Admins::DashboardController < ApplicationController
    before_action :authenticate_admin!
    def index
    end
end
class Admins::BlogsController < ApplicationController
    before_action :authenticate_admin!
    # GET /blogs or /blogs.json
    def index
        @blogs = Blog.all
    end
end
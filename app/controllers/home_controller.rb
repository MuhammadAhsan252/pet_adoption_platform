class HomeController < ApplicationController
    def index
        @blogs = Blog.order("created_at DESC").limit(3)
        @query = Query.new
    end
end
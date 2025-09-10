class PagesController < ApplicationController
  def index
    @blogs = Blog.all.limit(3)
  end
end

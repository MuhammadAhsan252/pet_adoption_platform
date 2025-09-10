class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show]
  def index
    @blogs = Blog.all.order(created_at: :desc)

    if params[:category].present?
      @blogs = @blogs.where(category: params[:category].titleize)
    end
  end

  def show
    set_meta_tags title: @blog.title,
      description: @blog.content.to_plain_text.truncate(200, separator: " "),
      keywords: "#{@blog.tags.join(", ")}",
      og: {
        title: @blog.title + " | Petcurehub",
        description: @blog.content.to_plain_text.truncate(200, separator: " "),
        url: blog_url(@blog),
        image: @blog.cover_image.present? ? url_for(@blog.cover_image) : helpers.image_path("logo.png")
      }
    @related_blogs = Blog.where(category: @blog.category).where.not(id: @blog.id).limit(3)
  end

  private
  def set_blog
    @blog = Blog.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to blogs_path, alert: "Blog not found."
  end
end

class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new edit create update destroy ]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all
    @title = "Latetst Articles"
  end

  # GET /blogs/1 or /blogs/1.json
  def show
    @previous_post = Blog.where('created_at < ?', @blog.created_at).order(created_at: :desc).first
    @next_post = Blog.where('created_at > ?', @blog.created_at).order(created_at: :asc).first
    @related_blogs = Blog.where(category: @blog.category).where.not(id: @blog.id).limit(6)
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        @blog.save_blog_images
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        @blog.save_blog_images
        format.html { redirect_to blog_url(@blog), notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to admins_blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def blogs_by_category
    @category = Category.friendly.find(params[:category])
    @blogs = @category.blogs
    @title = @category.name
    render :index
  end

  def blogs_by_subcategory
    @category = Category.friendly.find(params[:category])
    @subcategory = Subcategory.friendly.find(params[:subcategory])
    @blogs = Blog.where(category: @category, subcategory: @subcategory)
    @title = @category.name + " | " + @subcategory.name
    render :index
  end

  def upload_image
    image = params[:image]

    if image.nil?
      render json: { success: 0, error: "No image found in request" }
      return
    end

    # Use Active Storage to attach the image without an associated article
    uploaded_image = BlogImage.create!(image: image)

    # Generate a URL for the uploaded image
    stored_image_url = rails_blob_url(uploaded_image.image)

    render json: { success: 1, file: { url: stored_image_url } }
  rescue StandardError => e
    render json: { success: 0, error: e.message }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.friendly.find(params[:id])

      redirect_to @blog, status: :moved_permanently if params[:id] != @blog.slug
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :content, :image, :cover_image, :category_id, :subcategory_id)
    end
end

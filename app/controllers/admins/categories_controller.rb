class Admins::CategoriesController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_category, only: [:show, :update, :destroy]
    def index
        @categories = Category.all
    end

    def destroy
        @category.destroy
        redirect_to admins_categories_path, notice: "Category deleted!"
    end

    def create
        @category = Category.new(category_params)

        if @category.save
            redirect_to admins_categories_path, notice: "Category created!"
        else
            render :new
        end
    end

    def update
        if @category.update(category_params)
            redirect_to admins_categories_path, notice: "Category updated!"
        else
            render :edit
        end
    end

    def show
        @subcategories = @category.subcategories
    end

    def set_category
        @category = Category.friendly.find(params[:id])
    end

    private
    def category_params
        params.require(:category).permit(:name)
    end

end
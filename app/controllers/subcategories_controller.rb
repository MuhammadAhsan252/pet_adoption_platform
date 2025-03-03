class SubcategoriesController < ApplicationController
    def index
        @category = Category.friendly.find(params[:category_id])
        @subcategories = @category.subcategories

        render json: @subcategories
    end
end
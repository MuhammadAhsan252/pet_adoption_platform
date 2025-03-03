class Admins::SubcategoriesController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_category
    before_action :set_subcategory, only: [:update, :destroy]

    def destroy
        @subcategory.destroy
        redirect_to admins_category_path(@category), notice: "Subcategory deleted!"
    end


    def create
        @subcategory = @category.subcategories.new(subcategory_params)

        if @subcategory.save
            redirect_to admins_category_path(@category), notice: "Subcategory created!"
        else
            render :new
        end
    end

    def update
        if @subcategory.update(subcategory_params)
            redirect_to admins_category_path(@category), notice: "Subcategory updated!"
        else
            render :edit
        end
    end

    def set_category
        @category = Category.friendly.find(params[:category_id])
    end

    def set_subcategory
        @subcategory = @category.subcategories.friendly.find(params[:id])
    end

    private
    def subcategory_params
        params.require(:subcategory).permit(:name, :category_id)
    end

end
class PetsController < ApplicationController
  def index
    category = params[:category]
    size = params[:size]
    gender = params[:gender]
    age = params[:age]

    @pets = Pet.includes(:organization).order(created_at: :desc)

    @pets = @pets.where(category: category) if category.present?
    @pets = @pets.where(size: size) if size.present?
    @pets = @pets.where(gender: gender) if gender.present?
    @pets = @pets.where(age: age) if age.present?
  end

  def show
    @pet = Pet.friendly.find(params[:id])
  end
end

# @Author: Ronnie Nyaga <Ronnie>
# @Date:   2016-06-11T20:28:57+03:00
# @Email:  ronnienyaga@gmail.com
# @Last modified by:   Ronnie
# @Last modified time: 2016-06-14T16:14:35+03:00



class RecipesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  before_action :set_recipe, only: [:edit, :show, :update, :destroy]

  autocomplete :l_ingredient, :name
  autocomplete :serving_type, :name

  def index
    @recipes = Recipe.all.order('dateCreated DESC')
  end

  def show

  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    params[:recipe][:recipe_ingredients_attributes].map { |k, v|
      # Find or create the ingredient and return id
      v["ingredient_id"] = LIngredient.find_or_create_by(name: v["ingredient"]).id
    }
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: "Successfully created new recipe"
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    # return render json: params[:recipe][:serving_type]
    ServingType.find_or_create_by(name: params[:recipe][:serving_type])
    params[:recipe][:recipe_ingredients_attributes].map { |k, v|
      # Find or create the ingredient and return id
      v["ingredient_id"] = LIngredient.find_or_create_by(name: v["ingredient"]).id
    }
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, notice: "Successfully deleted recipe"
  end


  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :name, :preptime, :authorsTip, :servings, :serving_type_id, :serving_type,
      :price, :story, :cover, :tags,
      recipe_ingredients_attributes: [:id, :ingredient_id, :ingredient, :quantity, :measure, :_destroy],
      recipe_steps_attributes: [:id, :step, :_destroy]
    )
  end
end

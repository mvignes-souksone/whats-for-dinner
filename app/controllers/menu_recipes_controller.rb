class MenuRecipesController < ApplicationController
  def show
    @menu_recipe = MenuRecipe.find(params[:id])
    authorize @menu_recipe
    @review = Review.new
  end

  def create
    @menu = Menu.find(params[:menu_id])
    list_recipes = Recipe.where(diet: @menu.diet)

    # random
    if params[:recipe_id] == "random"

      recipe = list_recipes.sample

    else
    # parmi la list
      recipe = Recipe.find(params[:recipe_id])
    end

    @menu_recipe = MenuRecipe.new(menu: @menu, recipe: recipe, number_of_people: @menu.number_of_people )

    @menu_recipe.save!

    authorize @menu_recipe

    redirect_to edit_menu_path(@menu)
  end

  def update
    @menu_recipe = MenuRecipe.find(params[:id])
    @menu = @menu_recipe.menu
    @menu_recipe.update(menu_recipe_params)

    authorize @menu_recipe

  end

  def switch

  end

  def destroy
    @menu_recipe = MenuRecipe.find(params[:id])
    @menu_recipe.destroy


    authorize @menu_recipe
    redirect_to edit_menu_path(@menu)
  end


  private

  def menu_recipe_params
    params.require(:menu_recipe).permit(:number_of_people, :done)
  end
end

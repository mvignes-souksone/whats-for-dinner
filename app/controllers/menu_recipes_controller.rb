class MenuRecipesController < ApplicationController
  def show
    @menu_recipe = MenuRecipe.find(params[:id])
    authorize @menu_recipe
    @review = Review.new
  end

  def create
    @menu = Menu.find(params[:menu_id])
    if params[:recipe_id] == "random"
      list_recipes = Recipe.where(diet: @menu.diet)
      recipe = list_recipes.sample
    else
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
    redirect_to edit_menu_path(@menu) if params[:recipe] == "new"
  end

  def switch
    @menu = Menu.find(params[:menu_id])
    list_recipes = Recipe.where(diet: @menu.diet)
    new_menu_recipe = list_recipes.sample
    @menu_recipe = MenuRecipe.find(params[:id])
    @menu_recipe.update(recipe: new_menu_recipe)

    authorize @menu_recipe
    redirect_to edit_menu_path(@menu)
  end

  def new_random
  end

  def destroy
    @menu = Menu.find(params[:menu_id])
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

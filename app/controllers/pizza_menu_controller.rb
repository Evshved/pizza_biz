class PizzaMenuController < ApplicationController
  def index
    @pizza_types = PizzaType.all

    respond_to { |format| format.html }
  end
end

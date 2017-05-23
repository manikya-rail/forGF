class Admin::SearchController < ApplicationController

  def search
    klass = search_params[:klass].capitalize.constantize
    @res = klass.search_by_name(search_params[:q])
    @klass = search_params[:klass]
    @id = search_params[:id]
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:q, :klass, :id)
    end
end

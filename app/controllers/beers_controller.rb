class BeersController < ApplicationController
  respond_to :json

  def default_serializer_options
    {root: false}
  end

  def all
    respond_with Beer.all
  end

  def autocomplete
    render json: Beer.search(params[:query], autocomplete: true, limit: 10).map { |a| {id: a[:id], text: a[:name]} }
  end

  def recommended
    beer_type = params[:beer_type]
    @beers = Beer.where(category: beer_type).sample(5)
    respond_with @beers
  end

end
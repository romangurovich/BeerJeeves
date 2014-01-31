class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :ibu, :abv, :category
end

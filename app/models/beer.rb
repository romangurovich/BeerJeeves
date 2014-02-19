class Beer < ActiveRecord::Base
  searchkick autocomplete: ['name']
end

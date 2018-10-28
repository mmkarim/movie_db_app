class MovieSearch < FortyFacets::FacetSearch
  model 'Movie'

  text  :name, name: 'Name'
  facet :categories, name: 'Category'
  facet :average_rating,  name: "Avg. Rating"
end

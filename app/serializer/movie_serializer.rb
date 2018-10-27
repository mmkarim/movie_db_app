class MovieSerializer < ActiveModel::Serializer
  attributes :id, :name, :text, :categories
end

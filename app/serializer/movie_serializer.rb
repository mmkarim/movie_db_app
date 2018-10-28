class MovieSerializer < ActiveModel::Serializer
  attributes :id, :name, :text, :categories, :user_id
end

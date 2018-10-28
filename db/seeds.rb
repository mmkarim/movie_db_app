user = User.create! email: "admin@movie.com", password: "123456"

["Action", "Sci-Fi", "Comedy", "Drama", "Horror"].each do |name|
  Category.create! name: name
end

count = Category.count

(1..30).each do |i|
  Movie.create!(
    name: "movie #{i}",
    text: Faker::Lorem.paragraph,
    user_id: user.id,
    categories: Category.where(id: (i%count))
    )
end

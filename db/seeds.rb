# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

labels = File.readlines("public/object_detection/coco-labels-2014_2017.txt").reject { |label| label.chomp == "other" }
labels.each do |label|
  Tag.create(name: label.chomp) if Tag.find_by(name: label.chomp).nil?
end

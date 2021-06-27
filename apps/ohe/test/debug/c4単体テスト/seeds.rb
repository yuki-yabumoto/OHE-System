# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(favorite_color: 0,favorite_type: 0)
Clothe.create(kind:0, color:0, type:0, user_id:1)
Clothe.create(kind:4, color:0, type:1, user_id:1)
Clothe.create(kind:5, color:0, type:0, user_id:1)
Clothe.create(kind:2, color:0, type:1, user_id:1)
Clothe.create(kind:0, color:0, type:0, user_id:3)
Clothe.create(kind:4, color:0, type:1, user_id:3)
Clothe.create(kind:5, color:0, type:0, user_id:3)
Clothe.create(kind:2, color:0, type:1, user_id:3)
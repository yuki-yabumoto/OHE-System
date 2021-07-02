# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

UserInfo.create(user_id:1, color_combination1:'White', color_combination2:'Black', style:'Casual')
UserInfo.create(user_id:2, color_combination1:'White', color_combination2:'Blue', style:'Formal')
UserInfo.create(user_id:3, color_combination1:'Pink', color_combination2:'Black', style:'OutDoor')

ClothesInfo.create(user_id:1, clothes_type:'ShortSleevesTops', clothes_color:'White', clothes_gener:'Formal')
ClothesInfo.create(user_id:1, clothes_type:'ShortSleevesTops', clothes_color:'Black', clothes_gener:'Casual')
ClothesInfo.create(user_id:1, clothes_type:'ShortSleevesTops', clothes_color:'Blue', clothes_gener:'Casual')
ClothesInfo.create(user_id:1, clothes_type:'LongSleevesTops', clothes_color:'Green', clothes_gener:'Casual')
ClothesInfo.create(user_id:1, clothes_type:'ThinOuter', clothes_color:'Beige', clothes_gener:'Formal')
ClothesInfo.create(user_id:1, clothes_type:'ThickOuter', clothes_color:'Black', clothes_gener:'Formal')
ClothesInfo.create(user_id:1, clothes_type:'Bottoms', clothes_color:'White', clothes_gener:'Casual')
ClothesInfo.create(user_id:1, clothes_type:'Shoes', clothes_color:'Black', clothes_gener:'Casual')
ClothesInfo.create(user_id:1, clothes_type:'Accesary', clothes_color:'White', clothes_gener:'Formal')
ClothesInfo.create(user_id:1, clothes_type:'NoOuter')

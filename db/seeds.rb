# frozen_string_literal: true

# 100.times do
#   user = User.create(
#     name: Faker::Name.name,
#     email: Faker::Internet.email,
#     password: 'password'
#   )
#   Organization.create(members: [user])
#   puts "User #{user.id} (#{user.name}) created!"
# end

10_000.times do
  random_user = User.offset(rand(User.count)).first

  listing = Listing.create!(
    creator: random_user,
    organization: random_user.organizations.first,
    title: Faker::Commerce.product_name,
    price: Faker::Commerce.price.floor,
    condition: Listing.conditions.values.sample,
    tags: Faker::Commerce.send(:categories, 4),
    address_attributes: {
      line1: Faker::Address.building_number,
      line2: Faker::Address.street_address,
      city: Faker::Address.city,
      country: 'GB',
      postcode: Faker::Address.postcode
    }
  )

  Rails.logger.debug { "Listing #{listing.title} for User:  #{random_user.id} (#{random_user.name}) created!" }
end

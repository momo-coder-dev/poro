# db/seeds.rb
require 'open-uri'
puts "Cleaning database..."

UserAccount.destroy_all
User.destroy_all
Venue.destroy_all
Order.destroy_all
OrderItem.destroy_all
Ticket.destroy_all
TicketType.destroy_all
Validator.destroy_all
TicketTypeValidator.destroy_all
Event.destroy_all
Account.destroy_all


SAFE_IMAGE_URLS = [
  "https://images.unsplash.com/photo-1519681393784-d120267933ba?w=600",
  "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?w=600",
  "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600",
  "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=600",
  "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=600",
  "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=600",
  "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=600",
  "https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?w=600",
  "https://images.unsplash.com/photo-1520813792240-56fc4a3765a7?w=600",
  "https://images.unsplash.com/photo-1555685812-4b943f1cb0eb?w=600",
  "https://images.unsplash.com/photo-1607746882042-944635dfe10e?w=600",
  "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=600"
]

# Special account "toto"
toto_account = Account.create!(
  name: "Toto Corp",
  description: "Special account for testing",
  slug: "toto-corp",
  website: "https://toto.com"
)
p = SecureRandom.hex
toto_user = User.create!(
  name: "Toto Admin",
  email: "toto@gmail.com",
  phone: Faker::PhoneNumber.cell_phone,
  password: 123456,
  password_confirmation: 123456
)

UserAccount.create!(
  user: toto_user,
  account: toto_account,
  role: "admin"
)

puts "Creating 10 random accounts..."

10.times do
  account = Account.create!(
    name: Faker::Company.name,
    description: Faker::Company.catch_phrase,
    slug: Faker::Internet.unique.slug,
    website: Faker::Internet.url
  )

      # Attach online cover image
      account.cover_image.attach(
        io: URI.open(SAFE_IMAGE_URLS.sample),
      filename: "#{account.slug}.jpg",
      content_type: "image/jpeg"
    )

  account.save!

  # Create 1-2 users per account
  rand(1..2).times do
    p = SecureRandom.hex
    user = User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      phone: Faker::PhoneNumber.cell_phone,
      password: p,
      password_confirmation: p
    )

    UserAccount.create!(
      user: user,
      account: account,
      role: %w[admin organizer viewer].sample
    )
  end
end


puts "Creating 30 events linked to accounts..."

Account.all.each do |account|
  rand(2..4).times do
    start_at = Faker::Date.forward(days: rand(10..90))
    end_at = start_at + rand(91..120)
    event = Event.new(
      account: account,
      name: Faker::Music::RockBand.name + " Live",
      slug: Faker::Internet.unique.slug,
      description: Faker::Lorem.paragraph(sentence_count: 5),
      start_at: start_at,
      end_at: end_at,
      category: Event.categories.keys.sample,
      status: %w[draft published].sample,
      access_visibility: %w[public_event private_event].sample,
      location_type: %w[physical virtual].sample,
      entry_requirement: [ "None", "ID check", "VIP pass" ].sample,
      step: 5
    )

    # Attach online cover image
    event.cover_image.attach(
      io: URI.open(SAFE_IMAGE_URLS.sample),
      filename: "#{event.slug}.jpg",
      content_type: "image/jpeg"
    )

    # Create venue
    event.build_venue(
      name: Faker::Address.community,
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      country: Faker::Address.country,
      latitude: Faker::Address.latitude.to_s,
      longitude: Faker::Address.longitude.to_s
    )

    # Create 1-3 ticket types
    rand(1..4).times do
      event.ticket_types.build(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.sentence(word_count: 10),
        price: rand(10..200),
        quantity: rand(100..1000)
      )
    end

    event.save!
  end
end


Account.where(id: [ toto_account.id ]).each do |account|
  10.times do
    start_at = Faker::Date.forward(days: rand(10..90))
    end_at = start_at + rand(91..120)
    event = Event.new(
      account: account,
      name: Faker::Music::RockBand.name + " Live",
      slug: Faker::Internet.unique.slug,
      description: Faker::Lorem.paragraph(sentence_count: 5),
      start_at: start_at,
      end_at: end_at,
      category: Event.categories.keys.sample,
      status: %w[draft published].sample,
      access_visibility: %w[public_event private_event].sample,
      location_type: %w[physical virtual].sample,
      entry_requirement: [ "None", "ID check", "VIP pass" ].sample,
      step: 5
    )

    # Attach online cover image
    event.cover_image.attach(
      io: URI.open(SAFE_IMAGE_URLS.sample),
      filename: "#{event.slug}.jpg",
      content_type: "image/jpeg"
    )

    # Create venue
    event.build_venue(
      name: Faker::Address.community,
      address: Faker::Address.street_address,
      city: Faker::Address.city,
      country: Faker::Address.country,
      latitude: Faker::Address.latitude.to_s,
      longitude: Faker::Address.longitude.to_s
    )

    # Create 1-3 ticket types
    rand(1..4).times do
      event.ticket_types.build(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.sentence(word_count: 10),
        price: rand(10..200),
        quantity: rand(100..1000)
      )
    end

    event.save!
  end
end

puts "Creating validators for events..."

Event.all.each do |event|
  rand(1..2).times do
    validator = Validator.create!(
      account: event.account,
      event: event,
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      phone: Faker::PhoneNumber.cell_phone
    )

    # Assign validator to some ticket types
    event.ticket_types.sample(rand(1..event.ticket_types.count)).each do |ticket_type|
      TicketTypeValidator.create!(
        validator: validator,
        ticket_type: ticket_type
      )
    end
  end
end


events = Event.published


puts "Creating orders..."
events = Event.all

200.times do
  event = events.sample
  
  order = Order.create!(
    account: event.account,
    event: event,
    status: Order.statuses.keys.sample
  )

  # Create 1-3 tickets for each order
  rand(1..4).times do
    ticket_type = event.ticket_types.sample
    Ticket.create!(
      event: event,
      account: event.account,
      ticket_type: ticket_type,
      order: order
    )
  end
end

puts "Created #{Order.count} orders with #{Ticket.count} tickets"

puts "🌟 Seeding done successfully!"

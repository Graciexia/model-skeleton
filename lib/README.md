#Normal Mode

##Q1. How many users are there?

pry>code:
         Users.count

a:  51



##Q2. What are the 5 most expensive items?

pry>code:
         Items.order(price: :desc).limit(5)

a:  "Small Cotton Gloves",
    "Small Wooden Computer",
    "Awesome Granite Pants",
    "Sleek Wooden Hat",
    "Ergonomic Steel Car"



##Q3. What’s the cheapest book?

pry>code:
         Items.where(category: 'Books').order(price: :asc).limit(1)

a: "Ergonomic Granite Chair"



##Q4. Who lives at “6439 Zetta Hills, Willmouth, WY”? Do they have another address?

pry>code:
          Addresses.where(street: '6439 Zetta Hills', city: 'Willmouth', state: 'WY').take
          ==> user_id: 40

          Users.find_by id: '40'

a:  "Corrine Little"

pry>code:
         Addresses.where(user_id: 40).take 2


a:  street: "54369 Wolff Forges",
    city: "Lake Bryon",
    state: "CA"



##Q5. Correct Virginie Mitchell’s address to “New York, NY, 10108”.

pry>code:
          Users.where(first_name: 'Virginie', last_name: 'Mitchell' ).take
          ==> user_id: 41
          Addresses.where(user_id: 41).update_all(city: 'New York', state: 'NY')


##Q6. How much would it cost to buy one of each tool?

pry>code:Items.where(category: 'Tools').sum('price')

a: 7383



##Q7. How many total items did we sell?
pry>code:
         Orders.sum('quantity')

a: 2145



##Q8. How much was spent on books?

pry>code:
         Items.joins('join orders on items.id = orders.item_id').where(category: 'Books').sum('price * quantity')

a: 435526

##Q9. Simulate buying an item by inserting a User for yourself and an Order for that User.
pry>code:
          Users.find_or_create_by(first_name: 'Gracie',last_name: 'Xia', email: 'weiwei@xiaxia.com')
          Orders.find_or_create_by(user_id: 52, item_id: 76, quantity: 10, created_at: '2015-02-10 12:45:31.307689')




#Hard Mode

##Q1. What item was ordered most often? Grossed the most money?

pry>code:
         Items.select('title, items.id, count(*)').joins('join orders on items.id = orders.item_id').order('count(*) desc').group('items.id').limit(5).each do |x|
         print "#{x[:title]} ID:#{x[:id]} Count:#{x['count(*)']}\n"
         end

a:  Ergonomic Concrete Gloves ID:10 Count:9
    Practical Rubber Computer ID:46 Count:9
    Incredible Granite Car ID:65 Count:9
    Ergonomic Granite Computer ID:68 Count:8
    Small Plastic Pants ID:13 Count:7



##Q2. What user spent the most?

pry>code:
         x = Items.select('items.id, category, title, first_name, last_name, users.id as "user_id", sum(price * quantity)').joins('join orders on items.id = orders.item_id join users on users.id = orders.user_id').order('sum(price * quantity) desc').group('users.id').take

         puts "Name: #{x[:first_name]} #{x[:last_name]} Grossing: #{x['sum(price * quantity)']}"

a: Name: Hassan Runte Grossing: 639386


##Q3. What were the top 3 highest grossing categories?

pry>code:
        Items.select('category, sum(price * quantity)').joins('join orders on items.id = orders.item_id').order('sum(price * quantity) desc').group('category').limit(3).each do |x|
        puts "Category: #{x[:category]} Grossing: #{x['sum(price * quantity)']}"
        end

a:  Category: Music, Sports & Clothing Grossing: 525240
    Category: Beauty, Toys & Sports Grossing: 449496
    Category: Sports Grossing: 448410









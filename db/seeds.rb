require 'csv'

cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails_engine_development db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)

# - Import the CSV data into the Items table
CSV.foreach('db/data/items.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
  item = Item.create(row.to_h)
  item.unit_price = (row[:unit_price]/100.00.to_f.round(2))
  item.save
end

# - Add code to reset the primary key sequences on all 6 tables (merchants, items, customers, invoices, invoice_items, transactions)
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

require 'pp'
require_relative 'event'
require_relative 'event_store'
require_relative 'projection'

# event_store = EventStore.new
# project = Projections::Project.new

# puts "Initial state:"
# events = event_store.get
# p project.call(Projections::AllOrders.new, {}, events)

# puts "Creating order:"
# event = Events::OrderCreated.new(payload: { order_id: 1, account_id: 1 })
# event_store.append(event)

# events = event_store.get
# p project.call(Projections::AllOrders.new, {}, events)

# puts "Creating another order:"
# event = Events::OrderCreated.new(payload: { order_id: 2, account_id: 1 })
# event_store.append(event)

# events = event_store.get
# p project.call(Projections::AllOrders.new, {}, events)

###############################################################################

# project = Projections::Project.new

# puts "Creating yesterday order:"
# event_store = EventStore.new
# event = Events::OrderCreated.new(payload: { order_id: 1, account_id: 1 })
# event_store.append(event)

# yesterday_events = event_store.get
# p yesterday_orders = project.call(Projections::AllOrders.new, {}, yesterday_events)

# puts "Creating today order:"
# event_store = EventStore.new
# event = Events::OrderCreated.new(payload: { order_id: 2, account_id: 1 })
# event_store.append(event)

# puts "All orders:"
# events = event_store.get
# p project.call(Projections::AllOrders.new, yesterday_orders, events)

###############################################################################

project = Projections::Project.new
event_store = EventStore.new

# Creating first order
event = Events::OrderCreated.new(payload: { order_id: 1, account_id: 1 })
event_store.append(event)
events = event_store.get
project.call(Projections::AllOrders.new, {}, events)

# Creating another order
event = Events::OrderCreated.new(payload: { order_id: 2, account_id: 2 })
event_store.append(event)
events = event_store.get
pp project.call(Projections::AllOrders.new, {}, events)

p '*' * 60

# Adding items to first order
event = Events::ItemAddedToOrder.new(payload: { order_id: 1, item_id: 1, name: 'book', cost: 10.0 })
event_store.append(event)
event = Events::ItemAddedToOrder.new(payload: { order_id: 1, item_id: 2, name: 'magazine', cost: 3.0 })
event_store.append(event)
event = Events::ItemAddedToOrder.new(payload: { order_id: 2, item_id: 2, name: 'magazine', cost: 3.0 })
event_store.append(event)
events = event_store.get
pp project.call(Projections::AllOrders.new, {}, events)

p '*' * 60

# Print cost for each order
pp project.call(Projections::CostForOrder.new, {}, events)

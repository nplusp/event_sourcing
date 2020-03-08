require_relative 'event'
require_relative 'event_store'

event_store = EventStore.new

event = OrderCreated.new(payload: { order_id: 1, account_id: 1 })

event_store.append(event)

p event_store.get

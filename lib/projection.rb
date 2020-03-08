# frozen_string_literal: true

# f(g, initial_state, event_list) -> state
# f(g, state, event_list) -> new state
# f -> project
# g -> projection

class Projections
  # project(projection, initial_state, event_list) -> state
  class Project
    def call(projection, initial_state, events)
      events.reduce(initial_state) do |state, event|
        projection.call(state, event)
      end
    end
  end

  class AllOrders
    def call(state, event)
      case event
      when Events::OrderCreated
        state[:orders] ||= []
        state[:orders] << { **event.payload, items: [] }
      when Events::ItemAddedToOrder
        order = state[:orders].detect { |o| o[:order_id] == event.payload[:order_id] }
        state[:orders].delete(order)
        order[:items] << event.payload
        state[:orders] << order
      end

      state
    end
  end

  class CostForOrder
    def call(state, event)
      case event
      when Events::OrderCreated
        state[:order_costs] ||= {}
        state[:order_costs][event.payload[:order_id]] = 0
      when Events::ItemAddedToOrder
        state[:order_costs][event.payload[:order_id]] += event.payload[:cost]
      end

      state
    end
  end
end

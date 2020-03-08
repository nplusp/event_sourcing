# frozen_string_literal: true

class Event
  attr_reader :payload

  def initialize(payload:)
    @payload = payload
  end
end

# Order logic
# * order created
# * item added to order
# * item removed from order
# * order closed
# * order checked out

class OrderCreated < Event; end
class ItemAddedToOrder < Event; end
class ItemRemovedFromOrder < Event; end
class OrderClosed < Event; end
class OrderCheckedOut < Event; end

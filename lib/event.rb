# frozen_string_literal: true

module Events
  class Base
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

  class OrderCreated < Base; end
  class ItemAddedToOrder < Base; end
  class ItemRemovedFromOrder < Base; end
  class OrderClosed < Base; end
  class OrderCheckedOut < Base; end
end

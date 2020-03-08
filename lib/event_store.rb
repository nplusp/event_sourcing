# frozen_string_literal: true

class EventStore
  def initialize
    @store = []
  end

  def get
    @store
  end

  def append(*events)
    events.each { |event| @store << event }
  end
end

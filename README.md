# event_sourcing

* event - actual event from the past
  - was in the past
  - data object
  - name and data are required
  - can be anything - hash, struct, etc

* event store - store
  - immutable
  - interface:
    - get (nil -> list of events)
    - append (list of events -> nil)

* projection - collects events

* producer - creates events

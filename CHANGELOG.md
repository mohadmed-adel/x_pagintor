## 0.0.7

* Guard async pagination callbacks with `mounted` checks to prevent `setState()` after dispose.
* Ignore stale first-page responses when `changeState(resetState: true)` runs while a load is in flight.

## 0.0.1

* TODO: Describe initial release.

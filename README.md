# Eventd - PubSub for Content Fly in Motoko

[![Eventd CI / CD](https://github.com/contentflydapp/eventd/actions/workflows/dev.yml/badge.svg?branch=main)](https://github.com/contentflydapp/eventd/actions/workflows/dev.yml)

Eventd follows Publisher Subscriber (Pub/Sub) design pattern in event driven architecture.
Event driven architecture is great for decoupling dependencies in a system such that a event triggered doesn't need to know the parties who are interested in it. It could happen in asynchronous way or being transformed to other pattern like FIFO queue where events could be stored maintaining the event firing order.

## Purpose

Eventd is created as core infrastructure of Content Fly in order promote the use of PubSub and decoupling of system through events. The future use cases of it involves:

-   Sending any type of notifications to user when a new user has signned up or a user has made a comment. It could be email, browser, mobile push or any new type of notification native to blockchain.
-   Triggering of a separate backend canister to process user event. A potential future use case could be machine learning based recommendation system running on Canister.

## Design philosophy

Inspired by the original PubSub example in [GitHub dfinity/examples](https://github.com/dfinity/examples/tree/master/motoko/pub-sub), Eventd is created as a separate module that can be imported into the main project via [Vessel Package Management](https://github.com/dfinity/vessel). It encourages:

-   modular design
-   separation of business logic from architecture service
-   leverage the Motoko language's strong type feature with use of variants as Topic and typed payload specification
-   use TrieMap for subscriptions storage for better efficiency
-   subscriber can be in a separate canister actor function, it doesn't need to be in the same canister as the publisher
-   desiged to be general puprpose such that it's not coupled to any special type of business logic except the list of Topics specified

## How to use it in your project?

See main source in /src. Follow example code in /example for using it in Canister actor.

While Eventd is designed as Motoko package and can be imported into another Motoko using Vessel package management, it is recommended to clone this Git repository and make changes to the Event.mo to suit your purpose.

## To run unit tests in canisters

It uses Motoko Matchers as described in https://github.com/kritzcreek/ic101 for testing directly on local DFX canister

```bash
dfx start --background
dfx deploy
./run-test.sh
```

## Future enhancements

-   Make Topic payload optional so that when subscribing a topic from subscriber, it doesn't need to provide arbitrary value
-   Accept acknowledgement of event success or failure
-   Save scheduled event in persistent store with integration to FIFO persistent queue in a separate module as actor class.
-   Auto retry for failure event with future scheduled event once persistent queue is implemented

## Author

Henry Chan, henry@contentfly.app
Twitter: @kinwo

## Contributing

Pleaes feel free to raise issue or submit a pull request.

## License

MIT

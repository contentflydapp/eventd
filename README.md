# Eventd - PubSub for Content Fly in Motoko

[![Eventd CI / CD](https://github.com/contentflydapp/eventd/actions/workflows/dev.yml/badge.svg?branch=main)](https://github.com/contentflydapp/eventd/actions/workflows/dev.yml)

Publisher Subscriber (Pub/Sub) event driven architecture for Motoko

## Getting started

See main source is in /src. Follow example code in /example for using it in Canister actor.

## To run unit tests in canisters

It uses Motoko Matchers as described in https://github.com/kritzcreek/ic101 for testing directly on local DFX canister

```bash
dfx start --background
dfx deploy
./run-test.sh
```

## Future enhancements

-   Accept acknowledgement of event success or failure
-   Auto retry for failure event with future scheduled event
-   Save scheduled event in persistent store

## Author

Henry Chan, henry@controlaltdevelop.com  
Twitter: @kinwo

## Contributing

Pleaes feel free to raise issue or submit a pull request.

## License

MIT

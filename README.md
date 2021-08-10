# Eventd - PubSub for Content Fly in Motoko

Publisher Subscriber (Pub/Sub) event driven architecture for Motoko

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

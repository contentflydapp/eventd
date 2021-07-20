import Publishers "../src/publishers";

actor PublisherManager {

  public type Topic = Publishers.Topic;
  public type Subscriber = Publishers.Subscriber;

  let publisher = Publishers.Publisher();

  public func subscribe(myTopic: Topic, subscriber : Subscriber) {
    publisher.subscribe(myTopic, subscriber);
  };

  public func publish(topic : Topic) : async () {
    await publisher.publish(topic);
  };

  public query func registrySize() : async Nat {
    publisher.registrySize()
  };

}
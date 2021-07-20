// Base lib
import Array "mo:base/Array";
import Trie "mo:base/Trie";
import TrieMap "mo:base/TrieMap";
import log "mo:base/Debug";

// Local lib
import Event "event";

module {

  public type Topic = Event.Topic;

  public type Subscriber = {
    callback : shared Topic -> ();
  };

  public class Publisher() {

    // PubSub Registry Storage
    type TopicSubscriberMap<X, Y> = TrieMap.TrieMap<X, Y>;
    var subscribersMap: TopicSubscriberMap<Topic, [Subscriber]> = TrieMap.TrieMap<Topic, [Subscriber]>(Event.topicEqual, Event.topicHash);

    public func registrySize() : Nat {
      subscribersMap.size();
    };

    public func subscribe(myTopic: Topic, subscriber : Subscriber) {
      var subscribers = do {
          switch (subscribersMap.get(myTopic)) {
            case null {
              log.print("subscribe: creating new topic - " # debug_show(subscribersMap.size()));
              var empty : [Subscriber] = [];
              empty;
            };
            case (?value) { 
              value;
            };
          }
      };

      subscribers := Array.append<Subscriber>(subscribers, [subscriber]);
      subscribersMap.put(myTopic, subscribers);
    };

    public func publish(topic : Topic) : async () {
      switch (subscribersMap.get(topic)) {
        case (?subscribers) { 
          for (subscriber in subscribers.vals()) {
            subscriber.callback(topic);
          }
        };
        case null {
        }
      }
    };

  };

}
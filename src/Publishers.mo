// Base lib
import Array "mo:base/Array";
import Trie "mo:base/Trie";
import TrieSet "mo:base/TrieSet";
import TrieMap "mo:base/TrieMap";
import log "mo:base/Debug";
import Text "mo:base/Text";
import Hash "mo:base/Hash";

// Local lib
import Event "Event";

module {

  public type Topic = Event.Topic;
  public type NewChatRoomEvent = Event.NewChatRoomEvent;

  public type Subscriber = {
    id : Text;
    callback : shared Topic -> ();
  };

  public class Publisher() {
    // PubSub Registry Storage
    type TopicSubscriberMap<X, Y> = TrieMap.TrieMap<X, Y>;
    var subscribersMap: TopicSubscriberMap<Topic, [Subscriber]> = TrieMap.TrieMap<Topic, [Subscriber]>(Event.topicEqual, Event.topicHash);

    public func registryTopicSize() : Nat {
      subscribersMap.size();
    };

    public func numSubscribersForTopic(topic: Topic) : Nat {
      switch (subscribersMap.get(topic)) {
        case null {
          0;
        };
        case (?value) { 
          value.size();
        };
      }
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

      var subscriberSet : TrieSet.Set<Subscriber> = TrieSet.fromArray<Subscriber>(subscribers, subscriberHash, subscriberEqual);
      subscriberSet := TrieSet.put<Subscriber>(subscriberSet, subscriber, subscriberHash(subscriber), subscriberEqual);

      subscribersMap.put(myTopic, TrieSet.toArray<Subscriber>(subscriberSet));
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

    func subscriberHash(sub: Subscriber) : Hash.Hash {
      Text.hash(sub.id);
    };

    func subscriberEqual(sub1 : Subscriber, sub2 : Subscriber) : Bool {
      sub1.id == sub2.id;
    };

  };

}
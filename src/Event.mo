import Hash "mo:base/Hash";
import Text "mo:base/Text";

module {
  
  public type UserAccountId = Nat;
  public type BriefId = Nat;

  public type Topic = {
    #newUserAccountCreated : UserAccountId;
    #newContentBriefCreated : BriefId
  };

  // topicText -- for hashing the topic name
  func topicText(topic : Topic) : Text {
    switch topic {
      case (#newUserAccountCreated id) "#newUserAccountCreated";
      case (#newContentBriefCreated id) "#newContentBriefCreated";
    }
  };

  // TopicSubscriberMap topic hash
  public func topicHash(topic : Topic) : Hash.Hash {
    Text.hash(topicText(topic));
  };

  // TopicSubscriberMap topic equal
  public func topicEqual(topic1 : Topic, topic2 : Topic) : Bool {
    topicText(topic1) == topicText(topic2);
  };

}


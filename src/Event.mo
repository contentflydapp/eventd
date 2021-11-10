import Hash "mo:base/Hash";
import Text "mo:base/Text";

module {
  
  public type UserAccountId = Nat;
  public type BriefId = Nat;
  public type JobIdText = Text;
  public type UserId = Nat32;

  public type NewChatRoomEvent = {
    jobId: JobIdText;
    userId: UserId;
  };

  public type Topic = {
    #newUserAccountCreated : UserAccountId;
    #newContentBriefCreated : BriefId;
    #newChatRoomCreated : NewChatRoomEvent;
  };

  // topicText -- for hashing the topic name
  func topicText(topic : Topic) : Text {
    switch topic {
      case (#newUserAccountCreated id) "#newUserAccountCreated";
      case (#newContentBriefCreated id) "#newContentBriefCreated";
      case (#newChatRoomCreated payload) "#newChatRoomCreated";
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


import Publisher "canister:publisher";
import log "mo:base/Debug";

actor Subscriber {

  var count: Nat = 0;

  public func updateCount(myTopic : Publisher.Topic) {
    switch myTopic {
      case (#newUserAccountCreated id) {
        log.print("Callback updateCount: " # debug_show(myTopic));
        count += id;
      };
      case _ {}
    }
  };

  public func init(myTopic : Publisher.Topic): async () {
    Publisher.subscribe(myTopic, {callback = updateCount});
  };

  public query func getCount() : async Nat {
    return count;
  };
};
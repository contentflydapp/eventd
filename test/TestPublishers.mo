// Test libs
import C "mo:matchers/Canister";
import M "mo:matchers/Matchers";
import T "mo:matchers/Testable";


// Test subject
import Publisher "canister:publisher";
import Subscriber1 "canister:subscriber1";
import Subscriber2 "canister:subscriber2";

actor {

    type Topic = Publisher.Topic;
    let it = C.Tester({ batchSize = 1 });

    public shared func test() : async Text {
      
      it.should("registry size should be 0 initially", func () : async C.TestResult {
        let size = await Publisher.registryTopicSize();
        M.attempt(size, M.equals(T.nat(0)));
      });

      it.should("registry size should be 1 after 1st subscriber", func () : async C.TestResult {
        await Subscriber1.init(#newUserAccountCreated(0));
        let size = await Publisher.registryTopicSize();
        M.attempt(size, M.equals(T.nat(1)));
      });

      it.should("num subscribers for topic newUserAccountCreated should be 1 after 1st subscriber", func () : async C.TestResult {
        let size = await Publisher.numSubscribersForTopic(#newUserAccountCreated(0));
        M.attempt(size, M.equals(T.nat(1)));
      });

      it.should("registry size should be 1 after 2nd subscriber", func () : async C.TestResult {
        await Subscriber2.init(#newUserAccountCreated(0));
        let size = await Publisher.registryTopicSize();
        M.attempt(size, M.equals(T.nat(1)));
      });

      it.should("num subscribers for topic newUserAccountCreated should be 2 after 2nd subscriber", func () : async C.TestResult {
        let size = await Publisher.numSubscribersForTopic(#newUserAccountCreated(0));
        M.attempt(size, M.equals(T.nat(2)));
      });

      it.should("num subscribers for topic newContentBriefCreated should be 0", func () : async C.TestResult {
        let size = await Publisher.numSubscribersForTopic(#newContentBriefCreated(0));
        M.attempt(size, M.equals(T.nat(0)));
      });

      it.should("publish event newUserAccountCreated should trigger change to Subscriber1", func () : async C.TestResult {
        await Publisher.publish(#newUserAccountCreated(2));
        
        let count1 = await Subscriber1.getCount();
        M.attempt(count1, M.equals(T.nat(2)));
      });

      it.should("Subscriber2.count should be 2", func () : async C.TestResult {
        let count2 = await Subscriber2.getCount();
        M.attempt(count2, M.equals(T.nat(2)));
      });

      it.should("publish event newContentBriefCreated should trigger NO change to Subscriber1", func () : async C.TestResult {
        await Publisher.publish(#newContentBriefCreated(4));
        
        let count1 = await Subscriber1.getCount();
        M.attempt(count1, M.equals(T.nat(2)));
      });

      it.should("Subscriber1.count should remain 2", func () : async C.TestResult {
        let count2 = await Subscriber2.getCount();
        M.attempt(count2, M.equals(T.nat(2)));
      });

      await it.runAll()
    }
}

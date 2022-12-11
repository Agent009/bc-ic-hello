import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

/**
 * Get canister UI ID:      dfx canister id __Candid_UI -- rno2w-sqaaa-aaaaa-aaacq-cai
 * Get current canister ID: dfx canister id dbank_backend -- rrkah-fqaaa-aaaaa-aaaaq-cai
 * Get current canister ID: dfx canister id dbank_frontend -- ryjl3-tyaaa-aaaaa-aaaba-cai
 * Call canister function:  dfx canister call dbank_backend checkBalance -- 300
 */
actor DBank {
  // Create value with initial value
  // The stable keyword turns the variable into a persisted variable, which retains its value between deployments
  stable var currentValue: Float = 300;
  // Assign new value to the variable
  // currentValue := 100;
  // Assign a constant value that cannot be changed later on.
  // let id = 2000;
  stable var startTime = Time.now();
  Debug.print(debug_show(startTime));
  Debug.print(debug_show(currentValue));
  // Debug.print(debug_show(currentValue));

  // dfx canister call dbank topUp
  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float) {
    let tempVal: Float = currentValue - amount;

    if (tempVal >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Specified amount cannot be subtracted as it's more than the current value.");
    }
  };

  public query func checkBalance(): async Float {
    return currentValue;
    // Debug.print(debug_show (currentValue));
  };

  //topUp();

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    let timeElapsedM = timeElapsedNS / 1000000000 / 60;
    let interestRate = 0.01;
    // Calculate compound interest
    currentValue := (currentValue * ((1 + interestRate) ** Float.fromInt(timeElapsedM)));
    startTime := currentTime;
  };
};

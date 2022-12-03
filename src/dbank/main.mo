import Debug "mo:base/Debug";

/**
 * Get canister UI ID:      dfx canister id __Candid_UI
 * Get current canister ID: dfx canister id dbank
 */
actor DBank {
  // Create value with initial value
  // The stable keyword turns the variable into a persisted variable, which retains its value between deployments
  stable var currentValue = 300;
  // Assign new value to the variable
  // currentValue := 100;
  // Assign a constant value that cannot be changed later on.
  let id = 232323232;

  Debug.print(debug_show(currentValue));
  // Debug.print(debug_show(currentValue));

  // dfx canister call dbank topUp
  public func topUp(amount: Nat) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Nat) {
    let tempVal: Int = currentValue - amount;

    if (tempVal >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Specified amount cannot be subtracted as it's more than the current value.");
    }
  };

  public query func checkBalance(): async Nat {
    return currentValue;
    // Debug.print(debug_show (currentValue));
  };

  //topUp();
};

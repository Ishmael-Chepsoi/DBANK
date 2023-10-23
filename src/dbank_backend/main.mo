import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor Dbank {
 stable var currentValue: Float = 300; //stable make a flexible variable a persistent variable.(orthogonal)
  // currentValue := 100; //***have comente here because it reset the stable var to 100

  let id = 1234567; //let is immutable
  

  // Debug.print(debug_show(currentValue));
  // Debug.print(debug_show(id));

  public func topUp(amount : Float) {
    currentValue += amount;
    // Debug.print(debug_show (currentValue));
  };
  // topUp();

  /***Time capture**/
  
  stable var startTime = Time.now();
  Debug.print(debug_show(startTime));

  public func withdrawl(amount : Float) {
    let tempValue : Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    } else {
      Debug.print("The number give a negative value");
    };
  };
  public query func checkBallance() : async Float {
    return currentValue;
  };

  public func compound(){
    let currentTime = Time.now();
    let timeElapsedNS = currentTime -startTime;
    let timeElapsedS = timeElapsedNS/1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;

  }
};
 
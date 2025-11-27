import static javax.swing.JOptionPane.*;

float Distance2;
float K;
int factor = 60;
void setup () {
  String Option = showInputDialog ("Enter 'A' to view time prediction | Enter 'B' to know your fitness level");
  if (Option.equals("A") || Option.equals("a")) {
    String BestPace = showInputDialog ("Enter your best pace: best pace-min/km");
    String Fatigue = showInputDialog ("choose your level of running: \n" + "ideal Runner - press 'N' \n" + "Fit Runner - press 'M' \n" + "Beginner - press 'H' \n");
    String Prediction = showInputDialog ("Enter a distance which you want to be calculated | distance in K");
    Predictor (BestPace, Prediction, Fatigue);
  } else if (Option.equals("B") || Option.equals("b")) {
    String FinishTime = showInputDialog ("Enter your actual Marathon finish Time");
    levelOfRunner (FinishTime);
  }
  //println (BestPace);
}

void Predictor (String BestPace, String Prediction, String Fatigue) {
  if (Fatigue.equals("N") || Fatigue.equals("n")){
  K = 1.00;
  println ("your level is - Ideal Runner");
  }
  else if (Fatigue.equals("M") || Fatigue.equals("m")) {
  K = 1.02;
  println ("your level is - Fit Runner");
  }
  else if (Fatigue.equals("H") || Fatigue.equals("H")) {
  K = 1.08;
  println ("your level is - Beginner");
  }
  int splitter = BestPace.indexOf("/");
  String PaceTime = BestPace.substring(0, splitter - 1);
  String PaceDistance = BestPace.substring(splitter +1);
  String[] Time = split(PaceTime, ':');
  float Min = float(Time[0]);
  float Second = float (Time[1]);
  float convertor = Second * 1/factor;
  float TotalMin = Min + convertor;
  float Distance1 = float(PaceDistance);

  Distance2 = float (Prediction);

  //riegel's formula Time2 = Time1*(Distance1/Distance2)^1.06
  float disRatio = Distance2/Distance1;
  float Time2 = TotalMin*pow(disRatio, K);
  //String Timestr = str(Time2);
  //String[] ActualTimeFormat = split(Timestr, ".");
  //int min2 = int (ActualTimeFormat[1]);
  //int min = int (ActualTimeFormat[0]);
  //int second = min2 * factor;
  println ("your predicted time for the given distance is: " + Time2 + " mins/" + Distance2);
  //println ("Actual time format- " + min + ":" + second);

}
  void levelOfRunner (String FinishTime) {
    String[] Time = split(FinishTime, ':');
    float hour = float(Time [0]);
    float min = float(Time [1]);
    float second = float(Time [2]);
    float TotalMin = hour*factor + min + second*1/factor;
    double K = Math.log10 (TotalMin)/Math.log10 (42);
    if (K >= 1.00 && K <= 1.02) {
      println ("-your decay rate konstant is: " + K + "\n your fitness level is: Elite/Advanced");
    }
    else if (K >= 1.03 && K <= 1.06) {
      println ("-your decay rate konstant is: " + K + "\n your fitness level is: intermidiate");
    }
    else if (K >= 1.07) {
      println ("your decay rate konstant is: " + K + "\n your fitness level is: Beginner \n");
      println ("---Thank you for using this system---");
    }
}

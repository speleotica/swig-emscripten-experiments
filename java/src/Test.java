import org.speleotica.unitized.Length;

public class Test {
  static {
    System.loadLibrary("unitized");
  }

  public static void main(String[] args) {
    System.out.println("3m + 5ft = " + Length.meters(3).add(Length.feet(5)).toFeet() + "ft");
  }
}

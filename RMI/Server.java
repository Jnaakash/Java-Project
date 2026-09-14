import java.rmi.Naming;
public class Server {
     
    public static void main(String [] args) {
        try {
            CalculatorImplement obj = new CalculatorImplement();
            Naming.rebind("rmi://localhost/Calculator", obj);
            System.out.println("RMI Server Started...");
        } 
        catch (Exception e) {
            System.out.println(e);
        }
    }
}
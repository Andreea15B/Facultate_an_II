import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Scanner;

public class SocialNetworkClient {
    private final static String SERVER_ADDRESS = "127.0.0.1";

    private final static int PORT = 8100;

    private static PrintWriter out;
    private static BufferedReader in;

    public static void main(String[] args) throws IOException {
        SocialNetworkClient client = new SocialNetworkClient();

        Socket socket = new Socket(SERVER_ADDRESS, PORT);
        out = new PrintWriter(socket.getOutputStream(), true);
        in = new BufferedReader (new InputStreamReader(socket.getInputStream()));

        while (true) {
            System.out.println("Enter a command");
            String request = client.readFromKeyboard();

            if (request.equalsIgnoreCase("exit")) {
                break;
            } else {
                client.sendRequestToServer(request);
            }
        }
    }

    private void sendRequestToServer(String request) {
        try {
            // Send a request to the server
            out.println(request);

            // Wait the response from the server
            String response = in.readLine ();
            System.out.println(response);

        } catch (UnknownHostException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String readFromKeyboard() {
        Scanner scanner = new Scanner(System.in);
        return scanner.nextLine();
    }
}
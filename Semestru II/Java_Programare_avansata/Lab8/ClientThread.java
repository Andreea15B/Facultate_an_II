package server;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class ClientThread extends Thread {
    private Socket socket = null;
    private final SocialNetworkServer server;

    public ClientThread(Socket socket, SocialNetworkServer server) {
        this.socket = socket;
        this.server = server;
    }

    public void run() {
        try {
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream())); //client -> server stream
            PrintWriter out = new PrintWriter(socket.getOutputStream()); //server -> client stream
            while(true) {
                String request = in.readLine();
                String response = execute(request);
                System.out.println(response);
                out.println(response);
                out.flush();
            }
        }
        catch (IOException e) {
            System.err.println("Communication error...  " + e);
        } finally {
            try {
                socket.close();
            } catch (IOException e) { System.err.println (e); }
        }
    }
    private String execute(String request) throws IOException {
        System.out.println("Server received the request " + request );
        return "Done";
    }
}

package server;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class SocialNetworkServer {
    private static final int PORT = 8100;
    private ServerSocket serverSocket;
    private boolean running = false;

    public static void main(String[] args) {
        SocialNetworkServer server = new SocialNetworkServer();
        server.init();
        server.waitForClients(); //... handle the exceptions!
    }

    private void init() {
        try {
            serverSocket = new ServerSocket(PORT);
        } catch (IOException e) {
            e.printStackTrace();
        }
        running = true;
    }
    // Implement the init() method: create the serverSocket and set running to true
    // Implement the waitForClients() method: while running is true, create a new socket for every incoming client and start a ClientThread to execute its request.

    private void waitForClients() {
        while (running) {
            System.out.println(" Waiting client... ");
            try {
                Socket socket = serverSocket.accept();
                new ClientThread(socket, this).start();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
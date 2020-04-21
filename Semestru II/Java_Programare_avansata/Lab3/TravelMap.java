import java.util.ArrayList;
import java.util.*;

public class TravelMap {
    ArrayList<Node> nodes = new ArrayList<>();
    ArrayList<Edge> edges = new ArrayList<>();

    public void addNode (Node v1){
        nodes.add(v1);
    }

    public void addEdge (Node v1, Node v2, int cost){
        edges.add(new Edge(v1, v2, cost));
    }

    public void addEdge (Node v1, Node v2, int cost, boolean edgeIsTwoWay){
        edges.add(new Edge(v1, v2, cost, edgeIsTwoWay));
    }

    public ArrayList<Node> getNodes () {
        return nodes;
    }
}

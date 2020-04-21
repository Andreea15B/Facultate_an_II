public class Edge {
    Node n1, n2;
    int cost;
    boolean twoWay;
    Edge(Node n1, Node n2, int cost) {
        this.n1 = n1;
        this.n2 = n2;
        this.cost = cost;
        this.twoWay = true;
    }

    Edge(Node n1, Node n2, int cost, boolean edgeIsTwoWay) {
        this.n1 = n1;
        this.n2 = n2;
        this.cost = cost;
        this.twoWay = edgeIsTwoWay;
    }
}

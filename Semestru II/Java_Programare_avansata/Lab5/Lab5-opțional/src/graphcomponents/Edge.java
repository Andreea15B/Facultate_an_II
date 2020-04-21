/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcomponents;

/**
 *
 * @author Tifir
 */
public class Edge {

    private Node firstNode;
    private Node secondNode;

    public Edge(Node firstNode, Node secondNode)
    {
        this.firstNode = firstNode;
        this.secondNode = secondNode;
    }

    public Node getFirstNode() {
        return firstNode;
    }

    public void setFirstNode(Node firstNode) {
        this.firstNode = firstNode;
    }

    public Node getSecondNode() {
        return secondNode;
    }

    public void setSecondNode(Node secondNode) {
        this.secondNode = secondNode;
    }
}

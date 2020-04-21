package com.company.graph;

public class Node {
    private static int nodeNumber = 0;

    // constructor
    private Node()
    {
        this.nodeNumber++;
    }

    // getters and setters

    public int getNodeNumber() {
        return nodeNumber;
    }

    public void setNodeNumber(int nodeNumber) {
        this.nodeNumber = nodeNumber;
    }
}

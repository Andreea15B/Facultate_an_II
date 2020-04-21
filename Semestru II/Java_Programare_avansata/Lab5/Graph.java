package com.company.graph;

import java.util.ArrayList;

public class Graph {
    private String name;
    private String description;
    private String type;
    private int noOfNodes;
    private int noOfEdges;
    private String definitionFilePath;


    ArrayList <Node> nodes = new ArrayList<>();
    ArrayList <Edge> edges = new ArrayList<>();

    // constructors

    public Graph(String name)
    {
        this.name = name;
    }

    public Graph(String name, String type) {
        this.name = name;
        this.type = type;
    }

    public Graph(String name, String type, int noOfNodes, int noOfEdges, String definitionFilePath) {
        this.name = name;
        this.type = type;
        this.noOfNodes = noOfNodes;
        this.noOfEdges = noOfEdges;
        this.definitionFilePath = definitionFilePath;
    }


    // getters and setters

    public int getNoOfNodes() {
        return noOfNodes;
    }

    public void setNoOfNodes(int noOfNodes) {
        this.noOfNodes = noOfNodes;
    }

    public int getNoOfEdges() {
        return noOfEdges;
    }

    public void setNoOfEdges(int noOfEdges) {
        this.noOfEdges = noOfEdges;
    }

    public String getDefinitionFilePath() {
        return definitionFilePath;
    }

    public void setDefinitionFilePath(String definitionFilePath) {
        this.definitionFilePath = definitionFilePath;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public ArrayList<Node> getNodes() {
        return nodes;
    }

    public void setNodes(ArrayList<Node> nodes) {
        this.nodes = nodes;
    }

    public ArrayList<Edge> getEdges() {
        return edges;
    }

    public void setEdges(ArrayList<Edge> edges) {
        this.edges = edges;
    }

    public void addNode(Node n)
    {
        nodes.add(n);
    }

    public void addEdge(Node n1, Node n2) {
        Edge edge = new Edge(n1,n2);
        edges.add(edge);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
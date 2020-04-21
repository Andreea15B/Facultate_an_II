/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcomponents;

import java.util.ArrayList;

/**
 *
 * @author Tifir
 */
public class Graph {
    private String name;
    private String description;
    private String type;
    private int noOfNodes;
    private int noOfEdges;
    private String definitionFilePath;
    private String definitionImgPath;


    ArrayList <Node> nodes = new ArrayList<>();
    ArrayList <Edge> edges = new ArrayList<>();

    public Graph()
    {
        
    }
    public Graph(String name)
    {
        this.name = name;
    }

    public Graph(String name, String type)
    {
        this.name = name;
        this.type = type;
    }

    public Graph(String name, String type, int noOfNodes, int noOfEdges, String definitionFilePath,String definitionImgPath) {
        this.name = name;
        this.type = type;
        this.noOfNodes = noOfNodes;
        this.noOfEdges = noOfEdges;
        this.definitionFilePath = definitionFilePath;
        this.definitionImgPath = definitionImgPath;
    }

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
 public String getDefinitionImgPath() {
        return definitionImgPath;
    }
    public void setDefinitionFilePath(String definitionFilePath) {
        this.definitionFilePath = definitionFilePath;
    }
 public void setDefinitionImgPath(String definitionFilePath) {
        this.definitionImgPath = definitionFilePath;
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

    public void addEdge(Node n1, Node n2)
    {
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

    @Override
    public String toString() {
        return name + ","+ type + ",n"+noOfNodes + ",m="+ noOfEdges + "," + definitionFilePath + "," + definitionImgPath ;
    }
    
}

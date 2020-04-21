package com.company.catalog;

import com.company.graph.Graph;

import java.util.ArrayList;

public class Catalog {
    private String name;
    private ArrayList<Graph> graphs = new ArrayList<>();

    public Catalog(String name)
    {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ArrayList<Graph> getGraphs() {
        return graphs;
    }

    public void setGraphs(ArrayList<Graph> graphs) {
        this.graphs = graphs;
    }

    public void addGraph(Graph g1) {
        graphs.add(g1);
    }
}

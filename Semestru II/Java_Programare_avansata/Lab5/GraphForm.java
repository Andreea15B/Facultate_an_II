package com.company.gui;

import javax.swing.*;
import javax.swing.border.LineBorder;
import java.awt.*;

/**
 * GraphForm - the form for adding new graphs
 */
public class GraphForm extends JPanel {
    JPanel northPanel = new JPanel();

    // name stuff
    final JLabel nameLabel = new JLabel("Name");
    final JLabel typeLabel = new JLabel("Type");
    final JLabel pathLabel = new JLabel("Path");
    final JLabel edgesLabel = new JLabel("NoOfEdges");
    final JLabel nodesLabel = new JLabel("NoOfNodes");

    JTextField name = new JTextField();
    JTextField path = new JTextField();

    // type
    final JComboBox<String> type = new JComboBox<>();

    //edges and nodes
    JSpinner noOfNodes;
    JSpinner noOfEdges;

    // add button
    final JButton addButton = new JButton("Add");

    public GraphForm() {
        init();
    }

    public void init() {
        setNoOfNodesAndEdges();
        setType();

        // add buttons labels
        northPanel.setBorder(new LineBorder((Color.black),2));
        northPanel.setLayout(new GridLayout(11,2));
        northPanel.add(nameLabel);
        northPanel.add(name);
        northPanel.add(typeLabel);
        northPanel.add(type);
        northPanel.add(pathLabel);
        northPanel.add(path);
        northPanel.add(edgesLabel);
        northPanel.add(noOfEdges);
        northPanel.add(nodesLabel);
        northPanel.add(noOfNodes);
        northPanel.add(addButton);
    }

    public void setType() {
        type.addItem("simple");
        type.addItem("directed");
    }

    public void setNoOfNodesAndEdges() {
        SpinnerModel values2 = new SpinnerNumberModel(1,1,100,1);
        SpinnerModel values = new SpinnerNumberModel(0,0,100*99,1);
        noOfEdges = new JSpinner(values);
        noOfNodes = new JSpinner(values2);
    }

    // getters and setters

    public JPanel getNorthPanel() {
        return northPanel;
    }
    public JTextField getTheName() {
        return name;
    }
    public JTextField getPath() {
        return path;
    }
    public JComboBox<String> getType() {
        return type;
    }
    public JSpinner getNoOfNodes() {
        return noOfNodes;
    }
    public JSpinner getNoOfEdges() {
        return noOfEdges;
    }
}

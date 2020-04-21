package com.company.gui;

import javax.swing.*;

/**
 * CatalogList - the list of graphs
 */
public class CatalogList extends JList {
    JPanel listPanel = new JPanel();
    DefaultListModel<String> listModel = new DefaultListModel<>();
    JList<String> listOfGraphs ;

    // constructor
    public CatalogList() {
        init();
    }

    private void init() {
        listModel.addElement("Petersen Graph");
        listModel.addElement("K3 - Complete Graph");
        listModel.addElement("Random Graph");
        listOfGraphs = new JList<>(listModel);
        listPanel.add(listOfGraphs);
    }

    // getters and setters
    public JPanel getListPanel() {
        return listPanel;
    }

    public void setListPanel(JPanel listPanel) {
        this.listPanel = listPanel;
    }

    public DefaultListModel<String> getListModel() {
        return listModel;
    }

    public void setListModel(DefaultListModel<String> listModel) {
        this.listModel = listModel;
    }

    public JList<String> getListOfGraphs() {
        return listOfGraphs;
    }

    public void setListOfGraphs(JList<String> listOfGraphs) {
        this.listOfGraphs = listOfGraphs;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphgui;

import graphcomponents.Graph;
import java.awt.BorderLayout;
import javax.swing.BorderFactory;
import javax.swing.DefaultListModel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.ScrollPaneConstants;

/**
 *
 * @author maria
 */
public class CatalogList extends JList {
     JPanel listPanel = new JPanel();
    DefaultListModel<Graph> listModel = new DefaultListModel<>();

    JList<Graph> listOfGraphs ;

    public CatalogList()
    {
        init();
    }
    private void init()
    {
        Graph temp = new Graph("K3","simple",3,3,"D:\\Facultate\\ProiecteJava\\Lab5\\src\\tgffiles\\k3.tgf","D:\\Facultate\\ProiecteJava\\Lab5\\src\\tgffiles\\Graph_K3.png");
        listModel.addElement(temp);
        listOfGraphs=new JList<Graph>(listModel);
        listOfGraphs.ensureIndexIsVisible(10);
        listPanel.add(listOfGraphs);
    }

    public JPanel getListPanel() {
        return listPanel;
    }

    public void setListPanel(JPanel listPanel) {
        this.listPanel = listPanel;
    }

    public DefaultListModel<Graph> getListModel() {
        return listModel;
    }

    public void setListModel(DefaultListModel<Graph> listModel) {
        this.listModel = listModel;
    }

    public JList<Graph> getListOfGraphs() {
        return listOfGraphs;
    }

    public void setListOfGraphs(JList<Graph> listOfGraphs) {
        this.listOfGraphs = listOfGraphs;
    }
}

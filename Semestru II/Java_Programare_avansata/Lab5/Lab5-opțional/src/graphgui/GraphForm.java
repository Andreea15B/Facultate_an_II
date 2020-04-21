/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphgui;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridLayout;
import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSpinner;
import javax.swing.JTextField;
import javax.swing.SpinnerListModel;
import javax.swing.SpinnerModel;
import javax.swing.SpinnerNumberModel;
import javax.swing.border.Border;
import javax.swing.border.LineBorder;

/**
 *
 * @author maria
 */
public class GraphForm extends JPanel {
   
    JPanel northPanel=new JPanel();

    /**
     * Labels
     */
    final JLabel nameLabel = new JLabel("Name");
    final JLabel typeLabel = new JLabel("Type");
    final JLabel pathLabel = new JLabel("Path");
    final JLabel imgLabel = new JLabel("Image");
    final JLabel edgesLabel = new JLabel("NoOfEdges");
    final JLabel nodesLabel = new JLabel("NoOfNodes");

     JTextField name = new JTextField();
     JTextField path = new JTextField();
     JTextField image = new JTextField();

    final JComboBox<String> type = new JComboBox<>();


    JSpinner noOfNodes ;
    JSpinner noOfEdges ;

    final JButton addButton = new JButton("Add");

    public GraphForm()
    {
        init();
    }

    public void init()
    {
        setNoOfNodesAndEdges();
        setType();
        /**
         * add button labels and buttons
         */
        northPanel.setBorder(new LineBorder((Color.black),2));
        northPanel.setLayout(new GridLayout(13,2));
        northPanel.add(nameLabel);
        northPanel.add(name);
        northPanel.add(typeLabel);
        northPanel.add(type);
        northPanel.add(imgLabel);
        northPanel.add(image);
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


        SpinnerModel values2= new SpinnerNumberModel(1,1,100,1);

        SpinnerModel values= new SpinnerNumberModel(0,0,100*99,1);

        noOfEdges= new JSpinner(values);
        noOfNodes=new JSpinner(values2);
    }

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
    public JTextField getImg()
    {
        return image;
    }
}

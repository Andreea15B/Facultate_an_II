package com.company.gui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * CatalogFrame - the main frame of the application.
 */
public class CatalogFrame extends JFrame {
    GraphForm form = new GraphForm();
    CatalogList list = new CatalogList();
    ControlPanel control = new ControlPanel();

    // constructor
    public CatalogFrame() {
        super("Graph Manager");
        init();
    }

    private void init() {
        Container c = this.getContentPane();

        this.setSize(640,640);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setVisible(true);

        c.setComponentOrientation(ComponentOrientation.LEFT_TO_RIGHT);
        c.add(form.northPanel, BorderLayout.NORTH);
        c.add(list.listPanel, BorderLayout.CENTER);
        c.add(control.controlPanel, BorderLayout.SOUTH);

       this.form.addButton.addActionListener(new ActionListener() {
           @Override
           public void actionPerformed(ActionEvent e) {
               String text = form.getTheName().getText() +" "+ form.getType().getSelectedItem()+" " + form.getNoOfEdges().getValue() +" " +
                       form.getNoOfNodes().getValue() +" " + form.getPath().getText();
                list.getListModel().add(list.getListModel().getSize(), text);
           }
       });

    }
}

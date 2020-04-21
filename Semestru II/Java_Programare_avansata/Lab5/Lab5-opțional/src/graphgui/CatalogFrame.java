/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphgui;

import graphcatalog.Catalog;
import graphcomponents.Graph;
import java.awt.BorderLayout;
import java.awt.ComponentOrientation;
import java.awt.Container;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JFrame;

/**
 *
 * @author maria
 */
public class CatalogFrame extends JFrame {
 private GraphForm form=new GraphForm();
 private CatalogList list= new CatalogList();
 private ControlPanel control= new ControlPanel();
 static Catalog tmpCatalog = new Catalog("E:\\Facultate\\ProiecteJava\\Lab5\\src\\tgffiles");

    public CatalogFrame()
    {
        super("Graph Manager");
        init();
    }

    /**
     *set close operation
     * add forms
     */
    private void init()
    {
         Graph temp = new Graph("K3","simple",3,3,"D:\\Facultate\\ProiecteJava\\Lab5\\src\\tgffiles\\k3.tgf","D:\\Facultate\\ProiecteJava\\Lab5\\src\\tgffiles\\Graph_K3.png");
         tmpCatalog.add(temp);
         temp = new Graph("K4","simple",4,8,"E:\\Facultate\\ProiecteJava\\Lab5\\src\\tgffiles\\k4.tgf","E:\\Facultate\\ProiecteJava\\Lab5\\src\\tgffiles\\Graph_K4.png");
         tmpCatalog.add(temp);
         Container c=this.getContentPane();
        this.setSize(800,640);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setVisible(true);

        c.setComponentOrientation(ComponentOrientation.LEFT_TO_RIGHT);

        c.add(form.northPanel, BorderLayout.NORTH);
        c.add(list.listPanel, BorderLayout.CENTER);
        c.add(control.controlPanel, BorderLayout.SOUTH);

        /**
         * set action for Add button
         */
        this.form.addButton.addActionListener(new ActionListener() {
           @Override
           public void actionPerformed(ActionEvent e) {


               Graph tmp= new Graph();
               tmp.setName(form.getTheName().getText());
               tmp.setType((String)form.getType().getSelectedItem());
               tmp.setNoOfEdges((int)form.getNoOfEdges().getValue());
               tmp.setNoOfNodes((int)form.getNoOfNodes().getValue());
               tmp.setDefinitionFilePath(form.getPath().getText());
               tmp.setDefinitionImgPath(form.getImg().getText());
                list.getListModel().add(list.getListModel().getSize(),tmp); 
              tmpCatalog.add(tmp);
           }
       });
    }
}
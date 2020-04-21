/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphgui;
import graphcatalog.Catalog;
import graphcatalogcommands.OpenCommand;
import graphcomponents.Graph;
import java.awt.Button;
import java.awt.Color;
import java.awt.Desktop;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.Action;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.border.LineBorder;
/**
 *
 * @author maria
 */
public class ControlPanel extends JPanel  {
     JPanel controlPanel = new JPanel();

    Button saveButton = new Button("Save");
    Button loadButton = new Button("Load");
    Button listButton = new Button("List");
    Button openButton = new Button("Open");
    Button reportButton = new Button("Report");
     JFileChooser fc;
    Catalog catalog = CatalogFrame.tmpCatalog;
    public ControlPanel ()
    {
        init();
    }

    /**
     * set layout
     * add buttons
     */
    private void init()
    {
        
        controlPanel.setBorder(new LineBorder((Color.black),2));
        controlPanel.setLayout(new GridLayout(1,4));
        controlPanel.add(saveButton);
        controlPanel.add(loadButton);
        controlPanel.add(listButton);
        controlPanel.add(openButton);
        controlPanel.add(reportButton);
        this.openButton.addActionListener(new ActionListener(){
            @Override
            public void actionPerformed(ActionEvent e) {

                if(e.getSource()==openButton)
                {

                    try {
                        catalog.open();
                    } catch (IOException ex) {
                        System.out.println("Erroare la deschidere!");
                    }
                   
                 
                }
               
          }
         });
        this.saveButton.addActionListener(new ActionListener(){

            @Override
            public void actionPerformed(ActionEvent e) {
                if(e.getSource()==saveButton)
                    {

                    try {
                        catalog.save();
                    } catch (IOException ex) {
                        System.out.println("Crapa");
                    }
                 }
            }
        });
        this.loadButton.addActionListener(new ActionListener(){
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    catalog.load();
                } catch (IOException ex) {
                    System.out.println("Output not found for load!");
                } catch (ClassNotFoundException ex) {
                    System.out.println("Class not found for load!");
                }
            }
        });
        this.reportButton.addActionListener(new ActionListener(){

            @Override
            public void actionPerformed(ActionEvent e) {
               if(e.getSource()==reportButton)
               {
                 
                   try {
                       catalog.html();
                   } catch (IOException ex) {
                       System.out.println("Erroar la report!");
                   }
               }
            }
        });
        this.listButton.addActionListener(new ActionListener(){
            @Override
            public void actionPerformed(ActionEvent e) {
                       catalog.list();
            }
            
        });
    }
}

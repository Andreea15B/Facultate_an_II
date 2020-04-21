package com.company.gui;

import javax.swing.*;
import javax.swing.border.LineBorder;
import java.awt.*;

/**
 * ControlPanel - the command buttons
 */
public class ControlPanel extends JPanel {
    JPanel controlPanel = new JPanel();

    Button saveButton = new Button("Save");
    Button loadButton = new Button("Load");
    Button listButton = new Button("List");
    Button openButton = new Button("Open");

    // constructor
    public ControlPanel() {
        init();
    }

    private void init() {
        controlPanel.setBorder(new LineBorder((Color.black),2));
        controlPanel.setLayout(new GridLayout(1,4));
        controlPanel.add(saveButton);
        controlPanel.add(loadButton);
        controlPanel.add(listButton);
        controlPanel.add(openButton);
    }
}

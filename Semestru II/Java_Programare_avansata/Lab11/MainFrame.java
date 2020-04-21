package mainframe;

import java.awt.BorderLayout;
import javax.swing.JFrame;
import panel.ControlPanel;
import panel.DesignPanel;

/**
 * The class MainFrame of type JFrame will represent the main class of the application.
 * The frame will contain a ControlPanel in the north and a DesignPanel in the center.
 */
public class MainFrame extends JFrame {
    public ControlPanel controlPanel;
    public DesignPanel designPanel;
    public MainFrame() {
        super("Swing Designer");
        init();
    }
    private void init() {
        controlPanel = new ControlPanel(this);
        designPanel = new DesignPanel(this);
        setLayout(new BorderLayout());
        add(designPanel, BorderLayout.CENTER);
        add(controlPanel, BorderLayout.NORTH);
        pack();
    }
    public static void main(String args[]){
        new MainFrame().setVisible(true);
    }
}
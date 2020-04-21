package panel;

import java.awt.Dimension;
import java.util.Random;
import javax.swing.JComponent;
import javax.swing.JPanel;
import mainframe.MainFrame;

/**
 * The DesignPanel represents a simple JPanel, using absolute positioning of its components and
 * containing Swing components added by our application.
 */
public class DesignPanel extends JPanel {
    public static final int W = 800, H = 600;
    private final MainFrame frame;
    public DesignPanel(MainFrame frame) {
        this.frame = frame;
        setPreferredSize(new Dimension(W, H));
        setLayout(null);
    }
    public static int randInt(int min, int max) {
        Random rand = new Random();
        int randomNum = rand.nextInt((max - min) + 1) + min;
        return randomNum;
    }
    public void addAtRandomLocation(JComponent comp) {
        int x = randInt(0, W-1);
        int y = randInt(0, H-1);
        int w = comp.getPreferredSize().width;
        int h = comp.getPreferredSize().height;
        comp.setBounds(x, y, w, h);
        comp.setToolTipText(comp.getClass().getName());
        this.add(comp);
        frame.repaint();
    }
}
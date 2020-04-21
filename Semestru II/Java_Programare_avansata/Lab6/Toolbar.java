import javax.swing.*;
import javax.swing.border.LineBorder;
import java.awt.*;

/**
 * Toolbar - the panel for specifying parameters regarding the shapes that will be drawn.
 */
public class Toolbar extends JPanel{
    final JLabel sizeLabel = new JLabel("Size");
    final JLabel strokeLabel = new JLabel("Stroke");

    JSpinner sizeGraph = new JSpinner();
    JTextField strokeGraph = new JTextField();

    public Toolbar(){
        SpinnerModel value = new SpinnerNumberModel(25,25,75,5);
        sizeGraph = new JSpinner(value);
        init();
    }

    public JLabel getSizeLabel() {
        return sizeLabel;
    }

    public JLabel getStrokeLabel() {
        return strokeLabel;
    }

    public JSpinner getSizeGraph() {
        return sizeGraph;
    }

    public JTextField getStrokeGraph() {
        return strokeGraph;
    }

    void init() {
        this.setBorder(new LineBorder((Color.BLACK),1));
        this.setLayout(new GridLayout(2,4));
        this.add(sizeLabel);
        this.add(sizeGraph);
        this.add(strokeLabel);
        this.add(strokeGraph);
    }
}

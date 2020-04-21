import javax.swing.*;
import javax.swing.border.LineBorder;
import java.awt.*;

/**
 * Control panel - for managing the image being created
 */
public class ControlPanel extends JPanel {
    Button saveButton = new Button("Save");
    Button loadButton = new Button("Load");
    Button resetButton = new Button("Reset");

    public ControlPanel() {
        init();
    }

    private void init() {
        this.setBorder(new LineBorder((Color.BLACK),1));
        this.setLayout(new GridLayout(1,3));
        this.add(saveButton);
        this.add(loadButton);
        this.add(resetButton);
    }
}

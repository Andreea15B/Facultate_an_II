import javax.swing.*;
import java.awt.*;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

/**
 * DrawingFrame - the main frame of the application
 */
public class DrawingFrame extends JFrame {
    Canvas form = new Canvas();
    Toolbar bar = new Toolbar();
    ControlPanel control = new ControlPanel();

    public Canvas getForm() {
        return form;
    }

    public Toolbar getBar() {
        return bar;
    }

    public ControlPanel getControl() {
        return control;
    }

    public DrawingFrame() {
        super("Drawing Graphs");
        init();
        form.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                form.drawNode(e.getX(), e.getY(), (int) bar.getSizeGraph().getValue());
            }
        });
    }

    public void init() {
        Container c = this.getContentPane();
        this.setSize(1200,800);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        c.setComponentOrientation(ComponentOrientation.LEFT_TO_RIGHT);
        c.add(bar, BorderLayout.NORTH);
        c.add(form, BorderLayout.CENTER);
        c.add(control, BorderLayout.SOUTH);
        this.setVisible(true);
    }
}

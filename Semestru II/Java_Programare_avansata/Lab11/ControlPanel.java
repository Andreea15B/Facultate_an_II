package panel;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import mainframe.MainFrame;

/**
 * The ControlPanel will allow the user to specify any class name of a Swing component
 * (such as javax.swing.JButton, javax.swing.JLabel, etc.), a default text for that component (if applicable)
 * and a button for creating and adding an instance of the specified component to the DesignPanel.
 */
public class ControlPanel extends JPanel {
    private final MainFrame frame;
    private final JLabel classNameLabel = new JLabel("Class name");
    private final JTextField classNameField = new JTextField(30);
    private final JLabel textLabel = new JLabel("Default text");
    private final JTextField textField = new JTextField(10);
    private final JButton createButton = new JButton("Add component");

    public ControlPanel(MainFrame frame) {
        this.frame = frame;
        init();
    }
    private void init() {
        add(classNameLabel); add(classNameField); add(textLabel); add(textField); add(createButton);
        createButton.addActionListener(e -> {
            JComponent comp = null;
            try {
                comp = createDynamicComponent(classNameField.getText());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            try {
                setComponentText(comp, textField.getText());
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            frame.designPanel.addAtRandomLocation(comp);
        });
    }
    private JComponent createDynamicComponent(String className) throws ClassNotFoundException, IllegalAccessException, InstantiationException, NoSuchMethodException, InvocationTargetException {
        String componentClassName = "javax.swing." + className;
        JComponent component = (JComponent)Class.forName(componentClassName).getDeclaredConstructor().newInstance();
        return component;
    }
    private void setComponentText(JComponent comp, String text) throws IllegalAccessException, IllegalArgumentException {
        Method[] methods = comp.getClass().getMethods();
        for(int index = 0; index < methods.length; index++)
            if(methods[index].getName().equals("setText"))
                try {
                    methods[index].invoke(comp, text);
                } catch (InvocationTargetException ex) {
                    ex.printStackTrace();
                }
    }
}
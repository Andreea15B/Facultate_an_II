import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.LinkedList;
import java.util.Random;

/**
 * Canvas for drawing nodes
 * The nodes are represented as color-filled circles. This panel is placed in the center part of the frame.
 */
public class Canvas extends JPanel {
    private java.util.List<NodeShape> circles = new LinkedList<NodeShape>();
    BufferedImage image;
    Graphics2D graphics ;
    Dimension size = getSize();

    Canvas(){
        init();
    }

    public void init(){
        this.image = new BufferedImage(1000, 600, BufferedImage.TYPE_INT_ARGB);
        this.graphics = image.createGraphics();
        graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        graphics.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
    }

    public void drawNode(int  x, int y, int radius) {
        Random rand = new Random();
        graphics.setColor(new Color(rand.nextInt(0xFFFFFF))); //you may use a random color or the one specified in the toolbar
        graphics.fill(new NodeShape(x, y, radius));
        repaint();
    }

    @Override
    public void paint(Graphics g) {
        g.drawImage(image,0,0,this);
    }
}

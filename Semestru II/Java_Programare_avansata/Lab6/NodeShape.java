import java.awt.geom.Ellipse2D;

/**
 * NodeShape - defines the shape of a node
 */
public class NodeShape extends Ellipse2D.Double {
    public NodeShape(int x0, int y0, int radius) {
        super(x0 - radius / 2, y0 - radius / 2, radius, radius);
    }
}

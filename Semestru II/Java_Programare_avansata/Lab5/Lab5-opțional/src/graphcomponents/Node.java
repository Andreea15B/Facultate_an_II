/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcomponents;

/**
 *
 * @author Tifir
 */
public class Node {
    private static int nodeNumber=0;

    private Node()
    {
        this.nodeNumber++;
    }

    public int getNodeNumber() {
        return nodeNumber;
    }

    public void setNodeNumber(int nodeNumber) {
        this.nodeNumber = nodeNumber;
    }
}

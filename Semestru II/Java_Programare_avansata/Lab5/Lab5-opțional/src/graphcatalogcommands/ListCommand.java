/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcatalogcommands;

import graphcomponents.Graph;
import java.util.List;
import graphcatalogcommandinterface.Lyst;
import java.awt.BorderLayout;
import javax.swing.JFrame;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;

/**
 *
 * @author maria
 */
public class ListCommand extends JFrame implements Lyst  {

    @Override
    public void listCatalog(List<Graph> listCatalog) {
     

        Object[][] input={{"K3","simple",3,3,"E:\\Facultate\\ProiecteJava\\Lab5\\src\\tgffiles\\k3.tgf","E:\\Facultate\\ProiecteJava\\Lab5\\src\\tgffiles\\Graph_K3.png"},
            {"K4","simple",4,8,"E:\\Facultate\\ProiecteJava\\Lab5\\src\\tgffiles\\k4.tgf","E:\\Facultate\\ProiecteJava\\Lab5\\src\\tgffiles\\Graph_K4.png"}};
        DefaultTableModel tmp = new DefaultTableModel();
        tmp.addColumn("Name");
        tmp.addColumn("Type");
        tmp.addColumn("Nodes");
        tmp.addColumn("Edges");
        tmp.addColumn("PathToTGF");
        tmp.addColumn("PathToImage");
        tmp.addRow(input);

           for(Graph i:listCatalog)
        {
            tmp.addRow((new Object[]{i.getName(),i.getType(),i.getNoOfNodes(),i.getNoOfEdges(),i.getDefinitionFilePath(),i.getDefinitionImgPath()}));
        }
         JTable table = new JTable(tmp);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());
        setSize(540,320);
        add(table,BorderLayout.CENTER);
        setLocationRelativeTo(null);
        setVisible(true);
    }
    
}

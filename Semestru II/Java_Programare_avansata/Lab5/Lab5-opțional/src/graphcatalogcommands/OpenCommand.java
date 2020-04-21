/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcatalogcommands;
import graphcomponents.Graph;
import java.awt.Desktop;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import graphcatalogcommandinterface.Open;
import java.awt.image.BufferedImage;
import javax.swing.JFileChooser;
/**
 *
 * @author maria
 */
public class OpenCommand implements Open {

    @Override
    public void openCatalog() throws IOException   {
                 final JFileChooser fc = new JFileChooser();
                 fc.setDialogTitle("Open a file.");
                 fc.setCurrentDirectory(new File("E:\\Facultate\\ProiecteJava\\Lab5\\src\\tgffiles"));
                 String imgPath=null;
                int result=fc.showOpenDialog(fc);
                if(result == JFileChooser.APPROVE_OPTION)
                   {
                     imgPath = fc.getSelectedFile().getAbsolutePath();
                     BufferedImage img = null;
                      Desktop viewer = Desktop.getDesktop();
                    File file = new File(imgPath);
                       try {
                           viewer.open(file);
                       } catch (IOException ex) {
                           System.out.println("N-a mers");
                       }
                   }
    }
    
}

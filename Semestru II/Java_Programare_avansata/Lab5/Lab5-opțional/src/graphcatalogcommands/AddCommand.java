/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcatalogcommands;
import graphcomponents.Graph;
import java.util.List;
import graphcatalogcommandinterface.Add;
/**
 *
 * @author maria
 */
public class AddCommand implements Add{

    public List<Graph> addGraphToCatalog(Graph addItem, List<Graph> addList) {
         addList.add(addItem);
         return addList;
    }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcatalogcommandinterface;

import graphcomponents.Graph;
import java.util.List;
/**
 *
 * @author maria
 */
public interface Add {
    public List<Graph> addGraphToCatalog(Graph addItem,List<Graph> addList);
}

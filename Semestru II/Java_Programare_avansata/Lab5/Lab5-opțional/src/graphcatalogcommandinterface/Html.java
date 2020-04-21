/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package graphcatalogcommandinterface;

import graphcomponents.Graph;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author maria
 */
public interface Html  {
    public void reportHTML(String location,List<Graph> catalog)throws FileNotFoundException,IOException;
}

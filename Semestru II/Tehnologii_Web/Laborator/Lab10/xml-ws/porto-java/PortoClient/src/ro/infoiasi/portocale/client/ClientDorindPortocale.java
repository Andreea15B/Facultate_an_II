/* Pachet ce include o clasa implementand un client SOAP
 * pentru serviciul Web furnizand date despre stocul de portocale.
 * Autor: Sabin Buraga -- http://profs.info.uaic.ro/~busaco/
 * Ultima actualizare: 11 aprilie 2016
 */
package ro.infoiasi.portocale.client;

import ro.infoiasi.portocale.*;

public class ClientDorindPortocale {

	public static void main (String[] args) {
		try {
			// instantiem serviciul pe baza clasei ciot 
			// generate in prealabil cu utilitarul 'wsimport'
			PortocaleService serviciu = new PortocaleService ();
			Portocale porto = serviciu.getPortocalePort ();

			// apelam metodele expuse de serviciu
			System.out.println ("Stocul de portocale albastre are valoarea " +
					porto.furnizeazaStoc ("albastre") * 
					porto.furnizeazaPret ());
		} catch (Exception e) {
			System.err.println ("A survenit o exceptie...\n" + 
					e.getMessage ());
		}
	}

}

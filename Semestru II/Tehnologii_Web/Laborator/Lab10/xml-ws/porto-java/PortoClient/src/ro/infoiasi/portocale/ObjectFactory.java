
package ro.infoiasi.portocale;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlElementDecl;
import javax.xml.bind.annotation.XmlRegistry;
import javax.xml.namespace.QName;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the ro.infoiasi.portocale package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _FurnizeazaPretResponse_QNAME = new QName("http://portocale.infoiasi.ro/", "furnizeazaPretResponse");
    private final static QName _FurnizeazaPret_QNAME = new QName("http://portocale.infoiasi.ro/", "furnizeazaPret");
    private final static QName _FurnizeazaStoc_QNAME = new QName("http://portocale.infoiasi.ro/", "furnizeazaStoc");
    private final static QName _FurnizeazaStocResponse_QNAME = new QName("http://portocale.infoiasi.ro/", "furnizeazaStocResponse");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: ro.infoiasi.portocale
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link FurnizeazaPret }
     * 
     */
    public FurnizeazaPret createFurnizeazaPret() {
        return new FurnizeazaPret();
    }

    /**
     * Create an instance of {@link FurnizeazaStocResponse }
     * 
     */
    public FurnizeazaStocResponse createFurnizeazaStocResponse() {
        return new FurnizeazaStocResponse();
    }

    /**
     * Create an instance of {@link FurnizeazaStoc }
     * 
     */
    public FurnizeazaStoc createFurnizeazaStoc() {
        return new FurnizeazaStoc();
    }

    /**
     * Create an instance of {@link FurnizeazaPretResponse }
     * 
     */
    public FurnizeazaPretResponse createFurnizeazaPretResponse() {
        return new FurnizeazaPretResponse();
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link FurnizeazaPretResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://portocale.infoiasi.ro/", name = "furnizeazaPretResponse")
    public JAXBElement<FurnizeazaPretResponse> createFurnizeazaPretResponse(FurnizeazaPretResponse value) {
        return new JAXBElement<FurnizeazaPretResponse>(_FurnizeazaPretResponse_QNAME, FurnizeazaPretResponse.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link FurnizeazaPret }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://portocale.infoiasi.ro/", name = "furnizeazaPret")
    public JAXBElement<FurnizeazaPret> createFurnizeazaPret(FurnizeazaPret value) {
        return new JAXBElement<FurnizeazaPret>(_FurnizeazaPret_QNAME, FurnizeazaPret.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link FurnizeazaStoc }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://portocale.infoiasi.ro/", name = "furnizeazaStoc")
    public JAXBElement<FurnizeazaStoc> createFurnizeazaStoc(FurnizeazaStoc value) {
        return new JAXBElement<FurnizeazaStoc>(_FurnizeazaStoc_QNAME, FurnizeazaStoc.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link FurnizeazaStocResponse }{@code >}}
     * 
     */
    @XmlElementDecl(namespace = "http://portocale.infoiasi.ro/", name = "furnizeazaStocResponse")
    public JAXBElement<FurnizeazaStocResponse> createFurnizeazaStocResponse(FurnizeazaStocResponse value) {
        return new JAXBElement<FurnizeazaStocResponse>(_FurnizeazaStocResponse_QNAME, FurnizeazaStocResponse.class, null, value);
    }

}

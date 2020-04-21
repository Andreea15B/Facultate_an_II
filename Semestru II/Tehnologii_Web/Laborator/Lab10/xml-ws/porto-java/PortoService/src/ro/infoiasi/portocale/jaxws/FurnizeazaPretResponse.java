
package ro.infoiasi.portocale.jaxws;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlRootElement(name = "furnizeazaPretResponse", namespace = "http://portocale.infoiasi.ro/")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "furnizeazaPretResponse", namespace = "http://portocale.infoiasi.ro/")
public class FurnizeazaPretResponse {

    @XmlElement(name = "return", namespace = "")
    private Double _return;

    /**
     * 
     * @return
     *     returns Double
     */
    public Double getReturn() {
        return this._return;
    }

    /**
     * 
     * @param _return
     *     the value for the _return property
     */
    public void setReturn(Double _return) {
        this._return = _return;
    }

}

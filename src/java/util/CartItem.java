/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package util;

/**
 *Class che mappa l'oggetto del carrello
 * @author arturo e riki
 **/
public class CartItem {
    
    private Long productCode;
    private int qta;
    
    public CartItem(Long productCode,int qta) {
        this.productCode = productCode;
        this.qta = qta;
    }
    public CartItem() {}
    
    /**
     * getter per ProductCode
     * @return  Long 
     */
    public Long getProductCode()
    {
        return this.productCode;
    }
    
    /**
     * getter per la quantita'
     * @return int
     */
    public int getQta()
    {
        return this.qta;
    }
    
    /*
    
    */
    public void setproductCode(Long productCode)
    {
        
        this.productCode = productCode;
        
    }
    /**
     * setter per la quantita'
     * @param qta 
     */
    public void setQta(int qta)
    {
        this.qta = qta;
    }
    
}

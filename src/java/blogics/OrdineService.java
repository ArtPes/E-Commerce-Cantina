/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package blogics;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import services.databaseservice.*;
import services.databaseservice.exception.*;
import util.*;

/**
 *
 * @author Arturo
 */
public class OrdineService {
    
    
    /**
     * metodo statico per l'inserimento dell'ordine nel database
     * @param database connessione al database
     * @param cduser cduser che effettua ordine
     * @param dataordine data in cui è effettuato l'odine
     * @param via via di consegna dell'ordine
     * @param citta città di consegna dell'ordine
     * @param cap cap consegna ordine
     * @param data_consegna data prevista ordine
     * @return
     * @throws NotFoundDBException
     * @throws services.dbservice.exception.DuplicatedRecordDBException
     * @throws ResultSetDBException 
     */
    public static Ordine insertNewOrdine(DataBase database,String cduser,java.util.Date dataordine,
            String via,String citta,String cap,java.util.Date data_consegna) 
            throws NotFoundDBException,DuplicatedRecordDBException,ResultSetDBException{
         
        Ordine ordine;

        ordine = new Ordine(dataordine,via,citta,cap,data_consegna,cduser);
        ordine.insert(database);
        /**all'interno della transizione trovo il valore della chaive
         * autoincrementante id, per aggiungerla all'oggetto 
         * in modo che possa fare l'inserimento corretto
         * nella tabella comprende
         */
        String sql = "select max(idordine) as idordine from ordine";
        ResultSet rs =  database.select(sql);
        try {
        rs.next();
        ordine.idordine = rs.getLong("idordine");
        rs.close();  
        } catch(SQLException e) {
            throw new ResultSetDBException("Ordine: insertNewOrdine() errore nell'inserimento dell'ordine ");
        }
        return ordine;
    }
    
      public static void RemoveOrdine(DataBase database,Long idordine) throws NotFoundDBException,
           ResultSetDBException {
        
        String sql= "DELETE FROM ordine WHERE idordine="+idordine+" " ;
        
        database.modify(sql);
       
    }
    
    /**
     * metodo per ottenere tutti gli ordini dell'utente
     * @param databse
     * @param cduser
     * @return
     * @throws NotFoundDBException
     * @throws ResultSetDBException 
     */
    public static ArrayList getOrdinifromUser(DataBase database,String cduser)
    throws NotFoundDBException,ResultSetDBException{
        String sql = "select * from ordine where cduser='"+Conversion.getDatabaseString(cduser)+"' order by data_ordine desc";
        ResultSet rs = database.select(sql);
        ArrayList<Ordine> aordini = new ArrayList<Ordine>();
        try
        {
           while(rs.next())
           {
               Ordine ord = new Ordine(rs);
               aordini.add(ord);
           }
           rs.close();
        }
        catch(SQLException ex)
                {
                throw new ResultSetDBException("OrdineService: getOrdinefromUser() errore sul resultset");
                }
        return aordini;
    }
    

    /*per tracciare ordine specifico, utilizzato nel pagamento per riportare i parametri inseriti*/
    /**
     * metodo per selezione un ordine dato un id
     * @param database
     * @param idordine
     * @return
     * @throws NotFoundDBException
     * @throws ResultSetDBException 
     */
    public static Ordine getOrderfromCduser(DataBase database,String cduser)
    throws NotFoundDBException,ResultSetDBException{
        
        String sql = "select * from ordine where cduser='"+Conversion.getDatabaseString(cduser)+"'"
                + " order by idordine desc limit 1";
        Ordine ordine = null;
        ResultSet rs = database.select(sql);
        try {
            if(rs.next())
            {
                ordine = new Ordine(rs);
            }
            rs.close();
        }
        catch(SQLException e)
                {
                
                throw new ResultSetDBException("OrdineService: getOrderfromCduser() errore sul resultset");
        }
        return ordine;
    }
    
    
    /**
     * metodo per selezionare tutti gli ordini(per admin)
     * @param database
     * @return
     * @throws NotFoundDBException
     * @throws ResultSetDBException 
     */
    public static ArrayList getAllOrder(DataBase database)
    throws NotFoundDBException,ResultSetDBException{
        
        String sql = "select * from ordine order by data_ordine desc";
        ArrayList<Ordine> aordini = new ArrayList<Ordine>();
        ResultSet rs = database.select(sql);
        try
        {
            while(rs.next())
            {
                Ordine ord = new Ordine(rs);
                aordini.add(ord);
            }
            rs.close();
        }
        catch(SQLException e){
            throw new ResultSetDBException("OrdinService: getAllOrder() errore sul resultSet "+e.getMessage());
        }
         return aordini;
    }
   
      
     public static void setStatoOrdine(DataBase database,Long idordine,String stato)
            throws NotFoundDBException,ResultSetDBException{
        
        String sql = "update ordine set stato='"+Conversion.getDatabaseString(stato)+"' "
                + "where idordine="+idordine;
        
       database.modify(sql);
        
        
    }
}

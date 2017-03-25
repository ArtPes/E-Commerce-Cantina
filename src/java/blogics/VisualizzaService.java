/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package blogics;
import services.databaseservice.*;
import services.databaseservice.exception.*;
import services.errorservice.*;
import global.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import util.*;

/**
 *
 * @author arturo
 */
public class VisualizzaService {
    
    
    /**
     * metodo per l'inserimento della visualizzzazione del prodotto da parte dell'utene
     * @param database connsesione al database
     * @param productCode prodotto visualizzato
     * @param cduser id dell'utente che visualizza il prodotto
     * @throws NotFoundDBException DB non trovato
     * @throws DuplicatedRecordDBException Record duplicato
     * @throws ResultSetDBException Errore sul ResultSet
     */
    public static void insertNewView(DataBase database,Long productCode,String cduser)
            throws NotFoundDBException,DuplicatedRecordDBException,ResultSetDBException{
        
        Visualizza view;
        view = new Visualizza(productCode,cduser);
        view.insert(database);
        
    
    }
    /**
     * metodo che restituisce i prodotti visualizzati dall'utente
     * @param database Connessione al database
     * @param cduser 
     * @return ArrayList<Visualizza>
     * @throws NotFoundDBException
     * @throws ResultSetDBException 
     */
    public static Visualizza getUltimeVisualizzazioni(DataBase database,String cduser)
    throws NotFoundDBException,ResultSetDBException{
          
        Visualizza visual = null;
        String sql;
        
        /*Seleziono l' ultimo prodotto visualizzato dall'utente*/
        /*quando un utente clicca sul prodotto per la visualizzazione dei dettagli
        la visualizzazione viene inserita nel database
        */
        sql = "SELECT * FROM visualizza WHERE cduser='"+Conversion.getDatabaseString(cduser)+"' ORDER BY RAND() LIMIT 1";
 
        ResultSet resultSet = database.select(sql);
        
        try {
             if (resultSet.next())
             visual = new  Visualizza(resultSet);
             resultSet.close();
            }
        catch (SQLException e) {
            throw new ResultSetDBException("VisualizzaService: getUltimeVisualizzazioni()"
                    + "Errore sul ResultSet" );
        }
        return visual;
    }
    
}

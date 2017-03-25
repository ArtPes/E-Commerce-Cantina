/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package blogics;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import util.*;
import services.databaseservice.DataBase;
import services.databaseservice.exception.*;



public class ComprendeService {
    
    /**
     * metodo per comporre l'ordine
     * @param database connessione al database
     * @param idordine identificativo dell'ordine
     * @param productcode identificativo del prodotto
     * @param qta quantita' ordinata
     * @return
     * @throws NotFoundDBException
     * @throws DuplicatedRecordDBException
     * @throws ResultSetDBException 
     */
    public static Comprende insertOrderItem(DataBase database,Long idordine,Long productcode,int qta)
            throws NotFoundDBException,DuplicatedRecordDBException,ResultSetDBException{
        
        /*inserisco la riga delll'ordine nel db*/
        Comprende  cm = new Comprende(idordine,productcode,Long.valueOf(qta));
        cm.insert(database);
        
        return cm;
    }
    
 }
    
    


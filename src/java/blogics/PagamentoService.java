/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package blogics;

import java.sql.ResultSet;
import java.sql.SQLException;
import services.databaseservice.DataBase;
import services.databaseservice.exception.DuplicatedRecordDBException;
import services.databaseservice.exception.NotFoundDBException;
import services.databaseservice.exception.ResultSetDBException;

/**
 *
 * @author riccardo
 */
public class PagamentoService {
    
    /**
     * metodo per l'inserimento di un pagamento
     * @param database connessione al db
     * @param data data odierna
     * @param idordine id dell'ordine
     * @param importo_pagamento importo finale del pagamento
     * @param stato stato del pagamento
     * @return
     * @throws NotFoundDBException
     * @throws DuplicatedRecordDBException
     * @throws ResultSetDBException 
     */
    public static Pagamento insertNewPagamento(DataBase database,
            java.util.Date data,Long idordine,double importo_pagamento,String stato)
            throws NotFoundDBException,DuplicatedRecordDBException,ResultSetDBException{
        
        Pagamento pagamento = new Pagamento(data,stato,idordine,importo_pagamento);
        pagamento.insert(database);
        /*recupero id pagamento*/
        String sql = "select max(id) as id from pagamento";
        ResultSet rs = database.select(sql);
         try {
        rs.next();
        pagamento.id = rs.getLong("id");
        rs.close();
        } catch(SQLException e) {
            throw new ResultSetDBException("Pagamento: insertNewPagamento() errore nell'inserimento dell'pagamento ");
        }
          return pagamento;
    }
    
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package blogics;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import services.databaseservice.DataBase;
import services.databaseservice.exception.NotFoundDBException;
import services.databaseservice.exception.ResultSetDBException;
import util.Conversion;

/**
 *
 * @author Arturo
 */
public class CouponService {

    /**
     * metodo per ottenere una lista dei coupon attivi dell'utente
     * @param database connessione al db
     * @param cduser identificatore utente
     * @param data data odierna
     * @return ArrayList<Coupon>
     * @throws NotFoundDBException
     * @throws ResultSetDBException 
     */
    public static ArrayList getUserCoupon(DataBase database,String cduser,java.util.Date data)
    throws NotFoundDBException,ResultSetDBException{
        
        ArrayList<Coupon> coupons = new ArrayList<Coupon>();
        Coupon coupon = null;
        String sql = " SELECT * FROM coupon "
                + " WHERE usato=0 AND cduser='" + Conversion.getDatabaseString(cduser)+"' ";
        ResultSet resultset = database.select(sql);
      // convertl la data in sql per fare il confronto
        java.sql.Date sdate = Conversion.convertJavaDateToSqlDate(data);
                try {
                    while(resultset.next())
                    {
                        coupon = new Coupon(resultset);
                        //Controllo data coupon che sia dopo la data di inzio e prima di quella di fine
                      if (sdate.after(coupon.data_inizio) && sdate.before(coupon.data_fine))
                          coupons.add(coupon);  
                    } 
                }
                catch (SQLException ex) {
                    throw new ResultSetDBException("CouponService:getUserCoupon() errore sul ResultSet");
                }
        return coupons;
    }
    
    /**
     * metodo per ottenere un coupon dato l'id utilizzato durante il pagamento per scontare e poi rimuovere il coupon
     * @param database connessione al database
     * @param id id del coupon
     * @return Coupon
     * @throws NotFoundDBException
     * @throws ResultSetDBException 
     */
    public static Coupon getCouponfromId(DataBase database,Long id)
            throws NotFoundDBException,ResultSetDBException {
        
        String sql = "select * from coupon where id="+id;
        Coupon coupon = null;
        ResultSet rs = database.select(sql);
        try {
            if (rs.next())
                 coupon = new Coupon(rs);
             
        }
        catch (SQLException e ) {
            throw new ResultSetDBException("CouponService: getCouponfromId()"
                    + "errore sul ResultSet");
        }
     return coupon; 
    }
    
    
        public static ArrayList getTotCoupon(DataBase database)
            throws NotFoundDBException,ResultSetDBException {
        
        String sql = "select * from coupon order by data_inizio desc";
        ArrayList<Coupon> acoupon = new ArrayList<Coupon>();
        ResultSet rs = database.select(sql);
        try
        {
            while(rs.next())
            {
                Coupon ord = new Coupon(rs);
                acoupon.add(ord);
            }
            rs.close();
        }
        catch(SQLException e){
            throw new ResultSetDBException("OrdinService: getAllOrder() errore sul resultSet "+e.getMessage());
        }
         return acoupon;
    }
    
    /**
     * metodo per attribuire all'utente un coupon
     * @param database
     * @param cduser
     * @param importo
     * @param di
     * @param df
     * @param usato
     * @throws NotFoundDBException
     * @throws ResultSetDBException 
     */
    public static void insertNewCoupon(DataBase database,String cduser,double importo,java.util.Date di,
            java.util.Date df,int usato)
            throws NotFoundDBException,ResultSetDBException{
        
        Coupon cp = new Coupon(cduser, importo, di, df, usato);
        cp.insert(database);

    }
}

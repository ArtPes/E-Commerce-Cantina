/*
 * FatalError.java
 *
 * Created on May 5, 2000, 2:57 PM
 */
 
package services.errorservice;


/** 
 * Interfaccia che definisce il tipo di errore Fatal Error.
 *
 * L'Eccezione che implementa l'errore Fatal Error deve prevedere i
 * metodi che consentono di gestirla.
 * E' infatti necessario eseguire una RollBack, inviare una mail di notifica
 * al responsabile e eseguire il log sul file relativo al tipo di eccezione.
 * <p>
 * E' inoltre presente un metodo per recuperare il messaggio che andrà loggato.
 *
 * @author  GAL_PES
 * 
 * @see EService
 * @see GeneralError
 * @see GeneralException
 * @see Warning
 *
 */

public interface FatalError {

  /** 
   * Restituisce il messaggio di errore.
   * <p>
   * Restituisce il messaggio che verrà poi aggiunto
   * ai files di log degli errori.
   *
   */        
  
  public String getLogMessage();
  
  /** 
   * Logga l'errore sul file relativo al tipo di errore.
   * <p>
   * Scrive il messaggio di errore sul file di log relativo
   * alla sezione di codice interessata all'errore.
   *
   */         
  
  public void log();
  
  /** 
   * Invia una mail di notifica dell'errore.
   * <p>
   * Invia una mail di notifica dell'errore al responsabile
   * dell'applicazione.   
   *
   */          
  
  public void mailError();
  
  /** 
   * Esegue la RollBack.
   * <p>
   * Esegue la RollBack della transazione che ha generato l'errore.
   *
   */         
  
  public void makeRollBack();
  
}

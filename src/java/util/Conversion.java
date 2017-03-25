/*
 * Conversion.java
 *
 */

package util;

//import global.*;
import global.Constants;
import java.io.File;
import java.io.IOException;
import java.util.*;
import javax.servlet.http.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.DOMException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import services.errorservice.EService;
//import java.text.*;
//import java.io.*;
//import java.sql.*;
//import oracle.xml.parser.v2.*;
//import org.w3c.dom.*;
//import org.w3c.dom.Node;
//import javax.servlet.http.*;
//import java.net.URL;

public class Conversion {
  
  /** From ' to '' for Oracle queries
   * @param inputString The String to convert
   * @return The converted String
 */
  public static String getDatabaseString(String inputString) {

    if (inputString == null)
      return "-";

    /* inputString = inputString.replace('"', '\''); */

    StringBuffer temp = new StringBuffer();
    int indexFrom = 0;
    int indexTo = 0;
    indexTo = inputString.indexOf("'", indexFrom);
    while (indexTo >= 0) {
      temp.append(inputString.substring(indexFrom, indexTo));
      temp.append("`");
      indexFrom = indexTo;
      indexTo = inputString.indexOf("'", ++indexFrom);
    }
    temp = temp.append(inputString.substring(indexFrom, inputString.length()));

    for (int i=temp.length()-1; i>=0; i--) {
      if (temp.charAt(i) == '"') temp.deleteCharAt(i);
    }


    return temp.toString();

  }

  
  /**Constructs an ArrayList of String objects from a string tokenized by the separatoe
   * 
   * @param toTokenize The String to tokenize
   * @param separator The separator String
   * @return an ArrayList of String objects
   */
  public static ArrayList tokenizeString(String toTokenize,String separator) {

    StringTokenizer tokenizer;
    ArrayList<String> result=new ArrayList<String>();

    if (toTokenize!=null) {
      tokenizer=new StringTokenizer(toTokenize,separator);
      while (tokenizer.hasMoreTokens())
        result.add((String)tokenizer.nextToken());
    }

    return result;

  }
  
  /**
   * metodo per fare il tokenize degli oggetti nel carrello
   * idprodotto*quantita
   * @param toTokenize String su cui eseguire il token
   * @param separator String con cui effettuare il token
   * @return ArrayList<String>
   */
  public static CartItem tokenizeCartItem(String toTokenize,String separator) {
      StringTokenizer tokenizer;
      ArrayList<String> result = new ArrayList<String>();
      CartItem item = null;
      
      if (toTokenize != null) {
          tokenizer = new StringTokenizer(toTokenize, separator);
          while(tokenizer.hasMoreElements())
              result.add((String)tokenizer.nextToken());
          /*prodotto*qta*
          posizione 0 ho l'idprodotto in posizione 1 la quantità*/
          item = new CartItem(Long.valueOf(result.get(0)),Integer.parseInt(result.get(1)));
                    
      }
      
      return item;
  }
  
  /**
   * metodo per la conversione di un array di CartItem in un cookie
   * @param cname il nome del cookie del carrello
   * @param items l'array che rappresenta gli oggetti contenti nel carello
   * @return Cookie del carrello
   */
  public static Cookie CartItemstoCookie(String cname,CartItem[] items)
  {
      if ( items != null)
      {
          StringBuilder sb = new StringBuilder();
          for(int i=0; i<items.length; i++ )
          {
              sb.append(items[i].getProductCode()).append("*").append(items[i].getQta()).append("#");
          }
          Cookie cookie = new Cookie(cname,sb.toString());
          cookie.setPath("/");
          return cookie;
      }
      else
          return null;
      
  }
  
  


  /** compatibilità XML.
   * converte i caratteri speciali html nei corrispondenti xml.
   * @param html
   * @return 
 */

  public static String html2xml (String html) {
     String[] tag = {"amp","euml","ndash","rdquo","ldquo","dollar","quot","rsquo","percnt","nbsp","raquo","quot","Ugrave","Uacute","ugrave","uacute","Ouml","Ograve","Oacute","ograve","oacute","Ntilde","Iuml","Igrave","Iacute","iuml","igrave","iacute","Euml","Egrave","Eacute","euml","egrave","eacute","aacute","agrave","auml","Aacute","Agrave","Auml"};
     String[] xml = {"38","235","173","39", "39", "36", "34", "39", "37","160","187","34","217","218","249","250","214","210","211","242","243","209","207","204","205","239","236","237","203","200","201","235","232","233","225","224","228","193","192","196"};
     for (int i=0; i<tag.length; i++)
        html=replaceAll(html,"&"+tag[i],"&#"+xml[i]);

    return html;
  }

  /** compatibilità XML.
   * converte i caratteri speciali html nei corrispondenti xml.
   * @param html
   * @return 
 */

  public static String chr2xml (String html) {
      String[] tag = {"ë","­","$","%","»","Ù","Ú","ù","ú","Ö","Ò","Ó","ò","ó","Ñ","Ï","Ì","Í","ï","ì","í","Ë","È","É","ë","è","é","á","à","ä","Á","À","Ä"};
      String[] xml = {"235","173", "36", "37","187","217","218","249","250","214","210","211","242","243","209","207","204","205","239","236","237","203","200","201","235","232","233","225","224","228","193","192","196"};
     for (int i=0; i<tag.length; i++)
        html=replaceAll(html,tag[i],"&#"+xml[i]+";");

    return html;
  }


  /** compatibilit� XML.<br/>
   * & --> &amp;<br/>
   * @param html
   * @return 
 */

  public static String extra2xml (String html) {

    /*  &--> &amp; */
    html = replaceAll (html, "&#", "@@");
    html = replaceAll (html, "&", "&#38;");
    html = replaceAll (html, "@@", "&#" );
    return html;
  }

/** Replace all the substrings in a String with other substrings
 * @param sTxt The String to scan
 * @param sOldTag The substring to substitute
 * @param sNewTag The new String
 * @return The modified String
 */   
  public static String replaceAll (String sTxt, String sOldTag, String sNewTag) {

    String newText = "";
    int pos=0;
    int lastpos=0;
    while ( (pos=sTxt.indexOf(sOldTag,lastpos))!=-1) {
      newText += sTxt.substring(lastpos,pos)+sNewTag;
      lastpos = pos+sOldTag.length();
    }
    newText += sTxt.substring(lastpos,sTxt.length());
    return newText.toString();
    
  }
  /**
   * metodo per la conversione da Java.util.Date in Java.sql.Date
   * il metodo getTime() è deprecato
   * @param date in sql
   * @return 
   */
  public static java.sql.Date convertJavaDateToSqlDate(java.util.Date date) {
    return new java.sql.Date(date.getTime());
}

  /**
   * metodo parser per il multilingua pende il file xml e analizza i nodi
   * @param languageName
   * @param attributeName
   * @return 
   */
   public static String GetTranslationToLanguage(String languageName, String attributeName)
    {
        try 
        {
            /*per realizzare questo metodo utilizzo il pattern FactoryMethod*/
            /*Esempio di pattern su slide Software*/
            File file = new File(Constants.FXMLPATH);
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(file);

            NodeList nodes = doc.getElementsByTagName("language");
            
            for (int i = 0; i < nodes.getLength(); i++) 
            {
                Node node = nodes.item(i);
    
                if (node.getNodeType() == Node.ELEMENT_NODE) 
                {
                    Element element = (Element) node;
                    if (element.getAttribute("name").equals(languageName))
                    {
                        NodeList list = element.getElementsByTagName("check");
                        
                        for (int j = 0; j < list.getLength(); j++)
                        {
                            Node childNode = list.item(j);
                            
                            if (childNode.getNodeType() == Node.ELEMENT_NODE)
                            {
                                Element el = (Element) childNode; 
                                
                                if (el.getAttribute("name").equals(attributeName))
                                    /**posso avere più occorrenze restiusco la prima nel nostro
                                     * caso ne abbiamo solo una
                                     */
                                    return el.getChildNodes().item(0).getNodeValue();
                            }
                        }
                    }
                }
            }
        } 
        catch (ParserConfigurationException e) 
        {
            System.err.println(e.getMessage());
        }
        catch(SAXException e){
                System.err.println(e.getMessage());
        }
        catch(IOException e) {
                System.err.println(e.getMessage());
        }
        catch (DOMException e)
        {
              System.err.println(e.getMessage());
        }
        /*
        se non trova nessuna occorrenza stampa una stringa vuota*/
        return "";
    }
}


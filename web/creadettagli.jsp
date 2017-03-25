
<%@ page info="Inserimento Dettagli" %>
<%@ page contentType="text/html" %>
<%@ page session="false" %>
<%@ page buffer="20kb" %>
<%@page import="services.sessionservice.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>


<jsp:useBean id="DettagliManagement" scope="page" class="bflows.DettagliManagement" />
<jsp:setProperty name="DettagliManagement" property="*" />

<%
      // Cookie[] cookies;
  String lang=null;
       /*imposto la lingua controllando dalla request quella del browser*/
    if (request.getLocale().getLanguage().equals("it"))
        lang="ita";
    if (request.getLocale().getLanguage().equals("en"))
        lang="eng";
    if (request.getLocale().getLanguage().equals("fr"))
        lang="fra";
    if (request.getLocale().getLanguage().equals("es"))
        lang="spa";

   Cookie[] cookies=null;
   cookies=request.getCookies(); 
   lang=Session.getLingua(cookies);
        
  String id=null;
  String lingu=null;
  String dettagli=null;

  
 if(lang!=null){
  if (lang.equals("ita"))
     {id = "ProductCode";
     lingu="Lingua";
     dettagli="Dettagli";}
  if (lang.equals("eng"))
     {id = "ProductCode";
     lingu="Language";
     dettagli="Details";}
  if (lang.equals("fra"))
     {id = "ProductCode";
     lingu="Langue";
     dettagli="Détails";}
  if (lang.equals("spa"))
     {id = "ProductCode";
     lingu="Idioma";
     dettagli="Detalles";}
  }
  
//------------------------------------------------------------------------------------------------------------------------   
    
  String message;
  
  /*può fare un controllo sui cookie dell'utente
  se ci sono e quindi è loggato fare un redirect alla home page
    if (Session.getprodottonome(cookies) != null)
      response.sendRedirect("home.jsp");
  */
  
 String status=request.getParameter("status");
  if (status==null) status="view"; 
  if (status.equals("insert"))
  {
      DettagliManagement.DettagliManagementInsert();
      //redirect alla home per fare il login dopo aver terminato la
      //registrazione
      response.sendRedirect("viewprod_vend.jsp");
  } 
  //gestione degli errori
  
  if (DettagliManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (DettagliManagement.getResult()==-2) {
    message=DettagliManagement.getErrorMessage();
  }
  
%>

<html>
  <head>
    <title>Details</title>
    <script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->
    <link href="css/newcss.css" rel="stylesheet" type="text/css"/>     				

  </head>
  <body>  
  <h1>Details</h1>
    <form name="insertForm" action="creadettagli.jsp" method="post">

       <table border="0">
        <tr>
          <td class="normal" width="100"><%=id%></td>
          <td width="250">
            <input type="text" name="productCode" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=lingu%></td>
          <td width="250">
            <input type="text" name="lingua" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=dettagli%></td>
          <td>
            <textarea name="adettagli"  cols="30" rows="10"></textarea>
          </td>
        </tr> 
        <tr>
          <td class="normal" width="100">&#160;</td>
          <td width="250">
            <input type="button" value="invia" onClick="insertdetails()"/>
            <input type="button" value="annulla" onClick="backForm.submit()"/>
          </td>
        </tr>
      </table>
      <input type="hidden" name="status" value="insert"/>
    </form>
    <form name="backForm" method="post" action="viewprod_vend.jsp">
       <input type="hidden" name="status" value="view"/>
    </form>
<div class="footer">
    <div class="left_footer"><a href="home.jsp" title="Home"> <img src="images/logo2.png" alt="" width="170" height="49"/></a> </div>
    <div class="center_footer">&copy Copyright 2015 All Rights Reserved<br/><br/>
      <img src="images/paypal.png" alt="" /> </div>
</div>
</body>
</html>


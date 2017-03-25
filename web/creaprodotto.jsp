
<%@ page info="Inserimento Nuovo Prodotto" %>
<%@ page contentType="text/html" %>
<%@ page session="false" %>
<%@ page buffer="20kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="services.sessionservice.*" %>


<jsp:useBean id="ProdottoManagement" scope="page" class="bflows.ProdottoManagement" />
<jsp:setProperty name="ProdottoManagement" property="*" />

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
  
  String id= null;
  String nome= null;
  String regione= null;
  String prezzo= null;
  String qta= null;
  String path= null;
  String categoria= null;
  String remember= null;
 if(lang!=null){
  if (lang.equals("ita"))
     {id = "Il tuo ID è:";
     nome="Nome Prodotto";
     regione="Regione";
     prezzo="Prezzo";
     path="Indirizzo immagine";
     categoria="Categoria";
     qta="Quantità";
     remember="Ricordatevi di inserire i dettagli in inglese per il prodotto";}
  if (lang.equals("eng"))
     {id = "Your ID is:";
     nome="Product's Name";
     regione="Country";
     prezzo="Price";
     path="Path image";
     categoria="Category";
     qta="Quantity";
     remember="Remember to insert an ENGLISH details for the product";}
  if (lang.equals("fra"))
     {id = "Votre ID est :";
     nome="Nom du produit";
     regione="Région";
     prezzo="Prix";
     path="Emplacement de l'image";
     categoria="Catégorie";
     qta="Quantitè";
     remember="Rappelez-vous d'insérer une anglaise Détails du produit";}
  if (lang.equals("spa"))
     {id = "Su ID es:";
     nome="Nombre del Producto";
     regione="Región";
     prezzo="Precio";
     path="Ubicación imagen";
     categoria="Categoría";
     qta="Cantidad";
     remember="Recuerde que debe insertar un Inglesa Información del producto";}
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
      ProdottoManagement.ProdottoManagementInsert();
      //redirect alla home per fare il login dopo aver terminato la
      //registrazione
      response.sendRedirect("viewprod_vend.jsp");
  }
  //gestione degli errori
  
  if (ProdottoManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (ProdottoManagement.getResult()==-2) {
    message=ProdottoManagement.getErrorMessage();
  }
%>

<html>
  <head>
      <% if (lang!=null){%>
      <%if (lang.equals("ita")) {%><title>Inserimento Nuovo Prodotto</title><%}%>
      <%if (lang.equals("eng")) {%> <title>Insert New Product</title><%}%>
      <%if (lang.equals("fra")) {%> <title>Insérez Nouveau produit</title><%}%>
      <%if (lang.equals("spa")) {%> <title>Insertar nuevo producto</title><%}%>
      <%} else %> <title>Insert New Product</title>
    <link href="css/newcss.css" rel="stylesheet" type="text/css"/>     				
    <script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->

  </head>
  <body>  
      <% if (lang!=null){%>
      <%if (lang.equals("ita")) {%><h1>Inserimento Nuovo Prodotto</h1><%}%>
      <%if (lang.equals("eng")) {%> <h1>Insert New Product</h1><%}%>
      <%if (lang.equals("fra")) {%> <h1>Insérez Nouveau produit</h1><%}%>
      <%if (lang.equals("spa")) {%> <h1>Insertar nuevo producto</h1><%}%>
      <%} else %> <h1>Insert New Product</h1>
    <form name="insertForm" action="creaprodotto.jsp" method="post">
       <table border="0"> 
        <tr>
          <td class="normal" width="100"><%=id%></td>
          <td width="250">
            <input type="text" readonly="readonly" name="cduser"  value="<%=Session.getCduser(cookies)%>" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=nome%></td>
          <td width="250">
            <input type="text" name="nome_p" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=regione%></td>
          <td width="250">
            <input type="text" name="regione" size="20" maxlength="50"/>
          </td>
        </tr>     
        <tr>
          <td class="normal" width="100"><%=prezzo%></td>
          <td width="250">
            <input type="text" name="prezzo" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=path%></td>
          <td width="250">
            <input type="text" name="path" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=qta%></td>
          <td width="250">
            <input type="text" name="quantita" size="20" maxlength="50"/>
          </td>
        </tr> 
        <tr>
          <td class="normal" width="100"><%=categoria%></td>
          <td width="250">
            <input type="radio" name="type_p" value="R" checked="checked"/>Red
            <input type="radio" name="type_p" value="B"/>White
            <input type="radio" name="type_p" value="O"/>Rose
          </td>
        </tr>        
        <tr>
          <td class="normal" width="100">&#160;</td>
          <td width="250">
            <input type="button" value="invia" onClick="insertprodotto()"/>
            <input type="button" value="annulla" onClick="backForm.submit()"/>
          </td>
        </tr>
      </table>
      <input type="hidden" name="status" value="insert"/>
    </form>
    <form name="backForm" method="post" action="viewprod_vend.jsp">
       <input type="hidden" name="status" value="view"/>
    </form>
          
          <p><%=remember%></p>
<div class="footer">
    <div class="left_footer"><a href="home.jsp" title="Home"> <img src="images/logo2.png" alt="" width="170" height="49"/></a> </div>
    <div class="center_footer">&copy Copyright 2015 All Rights Reserved<br/><br/>
      <img src="images/paypal.png" alt="" /> </div>
</div>
</body>
</html>


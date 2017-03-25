<%-- 
    Document   : viewprod_vend
    Created on : 24-mar-2015, 11.51.08
    Author     : Arturo&Riki
--%>

<%@ page info="View Prodotti Venditore" %>
<%@ page contentType="text/html" %>
<%@ page session="false" %>
<%@ page buffer="20kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="services.sessionservice.*" %>


<jsp:useBean id="ProdottoManagement" scope="page" class="bflows.ProdottoManagement" />
<jsp:setProperty name="ProdottoManagement" property="*" />


<%   // Cookie[] cookies;
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
   
     String quantita=null;
     String codprod=null;
     String nome=null;
     String prezzo=null;
     String conferma=null;
     String elimina=null;
     
     
   if(lang!=null){
  if (lang.equals("ita"))
     {quantita="Quantità";         
      codprod="Codice Prodotto";
      nome="Nome prodotto";
      prezzo="Prezzo";
      conferma="Conferma";
      elimina="Elimina";
      }
  if (lang.equals("eng"))
     {quantita="Quantity";
      codprod="Product Code";
      nome="Name";
      prezzo="Price";
      conferma="Confirm";
      elimina="Delete";
     }
  if (lang.equals("fra"))
     {quantita="Quantité";
      codprod="Code Produit";
      nome="Nom";
      prezzo="Prix";
      conferma="Confirmer";
      elimina="Supprimer";
     }
  if (lang.equals("spa"))
     {quantita="Cantitad";
      codprod="Código de Producto";
      nome="Nombre";
      prezzo="Precio";
      conferma="Confirmación";
      elimina="Eliminar";
     }
  }
   
  String message = null;
//------------------------------------------------------------------------------------------------------------------------  


 ProdottoManagement.setCookies(cookies);
 
 String status=request.getParameter("status");
  if (status==null)
  { status="view";
  } else {
      status = request.getParameter("status");
         }
 
  if(status.equals("modify")){
    ProdottoManagement.ProdottoManagementModify();
  }else if(status.equals("remove")){
    ProdottoManagement.ProdottoManagementDelete();
  }
  
  ProdottoManagement.ProdottoManagementView();
  
  //gestione degli errori
  
  if (ProdottoManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (ProdottoManagement.getResult()==-2) {
    message=ProdottoManagement.getErrorMessage();
  }
%>

<html>
  <head>
    <title>Inserimento Nuovo Prodotto</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <link href="css/newcss.css" rel="stylesheet" type="text/css"/>    
    <script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->                
  </head>
  <body> 
  <div class="ccontent" >
    <h1>Products' List</h1>
    <% if (ProdottoManagement.getProdottiV().length == 0) { %>
    <div class="prod_box_cart">
        <h1>
            Nothing in the List
        </h1>
    </div>
    <%}%>
    <%if (ProdottoManagement.getProdottiV().length!=0) {%>
    <div class="ordtab">
        <div class="ordrow">
        <div class="prod_details"><%=codprod%></div>
        <div class="prod_details"><%=nome%></div>
        <div class="prod_details"><%=quantita%></div>
        <div class="prod_details"><%=prezzo%></div>
        <div class="prod_details"><%=conferma%></div>
        <div class="prod_details"><%=elimina%></div>
        </div>
    </div>
    <%}%>
    <% for(int i=0;i<ProdottoManagement.getProdottiV().length;i++) { %>
    <form method="prod<%=i%>" action="viewprod_vend.jsp">
      <div class="ordtab">
          
        <div class="ordrow">
                <div class="prod_details">
                <span><%=ProdottoManagement.getProdottiV(i).productCode%></span>
                </div>
                <div class="prod_details">
                <span><%=ProdottoManagement.getProdottiV(i).nome_p%></span>
                </div>
                <div class="prod_details">
                <span>  <input type="text" name="quantita" value="<%=ProdottoManagement.getProdottiV(i).quantita%>"/></span>
                </div>
                <div class="prod_details">
                <span>  <input type="text" name="prezzo" value="<%=ProdottoManagement.getProdottiV(i).prezzo%>"/></span>
                </div>
                <div class="prod_details">
                  <a href="javascript:submitP(<%=i%>);"><input type="image" src="images/modify.png" title="modify" height="30px" /></a>
                  <input type="hidden" name="productCode" value="<%=ProdottoManagement.getProdottiV(i).productCode%>"/>
                  <input type="hidden" name="status" value="modify"/>
               </div>    
     </form>
                             
            <div class="prod_details">
               <form method="prod<%=i%>" action="viewprod_vend.jsp">
                 <input type="hidden" name="productCode" value="<%=ProdottoManagement.getProdottiV(i).productCode%>"/>
                 <input type="hidden" name="status" value="remove"/>
                 <a href="javascript:submitP(<%=i%>);"><input type="image" src="images/remove.png" title="Remove Product" height="30px" /></a>
               </form>
               </div>
       </div>
    </div>
   <% } %>
              <div>
               <a href="home.jsp" title="HOME"><img src="images/home.png" height="80px" ></a>
               <a href="creadettagli.jsp" title="Add product's Details"><img src="images/detail.png" height="60px" ></a>
               <a href="creaprodotto.jsp" title="Add product"><img src="images/add.png" height="60px" ></a>
              </div>
   </div>
</body>
<footer> 
<div class="footer">
    <div class="left_footer"><a href="home.jsp" title="Home"> <img src="images/logo2.png" alt="" width="170" height="49"/></a> </div>
    <div class="center_footer">&copy Copyright 2015 All Rights Reserved<br/><br/>
      <img src="images/paypal.png" alt="" /> </div>
</div>
</footer>
</html>





<%-- 
    Document   : Auserlist
    Created on : 2-mag-2015, 0.02.41
    Author     : Arturo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="false"%>
<%@page buffer="12kb" %>
<%@page import="services.sessionservice.*" %>
<%@ page errorPage="/ErrorPage.jsp" %>


<jsp:useBean id="UserManagement" scope="page" class="bflows.UserManagement"/>
<jsp:setProperty name="UserManagement" property="*"/>


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

     String nome=null;
     String surname=null;
     String id=null;
  
  if(lang!=null){
  if (lang.equals("ita"))
     { nome="Nome";
       surname="surname";
       id="  ID User  ";
     }
  if (lang.equals("eng"))
     {nome="Name";
      surname="Surname";
      id="  User's ID  ";
     }
  if (lang.equals("fra"))
     {nome="Date de commande";
      surname="Livraison de la date";
      id="  ID User  ";
     }
  if (lang.equals("spa"))
     {nome="Nome";
      surname="Cognom";
      id="  ID User  ";
     }
  }
    
  Cookie[] cookies=null;
  cookies=request.getCookies(); 

  
//------------------------------------------------------------------------------------------------------------------------   
String message = null;


 //UserManagement.setCookies(cookies);
 
  //controllo login   
  boolean loggedOn;   
  boolean loggVend=false; //da errore se non ha valore, false perchè qua non è ancora loggato l'utente
  boolean loggAdmin=true;
 if (Session.getCduser(cookies) != null) {
     loggedOn = true;
     lang=Session.getLingua(cookies);
     //per vedere se l'utente loggato è un venditore o compratore
     String tipo;
     tipo=Session.getTipo(cookies);
    if (tipo.equals("V"))
     {loggVend=true;
     }else loggVend=false;
 } else
     loggedOn = false;
 
    String status;
    if (request.getParameter("status") == null )
        status = "view";
    else
        status = request.getParameter("status");
   
    if(status.equals("remove")){
       UserManagement.UserManagementDelete();
        response.sendRedirect("Auserlist.jsp");
    }
 
    UserManagement.ListUsersView();
  
  //gestione degli errori
  
  if (UserManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (UserManagement.getResult()==-2) {
    message=UserManagement.getErrorMessage();
  }
%>
<html>
      <head>
    <title>order List</title>
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" /> 
<link rel="stylesheet" href="css/orderlist.css" type="text/css" media="all" />
<script type="text/javascript"  src="js/script.js"></script>
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/slide.js"></script>
<script type="text/javascript" src="js/nav.js"></script>

<!--per la tabella-->
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/prototype/1.6.0.2/prototype.js"></script>
<script type="text/javascript" src="js/tablekit.js"></script>  
<script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->
 
<%@ include file="top_panel.jsp" %>
 <!--panel -->
</head>
<body>
  <div class="wrap">
	<div class="header">
	<%@ include file="top_header.jsp" %>
            <!--lista di tutti i prodotti che si visualizza nella barra principale-->
        <%@include file="menu.jsp"%>
        </div>
         <div class="main">
          <form name="remove" action="Auserlist.jsp" method="post">
            <table border="0"> 
             <tr>
               <td class="normal" width="100">User ID</td>
               <td width="250">
               <input type="text" name="cduser" size="20" maxlength="50"/>
               </td>
             </tr>        
             <tr>
               <td class="normal" width="100">Remove</td>
               <td width="250">
               <input type="submit" value="Ok"/>
               <input type="reset" value="Annulla"/>
               </td>
             </tr>
            </table>
          <input type="hidden" name="status" value="remove"/>
         </form>
       <div class="clear"></div>
         <table class="sortable resizable editable">
	   <thead>
	     <tr>
               <th class="sortfirstdesc" id="urgency">  <%=id%>  </th>
               <th id="creation-date"><%=nome%></th>
               <th id="time"><%=surname%></th>
               <th id="status">Type User</th>
             </tr>
	   </thead>
	   <tfoot>
	     <tr>
               <td>  <%=id%>  </td>
               <td><%=nome%></td>
               <td><%=surname%></td>
               <td>Type User</td>
             </tr>
	   </tfoot>
	   <tbody>
              <% for(int i=0;i<UserManagement.getUtenti().length;i++) { %>
		<tr id="N938747839">
                    <td><div class="urg2"><%=UserManagement.getUtenti(i).cduser%></div></td>
                    <td><%=UserManagement.getUtenti(i).nome%></td>
                    <td><%=UserManagement.getUtenti(i).surname%></td>
                    <td><%=UserManagement.getUtenti(i).tipo%></td>
                 </tr>
                 <%}%>
	 </table>  
   </div>
</div>
<%@include file="footer.jsp" %>



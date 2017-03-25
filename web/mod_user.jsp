
<%@ page info="Modifica Utente" %>
<%@ page contentType="text/html" %>
<%@ page session="false" %>
<%@ page buffer="20kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="services.sessionservice.*" %>


<jsp:useBean id="userManagement" scope="page" class="bflows.UserManagement" />
<jsp:setProperty name="userManagement" property="*" />

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

   String id=null;
   String nome=null;
   String cogn=null;
   String pass=null;
   String indirizzo=null;
   String citta=null;
   String tel=null;
   String email=null;
   String tipou=null;
  
 if(lang!=null){
  if (lang.equals("ita"))
     {id = "Il tuo Username è:";
     nome="Nome";
     pass="Parola chiave";
     cogn="surname";
     indirizzo="Via";
     citta="Citta'";
     tel="Telefono";
     email="Email";
     tipou="Tipo Utente";
    }
  if (lang.equals("eng"))
     {id = "Your Username is:";
     nome="Name";
     pass="pass";
     cogn="Surname";
     indirizzo="Address";
     citta="City";
     tel="Telephone";
     email="Email";
     tipou="User type";
     }
  if (lang.equals("fra"))
     {id = "Votre Username est :";
     nome="Nom";
     pass="Mot de passe";
     cogn="Nom de famille";
     indirizzo="Adresse";
     citta="Ville";
     tel="Telephone";
     email="Email";
     tipou="Type d' utilisateur";
     }
  if (lang.equals("spa"))
     {id = "Su Username es:";
     nome="Nombre";
     pass="Contraseña";
     cogn="Apellido";
     indirizzo="Lòcation";
     citta="Ciudad";
     tel="Teléfono";
     email="Email";
     tipou="Tipo de usuario";
     }
  }
  
//------------------------------------------------------------------------------------------------------------------------  
 
  String message;
  
   
 String status=request.getParameter("status");
 
  if (status==null)
     status="view";  
  
  if (status.equals("modify"))
  { 
      userManagement.UserManagementModify();
      response.sendRedirect("home.jsp");
  
  }
  
  if (status.equals("remove"))
  { 
      userManagement.UserManagementDelete();
      response.sendRedirect("home.jsp");
  }

  //gestione degli errori
  
  if (userManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (userManagement.getResult()==-2) {
    message=userManagement.getErrorMessage();
  }
  
%>

<html>
  <head>
    <title>Modifica Contatto</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <link href="css/newcss.css" rel="stylesheet" type="text/css"/>     				
    <script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->
  </head>
 <body>  
    <h1>Modifica i tuoi dati</h1>      
    <form name="modifyForm" action="mod_user.jsp" method="post">
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
            <input type="text" name="nome" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=cogn%></td>
          <td width="250">
            <input type="text" name="surname" size="20" maxlength="50"/>
          </td>
        </tr>        
          <tr>
          <td class="normal" width="100"><%=pass%></td>
          <td width="250">
            <input type="pass" name="pass" size="20" maxlength="50"/>
          </td>
        </tr>    
        <tr>
          <td class="normal" width="100"><%=indirizzo%></td>
          <td width="250">
            <input type="text" name="indirizzo" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=citta%></td>
          <td width="250">
            <input type="text" name="citta" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=tel%></td>
          <td width="250">
            <input type="text" name="telefono" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=email%></td>
          <td width="250">
            <input type="text" name="email" size="20" maxlength="50"/>
          </td>
        </tr> 
        <tr>
          <td class="normal" width="100"><%=tipou%></td>
          <td width="250">
              <% String tipo;
               tipo=Session.getTipo(cookies);
               if (tipo.equals("C")){%>
            <input type="text"  readonly="readonly" value="Consumer" name="tipo"/>
            <%}else if (tipo.equals("V")) { %>
            <input type="text"  readonly="readonly" value="Seller" name="tipo"/>
            <%}%>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100">&#160;</td>
          <td width="250">
            <input type="button" value="invia" onClick="modifyuser()"/>
            <input type="button" value="annulla" onClick="backForm.submit()"/>
          </td>
        </tr>
      </table>
       <input type="hidden" name="status" value="modify"/>
    </form>      
    <form name="backForm" method="post" action="home.jsp">
       <input type="hidden" name="status" value="logout"/>
    </form>
  </body>
</html>


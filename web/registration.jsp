
<%@ page info="Inserimento Nuovo Utente" %>
<%@ page contentType="text/html" %>
<%@ page session="false" %>
<%@ page buffer="20kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>


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
    String pass=null;
    String nome= null;
    String surname= null;
    String via= null;
    String citta= null;
    String tel= null;
    String tipo_u= null;
    String lingua= null;
  
 if(lang!=null){
  if (lang.equals("ita"))
     {id = "Username";
      nome="Nome";
      surname="surname";
      pass="pass";
      via="Via";
      citta="Citt";
      tel="Telefono";
      tipo_u="Tipo Utente";
      lingua="Lingua Utente";    
     }
  if (lang.equals("eng"))
     {id = "Username";
      pass="pass";
      nome="Name";
      surname="Surname";
      via="Address";
      citta="City";
      tel="Telephone";
      tipo_u="User type";
      lingua="User Language";}
  if (lang.equals("fra"))
     {id = "Username";
      pass="Mot de passe";
      nome="Nom";
      surname="Nom de famille";
      via="Rue";
      citta="Ville";
      tel="Telephone";
      tipo_u="Type d' utilisateur";
      lingua="Langue de l'utilisateur";}
  if (lang.equals("spa"))
     {id = "Username";
      pass="Contraseña";
      nome="Nombre";
      surname="Apellido";
      via="Vìa";
      citta="Ciudad";
      tel="Teléfono";
      tipo_u="Tipo de usuario";
      lingua="Usuario idioma";}
  }

  
//------------------------------------------------------------------------------------------------------------------------  
 
  String message;
  
 String status=request.getParameter("status");
  if (status==null) status="view";
  
  if (status.equals("insert"))
  {
      userManagement.UserManagementInsert();
      //redirect alla home per fare il login dopo aver terminato la
      //registrazione
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
    <title>Inserimento Nuovo Contatto</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <link href="css/newcss.css" rel="stylesheet" type="text/css"/>     				
    <script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->
  </head>
  <body>  
    <h1>Not yet a member?  Sign Up!</h1>
    <form name="insertForm" action="registration.jsp" method="post">
       <table border="0"> 
        <tr>
          <td class="normal" width="100"><%=nome%></td>
          <td width="250">
            <input type="text" name="nome" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=surname%></td>
          <td width="250">
            <input type="text" name="surname" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=id%></td>
          <td width="250">
            <input type="text" name="cduser" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=pass%></td>
          <td width="250">
            <input type="text" name="pass" size="20" maxlength="50"/>
          </td>
        </tr>      
        <tr>
          <td class="normal" width="100"><%=via%></td>
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
          <td class="normal" width="100">E-Mail</td>
          <td width="250">
            <input type="text" name="email" size="20" maxlength="50"/>
          </td>
        </tr> 
        <tr>
          <td class="normal" width="100"><%=tipo_u%></td>
          <td width="250">
            <input type="radio" name="tipo" value="C" checked="checked"/>Consumer
            <input type="radio" name="tipo" value="V"/>Venditore
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=lingua%></td>
          <td width="250">
            <input type="radio" name="lingua" value="ita" checked="checked"/>Italiano
            <input type="radio" name="lingua" value="eng"/>English
            <br><input type="radio" name="lingua" value="fra"/>Français
            <input type="radio" name="lingua" value="spa"/>Español
          </td>
        </tr>      
        <tr>
          <td class="normal" width="100">&#160;</td>
          <td width="250">
            <input type="button" value="invia" onClick="insertuser()"/>
            <input type="button" value="annulla" onClick="backForm.submit()"/>
          </td>
        </tr>
      </table> 
      <input type="hidden" name="status" value="insert"/>
    </form>
    <form name="backForm" method="post" action="home.jsp"> 
       <input type="hidden" name="status" value="view"/>
    </form>
<div class="footer">
    <div class="left_footer"><a href="home.jsp" title="Home"> <img src="images/logo2.png" alt="" width="170" height="49"/></a> </div>
    <div class="center_footer">&copy Copyright 2015 All Rights Reserved<br/><br/>
      <img src="images/paypal.png" alt="" /> </div>
</div>
</body>
</html>


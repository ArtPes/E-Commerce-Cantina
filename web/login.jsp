<%-- 
    Document   : login
    Created on : 12-mar-2015, 12.32.02
    Author     : arturo e riki
--%>

<%@ page info="Login" %>
<%@ page contentType="text/html" %>
<%@ page session="false" %>
<%@ page buffer="30kb" %>
<%@ page errorPage="/ErrorPage.jsp" %>
<%@ page import="services.sessionservice.*" %>


<jsp:useBean id="logonManagement" scope="page" class="bflows.LogonManagement" />
<jsp:setProperty name="logonManagement" property="*" />

<%//gestione cookies e logon/logout
    
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
 
//------------------------------------------------------------------------------------------------------------------------   
  //controllo login   
  boolean loggedOn=false;   
    try{ if (Session.getCduser(cookies)!=null) //giustamente da errore se non esistono cookies, quindi gestisco l'errore ;)
         loggedOn=true;
         //lang=Session.getLingua(cookies); 
        }
    catch(Exception e) {
            loggedOn=false;}
    
    
  String id=null;
  String pass=null;
  String remi= null;
  
 if(lang!=null){
  if (lang.equals("ita"))
     {id = "Username";
     pass="Parola chiave";
     remi="Ricordami";}
  if (lang.equals("eng"))
     {id = "Username";
     pass="pass";
     remi="Remember me";}
  if (lang.equals("fra"))
     {id = "Username";
     pass="Mot de passe";
     remi="Souviens-toi de moi";}
  if (lang.equals("spa"))
     {id = "Username";
     pass="Contraseña";
     remi="Recuérdame";}
  }
////////////
    
  int i;
  String message=null;
  String status;

  status=request.getParameter("status");
  if (status==null) status="view";
  
   util.Debug.println("status prova: "+status); 
 
  if (status.equals("logon")) {
    logonManagement.logon();    
    if (logonManagement.getCookies() != null) {
      for(i=0;i<logonManagement.getCookies().length;i++)
        response.addCookie(logonManagement.getCookies(i));
      cookies=logonManagement.getCookies();
      loggedOn=true;      
    }
  }

 if (loggedOn==true) response.sendRedirect("home.jsp");
          
  if (logonManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (logonManagement.getResult()==-2) {
    message=logonManagement.getErrorMessage();
    
  }

%>
          
<html>
  <head>
    <title>Cantina Magna</title>
    <link href="css/newcss.css" rel="stylesheet" type="text/css"/>  
    <script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->
    <!---alert se user o pass errati-->
   <%if (message!=null) {%>
      <script>alert("<%=message%>");</script>
    <%}%> 
  </head>
  <body>
  <h1>Cantina Magna</h1>
			
<!-- Login Form -->
<form name="logonForm" action="login.jsp" method="post">
	<h1>Login</h1>
      <table border="0"> 
        <tr>
          <td class="normal" width="100"><%=id%>:</td>
          <td width="250">
            <input type="text" name="cduser" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><%=pass%>:</td>
          <td width="250">
            <input type="text" name="pass" size="20" maxlength="50"/>
          </td>
        </tr>
        <tr>
          <td class="normal" width="100"><label><input name="rememberme" id="rememberme" type="checkbox" checked="checked" value="forever" /> &nbsp;<%=remi%></label></td>
          <td width="250"> 
            <input type="hidden" name="status" value="logon"/>     
            <input type="submit" name="Login" value="Login" class="bt_login" onClick="submitLogon()" />
          </td>
        </tr>
      </table>
    </form>
    <form name="backForm" method="post" action="home.jsp">
    <input type="hidden" name="status" value="view"/>
    </form>	
 </body>
</html>

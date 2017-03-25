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

<%//logout
       
       // Cookie[] cookies;
  String lang= null;
       /*imposto la lingua controllando dalla request quella del browser*/
    if (request.getLocale().getLanguage().equals("it"))
        lang="ita";
    if (request.getLocale().getLanguage().equals("en"))
        lang="eng";
    if (request.getLocale().getLanguage().equals("fr"))
        lang="fra";
    if (request.getLocale().getLanguage().equals("sp"))
        lang="spa";
   
    
  Cookie[] cookies=null;
  cookies=request.getCookies(); 
  
  /*String lingua = request.getParameter("lingua");*/
  if(lang!=null){
  if (lang.equals("ita"))
     {lang = "ita";}
  if (lang.equals("eng"))
     {lang="eng";}
  if (lang.equals("fra"))
     {lang="fra";}
  if (lang.equals("spa"))
     {lang="spa";}
  }
  
//------------------------------------------------------------------------------------------------------------------------  

  int i;
  String message;
  

  ///controlla se ci sono cookie ed esegue il logout 
   if (Session.getCduser(cookies)!=null){
      logonManagement.setCookies(cookies);
      logonManagement.logout();    
      for(i=0;i<logonManagement.getCookies().length;i++)
      response.addCookie(logonManagement.getCookies(i));
      
   }

  if (logonManagement.getResult()==-1){    
    throw new Exception("Errore nell'applicazione: consultare i logs.");
  } else if (logonManagement.getResult()==-2) {
    message=logonManagement.getErrorMessage();
  }
response.sendRedirect("home.jsp"); 
%>

<html>
  <head>
    <title>Cantina Magna</title>
    <link href="css/newcss.css" rel="stylesheet" type="text/css"/>     
    <script type="text/javascript" src="js/MENU.js"></script><!--ELENCO SCRIPT UTILIZZATI -->
  </head>
  <body>	
<div class="footer">
    <div class="left_footer"><a href="home.jsp" title="Home"> <img src="images/logo2.png" alt="" width="170" height="49"/></a> </div>
    <div class="center_footer">&copy Copyright 2015 All Rights Reserved<br/><br/>
      <img src="images/paypal.png" alt="" /> </div>
</div>
</body>
</html>

<%-- 
    Document   : categorie
    Created on : 25-apr-2015, 11.37.54
    Author     : Arturo
--%>

                            <div class="rightsidebar span_3_of_1">
					<h2><%=categorie%></h2>
			             <ul>   
                                            <form method="post" action="search.jsp">
                                             <input type="hidden" name="search" value="R"/>
                                             <input type="image" src="images/bt_red.png" class="hvr-bubble-float-left" value="<%=rosso%>"/>                                                                                                              
                                            </form>
                                            <form method="post" action="search.jsp">
                                             <input type="hidden" name="search" value="W"/>
                                             <input type="image" src="images/bt_white.png" class="hvr-bubble-float-left" value="<%=bianco%>"/>                                                                                                              
                                            </form>
                                            <form method="post" action="search.jsp">
                                             <input type="hidden" name="search" value="O"/>
                                             <input type="image" src="images/bt_rose.png" class="hvr-bubble-float-left" value="<%=rose%>"/>                                                                                                              
                                            </form>
    				     </ul>
 		            </div>

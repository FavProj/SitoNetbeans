<%-- 
    Document   : Login
    Created on : 8-mar-2017, 13.03.34
    Author     : barlassina.lorenzo
--%>

<%@page language="java" import="java.lang.*,java.util.*,java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title> Login </title>
    </head>
    <body>
        <h1>Login</h1>
        <br/>
        <%
        String logginIn="";
        String usernameDB="";
        String passwordDB="";        
        //si prelevano i due valori
        String usernamePG = request.getParameter("username");
        String passwordPG = request.getParameter("password");
        
        //si comparano per verificare l'account
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            String UrlConnessione= "jdbc:mysql://localhost:3306/dbeventi";
            Connection con = DriverManager.getConnection(UrlConnessione,"user","admin");
            String querySQL = "SELECT * FROM utenti";
            Statement stmt = con.createStatement();
            out.write("Ciao ");
            ResultSet rs = stmt.executeQuery(querySQL);
            while(rs.next()){
                usernameDB = rs.getString("username");
                passwordDB = rs.getString("password");    
                if(usernameDB.equals(usernamePG) && passwordDB.equals(passwordPG)){
                    logginIn="Loggato";
                    break;
                }else{
                    logginIn="username o password errati";
                }
            }
        Statement log = con.createStatement();
        log.execute("UPDATE utenti SET LoggedIN = 1 WHERE username = '"+usernameDB+"' AND password = '"+passwordDB+"'");
        con.close();
        }catch(Exception e){
            e.printStackTrace();
        }   
        //stampa del logIn
        out.write(usernameDB+" ");
        out.write(logginIn);
        %>
        
        <button> Logout </button>
    </body>
</html>
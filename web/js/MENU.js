/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


//ricerca per tipi       
function submitR(index) {
    var s = document.formR;
    s.submit();
    return;           
}
function submitW(index) {
    var s = document.formW;
    s.submit();
    return;           
}
function submitO(index) {
    var s = document.formO;
    s.submit();
    return;           
}
function submitA(index) {
    var s = document.formA;
    s.submit();
    return;           
}          
//menu a tendina
$(document).ready(function($){
    $('#dc_mega-menu-orange').dcMegaMenu({rowItems:'4',speed:'fast',effect:'fade'});//per fare menu a tendina
  });
                        
//eliminare elemento
function rsubmit(index)
    {
        //cerco il form da submittare
         var f = document.forms["relement"+index];
         f.submit();
         return;
    }    
//selezionare elemento n-esimo  
function dsubmit(index) {
            var ts = document.forms["pid"+index];
            ts.submit();
            return;
        }
//controllare se è stato inserito
function isEmpty(value) {
  if (value == null || value.length == 0)
     return true;
    for (var count = 0; count < value.length; count++) {
      if (value.charAt(count) != " ") return false;
        }
       return true;
}                  
//se l'email è valida
function isValidEmail(s) {
    if (s.indexOf("@") > 0 && (s.indexOf("@") < (s.length - 1) ) ) return true;
    return false;
}          
//inserire user
function insertuser() {
   f=document.insertForm;
        //Nome
        if (isEmpty(f.nome.value)) {
          alert("Inserire il nome.");
          return;
        }      
        if (isEmpty(f.surname.value)) {
          alert("Inserire il surname.");
          return;
        } 
        if (isEmpty(f.indirizzo.value)) {
          alert("Inserire un indirizzo.");
          return;
        } 
        if (isEmpty(f.citta.value)) {
          alert("Inserire la citta.");
          return;
        } 
        if (isEmpty(f.telefono.value)) {
          alert("Inserire un numero di telefono.");
          return;
        } 
        if (isEmpty(f.email.value)) {
          alert("Inserire una email.");
          return;
        } 
        f.submit();
        return;
}
//inserire ordine    
function insertordine() {
        f=document.insertForm;
        //Città
        if (isEmpty(f.citta.value)) {
          alert("Inserire la citta.");
          return;
        }    
                //Cap
        if (isEmpty(f.cap.value)) {
          alert("Inserire il cap.");
          return;
        }   
                //Via
        if (isEmpty(f.via.value)) {
          alert("Inserire la via.");
          return;
        }   
        f.submit();
        return;
}

 //inserire ordinecheckkato    
function insertordine2() {
        f=document.conferm;
        f.submit();
        return;

      }
      
//inserire pagamento   
function insertpagamento() {
        f=document.pagamento;   
            //Nome
        if (isEmpty(f.nome.value)) {
          alert("Inserire il Nome.");
          return;
        }   
            //Cogn
        if (isEmpty(f.cogn.value)) {
          alert("Inserire il surname.");
          return;
        }   
            //cvv
        if (isEmpty(f.cvv.value)) {
          alert("Inserire la cvv.");
          return;
        }
        f.submit();
        return;
}
//inseire nuovi dati user     
function modifyuser() {
        f=document.modifyForm;
        //Nome
        if (isEmpty(f.nome.value)) {
          alert("Inserire il nome.");
          return;
        }  
        if (isEmpty(f.surname.value)) {
          alert("Inserire il surname.");
          return;
        } 
        if (isEmpty(f.indirizzo.value)) {
          alert("Inserire un indirizzo.");
          return;
        } 
        if (isEmpty(f.citta.value)) {
          alert("Inserire la citta.");
          return;
        } 
        if (isEmpty(f.telefono.value)) {
          alert("Inserire un numero di telefono.");
          return;
        } 
        if (isEmpty(f.email.value)) {
          alert("Inserire una email.");
          return;
        } if (isEmpty(f.tipo.value)) {
          alert("Scegli il tipo di utente.");
          return;
        }              
        f.submit();
        return;
}
//effettuare il login   
function submitLogon() { 
       if (isEmpty(logonForm.cduser.value)) {
          alert("Inserire la UserId.");
          return;
        }        
        if (isEmpty(logonForm.pass.value)) {
          alert("Inserire una pass.");
          return;
        }    
        logonForm.submit();
}
//inserire prodotto     
function insertprodotto() {
        f=document.insertForm;
        //Type_p
        if (isEmpty(f.nome_p.value)) {
          alert("Inserire il nome prodotto.");
          return;
        }      
        f.submit();
        return;
}
//inserire dettagli prodotto    
function insertdetails() {
        f=document.insertForm;
       if (isEmpty(f.lingua.value)) {
          alert("Inserire la lingua.");
          return;
        }
        f.submit();
        return;
}
//inserire coupon     
function insertcoupon() {
        f=document.insertForm;  
                //UserID
        if (isEmpty(f.cduser.value)) {
          alert("Inserire l'UserID.");
          return;
        }   
                //Importo
        if (isEmpty(f.importo.value)) {
          alert("Inserire l'importo.");
          return;
        }    
        f.submit();
        return;
}                       
//rimuovere ordine
function removeordine() {
        f=document.remove;
        f.submit();
        return;
}
//inserire prodotto p-esimo
function submitP(index) {
            var s = document.forms["prod"+index];
            s.submit();
            return;
}

   
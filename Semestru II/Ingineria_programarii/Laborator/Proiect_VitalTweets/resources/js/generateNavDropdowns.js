// // const keyTermsUrl = '../resources/json/keyTerms.json';

// // fetch(keyTermsUrl)
// //     .then(response => response.text())
// //     .then(promise => generateDropdown(JSON.parse(promise)));

// // function generateDropdown(json) {
// //     json.forEach(element => {
// //         JSON.stringify(element);

// //         let country = document.getElementById('input-country');
// //         let disease = document.getElementById('input-disease');

// //         let language = document.getElementById('input-language');
// //         let strLanguage = language.options[language.selectedIndex].text;
// //         //element[strLanguage]

// //         language.addEventListener('click', () => {
// //             setDisease(element.disease);
// //         });

// //         country.addEventListener('click', () => {
// //             setCountry(element.country);
// //         });
// //     });
// // }

// function setDisease(disease) {
//     var option = document.createElement('option');
//     option.value = disease;
//     option.innerHTML = disease;

//     var parent = document.getElementById('diseases');
//     parent.appendChild(option);
// }

// function setCountry(country) {
//     var option = document.createElement('option');
//     option.value = country;
//     option.innerHTML = country;

//     var parent = document.getElementById('regions');
//     parent.appendChild(option);
// }


//     let a = document.getElementById('input-language')
//     let b = document.getElementById('diseases')
//     let c = document.getElementById('regions')
//     // a,b,c retin elementele care schimba raportul cand userul a selectat o limba/boala/tara

//     a.addEventListener('click', () => {
//         let d = a.options[a.selectedIndex].text;
//         localStorage.setItem('language', d);
//     })
//     b.addEventListener('click', () => {
//         let e = b.options[b.selectedIndex].text;
//         localStorage.setItem('disease', e);
//     })
//     c.addEventListener('click', () => {
//         let f = c.options[c.selectedIndex].text;
//         localStorage.setItem('regions', f);
//     })

    /* const keyTermsUrl = '../resources/json/KeyTermsView.json';

    fetch (keyTermsUrl)
        .then(response => response.text())
        .then(promise => create(JSON.parse(promise))); */

    

     /*   var obj = {ID: 1, english: measles}; */

       /* obj.ID = document.getElementById("ID").value;
        obj.diseases = document.getElementById("english").value;

        var jsonString = JSON.stringify(obj);

        document.cookie = jsonString;  */

      
     //   myDisease = '{"ID":1, "romanian":"pojar", "english":"measles", "german":"masern", "french":"rougeole", "spanish":"sarampion"}';
      //  document.cookie = JSON.stringify('diseases = "{"ID":1, "romanian":pojar, "english":measles, "german":masern, "french":rougeole, "spanish":sarampion}"');
   //   document.cookie = 'diseases=' + JSON.stringify(myDisease);
     // var obj = document.cookie;
  // var Object = JSON.parse(JSON.stringify(document.cookie));

    document.cookie = "disease1=Measles";
    document.cookie = "disease2=Chicken pox";
    document.cookie = "disease3=Cancer";
    document.cookie = "disease4=Allergies";
    document.cookie = "disease5=Obesity";

    function getCookie(cname) {
      var name = cname + "=";
      var decodedCookie = decodeURIComponent(document.cookie);
      var ca = decodedCookie.split(';');
      for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
          c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
          return c.substring(name.length, c.length);
        }
      }
      return "";
    }
  
    var select = document.getElementById("diseases"); 
var options = [getCookie(disease1), getCookie(disease2), getCookie(disease3), getCookie(disease4), getCookie(disease5)]; 

    for(var i = 0; i < options.length; i++) {
      var opt = options[i];
      var el = document.createElement("option");
      el.textContent = opt;
      el.value = opt;
      select.appendChild(el);
  }​

 // function create(e) {

    
    //Aici incepe adaugarea bolilor
    
  /*  Object.entries(e[0]).forEach(entry => {
        if (entry[0] == 'english') {

            var child = document.createElement('option');
            child.value = entry[0];
            child.innerHTML = entry[0];

            var parent = document.getElementById('diseases');
            parent.appendChild(child);
        }
    });

    e.forEach(json => {
       Object.entries(json).forEach(entry => {
             
     
            let contSelect = document.getElementById('diseases');
            let strLanguage = contSelect.options[contSelect.selectedIndex].text;
            console.log(strLanguage)
            if (entry[0] == strLanguage) {
               var child = document.createElement('option');
                child.value = entry[1];
              child.innerHTML = entry[1];
                
                var parent = document.getElementById('diseases');
                parent.appendChild(child);
            }
        })
    })
    
    */


    //Aici incepe codul buguit

  //  let btn = document.getElementById('continent');
  //  btn.addEventListener('click', () => {
        // console.log('am ajuns aici 16');
  //      let del = document.getElementById('country');
     //   del.innerHTML = '';
     //   e.forEach(json => {
      //      // console.log('am ajuns aici 17');
      //      var counter = 0;
       //     var ids = 0;
       //     var array = [];

         //   Object.entries(json).forEach(entry => {
                
         //        console.log('am ajuns aici 23');
            //   pentru limba default se adauga boalele
         //      let contSelect = document.getElementById('continent');
         //       let strLanguage = contSelect.options[contSelect.selectedIndex].text;
         //     if (entry[1] == strLanguage) {
         //          counter += 1;
        //            var child = document.createElement('option');
         //           child.value = entry[2];
         //           child.innerHTML = entry[2];
                    // console.log('am ajuns aici 55');
        //            array.push(entry[2]);

        //            var parent = document.getElementById('continent');
       //             parent.appendChild(child);
        //        }
      //          if (entry[0] = 'ID') {
      //              ids++;
      //              // console.log('am ajuns aici 1111');
     //           }
     //       })
     //   })

    //    if (counter % ids) {
     //       let del = document.getElementById('country');
     //       del.innerHTML = '';
    //        array.forEach(p => {
     //           var child = document.createElement('option');
     //           child.value = p;
     //           child.innerHTML = p;
                // console.log('am ajuns aici 1123123');
    //            var parent = document.getElementById('continent');
    //            parent.appendChild(child);
   //         })
  //      }
 //   })

    //Aici se termina codul buguit
   
    let disease = document.getElementById('disease')
    let country = document.getElementById('country')
    let evolution = document.getElementById('evolution')
    
    // a,b,c retin elementele care schimba raportul cand userul a selectat o limba/boala/tara

   /// a.addEventListener('click', () => {
      //  let d = a.options[a.selectedIndex].text;
        //localStorage.setItem('language', d);
    //})

    disease.addEventListener('click', () => {
    let diseaseLS = disease.options[disease.selectedIndex].text;
    localStorage.setItem('disease', diseaseLS);
    })

   country.addEventListener('click', () => {
        let countryLS = country.options[country.selectedIndex].text;
        localStorage.setItem('country', countryLS);
    })

    evolution.addEventListener('click', () => {
        let evolutionLS = evolution.options[evolution.selectedIndex].text;
        localStorage.setItem('evolution', evolutionLS);
    })
 // }

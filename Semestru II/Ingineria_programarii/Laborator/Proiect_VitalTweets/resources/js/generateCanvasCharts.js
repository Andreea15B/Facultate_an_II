
var disease = undefined;
var country = undefined;
var timestamp = undefined;
var Countries = [];
var Diseases = [];
var Colors = [];
var Data = [];

document.cookie = "Tara=All";
document.cookie = "Boala=All";
document.cookie = "Data1=20";
document.cookie = "Data2=30";
document.cookie = "Data3=40";
document.cookie = "Data4=50";
document.cookie = "Data5=60";



//O functie care imi preia doar valoare dintr-un Cookie
function getCookieValue(c_name) {
    if (document.cookie.length > 0) {
        c_start = document.cookie.indexOf(c_name + "=");
        if (c_start != -1) {
            c_start = c_start + c_name.length + 1;
            c_end = document.cookie.indexOf(";", c_start);
            if (c_end == -1) {
                c_end = document.cookie.length;
            }
            return unescape(document.cookie.substring(c_start, c_end));
        }
    }
    return "";
}

//O functie care genereaza o culoare Random
function getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  }
var tara=getCookieValue("Tara");
var boala=getCookieValue("Boala");
var data1=getCookieValue("Data1");
var data2=getCookieValue("Data2");
var data3=getCookieValue("Data3");
var data4=getCookieValue("Data4");
var data5=getCookieValue("Data5");
    if(tara!=undefined && tara=="All")
       {
            Countries.push("United Kingdom");
            Countries.push("France");
            Countries.push("Germany");
            Countries.push("Spain");
            Countries.push("United States");
       } 
    if(tara!=undefined && tara!="All")
        Countries.push(tara);
    
    if(boala!=undefined && boala=="All"){
        Diseases.push("Measles");
        Diseases.push("Chicken pox");
        Diseases.push("Cancer");
        Diseases.push("Allergies");
        Diseases.push("Obesity");
    }
    if(boala!=undefined && boala!="All")
        Diseases.push(boala);
    if(data1!=undefined)
        Data.push(data1);
    if(data2!=undefined)
        Data.push(data2);
    if(data3!=undefined)
        Data.push(data3);
    if(data4!=undefined)
        Data.push(data4);
    if(data5!=undefined)
        Data.push(data5);
        Data.push(0);


    



function generateDoughnutChart(){
      
    for(i=0;i<Diseases.length;i++)
{
Colors.push(getRandomColor());
}
        new Chart(document.getElementById('ChartPie').getContext('2d'), {
        type: 'doughnut',
    data: {
      labels: Diseases,
      datasets: [
        {
          label: "Number of cases",
          backgroundColor: Colors,
          data: Data
        }
      ]
    },
    options: {
      title: {
        display: true,
        text: 'Number of cases for each disease in ' + tara
      }
    }
});

        main = document.getElementById("main-display");
}

function generateBarChart() {
    
    for(i=0;i<Countries.length;i++)
{
Colors.push(getRandomColor());
}
        new Chart(document.getElementById('ChartPie').getContext('2d'),{
            type: 'bar',
            data: {
                labels: Countries,
                datasets: [
                {
                    label: "Number of cases",
                    backgroundColor: Colors,
                    data: Data
                }
            ]
            },
            options: {
                legend: { display: false },
                title: {
                    display: true,
                    text: Diseases[0]
                },
                responsive: false,
                scales: {
                    xAxes: [{
                        barPercentage: 0.4
                    }]
                }
            }
        });

        main = document.getElementById("main-display");
}

function generateGroupedBarChart()
{

    for(i=0;i<Diseases.length;i++)
        Colors.push(getRandomColor());
        new Chart(document.getElementById('ChartPie'),{
            type: 'bar',
            data: {
              labels: Countries,
              datasets: [
                {
                  label: Diseases[0],
                  backgroundColor: Colors[0],
                  data: Data
                }, {
                  label: Diseases[1],
                  backgroundColor: Colors[1],
                  data: Data
                },
                {
                    label: Diseases[2],
                    backgroundColor: Colors[2],
                    data:Data
                },
                {
                        label: Diseases[3],
                        backgroundColor: Colors[3],
                        data: Data
                },
                {
                    label: Diseases[4],
                    backgroundColor: Colors[4],
                    data: Data
                }
              ]
            },
            options: {
              title: {
                display: true,
                text: 'Population growth (millions)'
              }
            }
        });
        main = document.getElementById("main-display");
}


function main() {
    if ( Countries.length>1 && Diseases.length==1 ) 
         generateBarChart();
    else if ( Countries.length==1 && Diseases.length>1 )
        generateDoughnutChart();
    else if (Countries.length>1 && Diseases.length>1)
        generateGroupedBarChart();
        

}

main();

document.addEventListener("DOMContentLoaded", function(event) {
    console.log("DOM fully loaded and parsed");

    var ctx = document.getElementById('myChart');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: name_js[0],
            datasets: [{
                label: '# of Votes',
                data: values_js[0],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });

    /////////////////////////////////////GRAFICO DE BARRAS//////////////

    var ctxx = document.getElementById("barras_meses").getContext('2d');
    var barras_3meses = new Chart(ctxx, {
    type: 'bar',
    data: {
      labels: months_js[0],
      datasets: [{
        label: 'On Basket',
        backgroundColor: "#ffad60",
        data: on_basquet_amounts_js[0],
      }, {
        label: 'Not Paid',
        backgroundColor: "#d9534f",
        data: not_paid_amounts_js[0],
      }, {
        label: 'Paid',
        backgroundColor: "#96ceb4",
        data: paid_amount_js[0],
      }],
    },
    options: {
      tooltips: {
        displayColors: true,
        callbacks:{
          mode: 'x',
        },
      },
      scales: {
        xAxes: [{
          stacked: true,
          gridLines: {
            display: false,
          }
        }],
        yAxes: [{
          stacked: true,
          ticks: {
            beginAtZero: true,
          },
          type: 'linear',
        }]
      },
      responsive: true,
      maintainAspectRatio: false,
      legend: { position: 'bottom' },
    }
    });





});


  document.addEventListener('turbolinks:before-cache', function(){
      $('#billingsTable').DataTable().destroy();
  })

  document.addEventListener('turbolinks:load', function(){
    $('#billingsTable').DataTable( {
        } );

  })

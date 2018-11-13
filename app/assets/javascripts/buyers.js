

  document.addEventListener('turbolinks:before-cache', function(){
      $('#buyersTable').DataTable().destroy();
  })

  document.addEventListener('turbolinks:load', function(){
      $('#buyersTable').DataTable();
  })

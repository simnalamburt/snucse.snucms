(function() {
  $.get('/course/list')
  .success(function(data) {
    $('.ui.search').search({
      source: data
    });
  });
}).call(this);

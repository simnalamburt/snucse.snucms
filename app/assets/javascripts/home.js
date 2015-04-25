(function() {
  $.get('/course/list')
  .success(function(data) {
    $('.ui.search').search({
      source: data,
      onSelect: function(result) {
        console.log(result);
      }
    });
  });
})();

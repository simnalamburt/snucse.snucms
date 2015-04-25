(function() {
  $.get('/course/list')
  .success(function(data) {
    $('.ui.search').search({
      source: data,
      onSelect: function(result) {
        $.post('/course/follow', {id: result.id})
        .success(function() {
          $("#course-list").append(
            '<a class="item" href="#">' + result.title + '</a>'
            );
          $(".ui.search .prompt").val('');
        })
        .error(function() {
        });
      }
    });
  });
})();

$(function() {
  $.get('/courses.json').success(function(data) {
    $('.ui.search').search({
      source: data.map(function(i) { return { id: i.id, title: i.name } }),
      onSelect: function(result) {
        $.post('/course/follow', { id: result.id }).success(function() {
          $('#course-list').append(
            '<p class="item">' +
              result.title +
              '<a href="#" data-course-id="' +
                result.id +
                '" class="delete-course">' +
                '<i class="icon trash"></i>' +
              '</a>' +
            '</p>'
            );
          $('.ui.search .prompt').val('');
        });
      }
    });
  });
});

$(document).on('click', '.delete-course', function() {
  var $this = $(this);
  $.ajax({
    method: 'delete',
    url: '/course/unfollow',
    data: { id: $this.data('courseId') }
  }).success(function() {
    $this.parents('p.item').remove();
  });
  return false;
});

$(function() {
  var getOldestTimeLineId = function() {
    var $list = $("#timeline-list .ui.card");
    // 아직 ajax로 불러오지 않았을 경우, 큰 값을 리턴해서 가장 최근의 타임라인 정보를 불러올 수 있도록 한다.
    // 타임라인의 아이디는 최근일수록 크니까, 가장 큰 값을 보내면 최근의 자료부터 불러온다.
    if($list.length <= 0) return Number.MAX_VALUE;
    return  Math.min.apply(Math,
      $list.map(function(i, e) { return parseInt($(e).data('timeline-id')); }));
  };

  var loadTimeline = function() {
    var $next = $('a.timeline-next'),
        $list = $('#timeline-list'),
        oldestTimeLineId,
        loadUrl;

    if ($next.length > 0 && $list.length > 0) {
      oldestTimeLineId = getOldestTimeLineId();
      // 처음 불러올 때는 /timeline, 추가로 불러올 때는 /timeline/older/:id 를 불러옴
      loadUrl = $list.children().length <= 0 ? '/timeline' : '/timeline/older/' + oldestTimeLineId + '?ajax=1';

      $("<div>").load(loadUrl, function() {
        $list.append($(this).html());
        if(oldestTimeLineId === getOldestTimeLineId()) {
          // 새로 불러온 페이지의 내용이 없을 경우 이전의 가장 오래된 타임라인 아이디와
          // 새로 가져온 가장 오래된 타임라인 아이디가 같을 것이므로,
          // 이 경우엔 더 이상 새로 불러올 필요가 없다.
          // 따라서 불러오는 트리거가 되는 a.timeline-next 를 제거한다.
          $next.remove();
        }
      });
    }
  };

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
          $("#timeline-list").load("/timeline");
        });
      }
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
      $("#timeline-list").load("/timeline");
    });
    return false;
  });

  $(document).on('click', '.icon.close', function() {
    $(this).closest('.message').transition('scale out', function() { $(this).remove(); });
  });
  $("a.timeline-next").appear();

  $(document).on('page:change', loadTimeline);
  $(document).on('page:change', function() {
    $(document.body).on('appear click', "a.timeline-next", loadTimeline);
  });
});

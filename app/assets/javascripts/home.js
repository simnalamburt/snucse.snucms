$(function() {
  var getOldestTimeLineId = function() {
    var $list = $("#timeline-list .ui.card");
    // 아직 ajax로 불러오지 않았을 경우, 큰 값을 리턴해서 가장 최근의 타임라인 정보를 불러올 수 있도록 한다.
    // 타임라인의 아이디는 최근일수록 크니까, 가장 큰 값을 보내면 최근의 자료부터 불러온다.
    if($list.length <= 0) return 0;
    return  Math.min.apply(Math,
      $list.map(function(i, e) { return parseInt($(e).data('timeline-id')); })) || 0;
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
      source: data.map(function(i) {
        return {
          id: i.id,
          title: i.name + " (" + i.code + ")\n - " + i.prof
        }
      }),
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

  // 새 공지사항 불러오는 기능 관련
  var newNotices = '';
  var applyNewNoticeBtn = function() {
    return $("#apply-new-notice-btn");
  };
  var newNoticeNum = function() {
    return $(newNotices).filter(".ui.card").length;
  };

  var getLatestNoticeId = function() {
    var $list = $("#timeline-list .ui.card");
    var $newList = $(newNotices);
    if($list.length <= 0) return Number.MIN_VALUE;
    var max1 = Math.max.apply(Math,
      $list.map(function(i, e) { return parseInt($(e).data('timeline-id')); }));
    var max2 = Math.max.apply(Math,
      $newList.map(function(i, e) { return parseInt($(e).data('timeline-id')); }))
    var min = max1 > max2 ? max1: max2;
    return isFinite(min) ? min : 0;
  };

  var loadNewNotices = function() {
    $.get('/timeline/since/' + getLatestNoticeId(), function(result) {
      newNotices = result.trim() + newNotices;
      if(newNoticeNum() > 0) {
        var newNoticeBtn = applyNewNoticeBtn();
        if(newNoticeBtn.length > 0) {
          newNoticeBtn.find('span.count').text(newNoticeNum());
        } else {
          $("<div>").attr('id', 'apply-new-notice-btn').addClass("ui ignored info message center aligned segment").append(
            $("<a>")
              .attr('href', '#')
              .append("View ")
              .append($("<span>").addClass("count").text(newNoticeNum()))
              .append(" New Notices"))
          .prependTo($("#timeline-list"));
        }
      }
    });
  };

  var applyNewNotice = function() {
    applyNewNoticeBtn().remove();
    $("#timeline-list").prepend($(newNotices));
    newNotices = '';
    return false;
  };

  setInterval(loadNewNotices, 30000);
  $(window).focus(loadNewNotices);
  $(document).on('click', '#apply-new-notice-btn', applyNewNotice);
});

$(function() {
  var loadCalendar = function() {
    $('.main.calendar').load('/calendar');
  };

  $(document).on('page:change', loadCalendar);
  $(document).on('click', '.calendar.link', function() {
    var link = $(this).attr('href');
    $('.main.calendar').load(link);

    return false;
  });
});


$(function() {
  var current_tab = "timeline";
  $("#timeline_button").hide();
  $(".main.calendar").hide();

  var showTimeline = function() {
    if(current_tab === "timeline") return false;
    $(".main.timeline").show();
    $(".main.calendar").hide();
    current_tab = "timeline";
    $("#timeline_button").hide();
    $("#calendar_button").show();
  };

  $(document).on('click', "#timeline_button", showTimeline);

  $(document).on('click', "#calendar_button", function() {
    if(current_tab === "calendar") return false;
    $(".main.timeline").hide();
    $(".main.calendar").show();
    current_tab = "calendar";
    $("#calendar_button").hide();
    $("#timeline_button").show();
  });

  $(document).on('page:change', function() {
    current_tab = '';
    showTimeline();
  });
});

$(function() {
  $(document).on('click', 'table.calendar tbody td', function() {
    var date = $(this).data('date');
    if(date) {
      /*
      $("<div>").load('/schedule/new/' + date, function(result) {
        var modal = $(result);
        $('body').append(modal);
        modal.find('select.dropdown').dropdown();
        modal.modal('show');
      });
      */
      $("#modal").load('/schedule/new/' + date, function(result) {
        $(this).find('select.dropdown').dropdown();
        $(this).modal('show');
      });
    }
  });

  $(document).on('click', 'table.calendar tbody td .schedule-detail', function(e) {
    e.stopPropagation();
    var schedule_id = $(this).data('scheduleId');
      $("#modal").load('/schedule/' + schedule_id, function(result) {
        $(this).modal('show');
      });
  });

  $(document).on('click', '.hide-modal.button', function() {
    $(this).closest('.modal').modal('hide');
  });

  $(document).on('ajax:success', '#new_schedule', function(e, data, status, xhr) {
    $("#modal").modal('hide');
    $(document).trigger('page:change');
    $("#calendar_button").click();
  });

  $(document).on('ajax:beforeSend', '.remove-schedule', function() {
    return confirm('Are you sure?');
  });
  $(document).on('ajax:success', '.remove-schedule', function() {
    $(this).closest('.schedule-detail').remove();
  });
});

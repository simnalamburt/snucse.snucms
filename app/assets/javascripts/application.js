// https://github.com/rails/sprockets#sprockets-directives
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require semantic_ui/semantic_ui
//= require jquery.appear

$(function() {
  window.current_year = (new Date()).getFullYear();
  window.current_month = (new Date()).getMonth() + 1;
  window.getParamFromUrl = function(url, key){
    var a = document.createElement('a');
    a.href = url;
    var _parammap = {};
    a.search.replace(/\??(?:([^=]+)=([^&]*)&?)/g, function () {
      function decode(s) {
        return decodeURIComponent(s.split("+").join(" "));
      }
      _parammap[decode(arguments[1])] = decode(arguments[2]);
    });
      return _parammap[key];
  };
});

$(function() {
  // UI animation
  var animateSNUCMS = function() {
    $('.main_top_header:visible, .main_top_subtext:visible')
      .hide();
    $('.main_top_header:hidden, .main_top_subtext:hidden')
      .transition('fade', 1500);
  };
  var showSNUCMS = function() {
    $('.main_top_header:hidden, .main_top_subtext:hidden')
      .transition('fade', 1500);
  };

  var animateFeatureBox = function() {
    $(this).children('h2').transition('pulse');
  };

  $(document).on('page:change', animateSNUCMS);
  $(document).on('page:change', showSNUCMS);
  $(document).on('click', '.feature_box, #course_list', animateFeatureBox);
});

$(function() {
  var getOldestTimeLineId = function() {
    var $list = $("#timeline-list .ui.card");
    // 아직 ajax로 불러오지 않았을 경우, 큰 값을 리턴해서 가장 최근의 타임라인 정보를 불러올 수 있도록 한다.
    if($list.length <= 0) return 0;
    return  $list.filter(":last").data('timelineId') || 0;
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

  // 검색 창에 아무 것도 입력되어 있지 않을 때, 스페이스 입력 못 하게 함.
  $("#search_box").keypress(function(e) {
    if($(this).val().length <= 0 && /\s/.test(String.fromCharCode(e.which))) {
      return false;
    }
  });

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
          $(document).trigger('page:change');
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
      $(document).trigger('page:change');
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
    var max1 = $list.filter(":first").data("timelineId");
    var max2 = $newList.filter(":first").data("timelineId");
    return isFinite(max2) ? max2 : (isFinite(max1) ? max1 : 0);
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
    if(current_year && current_month) {
      $('.main.calendar').load('/calendar?year=' + current_year + '&month=' + current_month);
    } else {
      current_year = (new Date()).getFullYear();
      current_month = (new Date()).getMonth() + 1;
      $('.main.calendar').load('/calendar');
    }
  };

  $(document).on('page:change', loadCalendar);
  $(document).on('click', '.calendar.link', function() {
    var link = $(this).attr('href');
    $('.main.calendar').load(link);
    var parser = document.createElement('a');
    parser.href = link;
    window.current_year = parseInt(getParamFromUrl(link, 'year'));
    window.current_month = parseInt(getParamFromUrl(link, 'month'));

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

  var showCalendar = function() {
    if(current_tab === "calendar") return false;
    $(".main.timeline").hide();
    $(".main.calendar").show();
    current_tab = "calendar";
    $("#calendar_button").hide();
    $("#timeline_button").show();
  };

  $(document).on('click', "#timeline_button", showTimeline);
  $(document).on('click', "#calendar_button", showCalendar);

  $(document).on('page:change', function() {
    if (current_tab === "calendar")
    {
      current_tab = '';
      showCalendar();
    }
    else if (current_tab === "timeline")
    {
      current_tab = '';
      showTimeline();
    }
  });
});

$(function() {
  $(document).on('click', 'table.calendar tbody td', function() {
    var date = $(this).data('date');
    if(date) {
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

  $(document).on('click', '#modal-close-button, .modal .close.icon', function() {
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

  $(document).on('click', '#course_list', function() {
    $("#modal").load('/courses #content', function(result) {
      $(this).modal('show');
    });
  });
});

$(function() {
  // 계정 삭제 버튼
  $(document).on('click', "#remove-account-btn", function() {
    $('#remove-account').modal('show');
  });
});

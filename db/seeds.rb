case Rails.env
when 'development'
  Course.delete_all
  courses = Course.create [
    { name: '소프트웨어 개발의 원리와 실제' },
    { name: '멀티코어 컴퓨팅' },
    { name: 'IT-리더십 세미나' },
    { name: '창의적통합설계2' },
    { name: '시스템프로그래밍' }
  ]

  User.delete_all
  User.create email: 'test@example.com', password: 'testpass', course: courses[0..2]

  Admin.delete_all
  Admin.create email: 'admin@example.com', password: 'adminpass'

  Site.delete_all
  sites = Site.create [
    { name: '메인 사이트', url: 'https://sites.google.com/site/snuswppspr2015/', crawling_type: 'googlesite', course: courses[0]  },
    { name: '메인 사이트', url: 'http://meslab.snu.ac.kr/courses/2015s/project/', crawling_type: 'custom', course: courses[3] }
  ]

  pivot_date = DateTime.new(2015, 3, 1, 0, 0, 0)
  Log.delete_all
  logs = Log.create [
    { message: '3/4: Office hours changed from <strike>TuTh 11AM-12PM</strike> to MW 1PM-2PM', site: sites[0], created_at: pivot_date.change(day: 3, hour: 13, min: 3, sec: 18) },
    { message: '3/11: Class for 3/12 (Thu) will be given at <b>Bldg. 302, Rm. 311-1</b> (practice session)', site: sites[0], created_at: pivot_date.change(day: 10, hour: 13, min: 3, sec: 11) },
    { message: '3/16: Class for 3/16 (Today) will be given at <b>Bldg. 302, Rm. 106 (</b>proposal presentation & team formation)', site: sites[0], created_at: pivot_date.change(day: 16, hour: 2, min: 28, sec: 47) },
    { message: '3/17:  Individual warm-up project due 4/10 (Fri) 6PM', site: sites[0], created_at: pivot_date.change(day: 17, hour: 20, min: 19, sec: 11) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(day: 20, hour: 17, min: 16, sec: 3) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 4, day: 3, hour: 20, min: 36, sec: 51) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 4, day: 14, hour: 0, min: 41, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 4, day: 16, hour: 20, min: 7, sec: 58) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 4, day: 20, hour: 14, min: 24, sec: 9) },
    { message: '4/27: Class for 4/27 (Today) will be given at <b>Bldg. 302, Rm. 106</b> (iteration 1 presentation with pizza)', site: sites[0], created_at: pivot_date.change(month: 4, day: 26, hour: 5, min: 41, sec: 15) },
    { message: '5/1: No class on 5/5 (Tue)', site: sites[0], created_at: pivot_date.change(month: 5, hour: 11, min: 51, sec: 32) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 5, day: 2, hour: 10, min: 31, sec: 23) },
    { message: '5/10: Class for 5/11 (Mon) will be given at <b>Bldg. 302, Rm. 106</b> (lecture)', site: sites[0], created_at: pivot_date.change(month: 5, day: 9, hour: 19, min: 22, sec: 10) },
  ]
end

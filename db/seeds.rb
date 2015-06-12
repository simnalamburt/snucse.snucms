case Rails.env
when 'development'
  Course.delete_all
  courses = Course.create [
    { name: '소프트웨어 개발의 원리와 실제', code: '001', prof: '전병곤' },
    { name: '멀티코어 컴퓨팅', code: '001', prof: '이재진' },
    { name: 'IT-리더십 세미나', code: '001', prof: '박근수' },
    { name: '창의적통합설계2', code: '001', prof: '박근수' },
    { name: '시스템프로그래밍', code: '001', prof: '염헌영' },
    { name: '시스템프로그래밍', code: '002', prof: '이강웅' },
    { name: '운영체제', code: '001', prof: '신현식'},
    { name: '자료구조', code: '001', prof: '문병로'},
    { name: '자료구조', code: '002', prof: '문봉기'},
    { name: '프로그래밍연습', code: '001', prof: '장병탁'},
    { name: '프로그래밍 언어', code: '001', prof: '허충길'},
    { name: '컴퓨터 프로그래밍', code: '001', prof: '엄현상'},
    { name: '인공지능', code: '001', prof: '장병탁'},
    { name: '논리설계', code: '001', prof: '이창건'},
    { name: '선형 및 비선형 계산모델', code: '001', prof: '김명수'}
  ]

  User.delete_all
  User.create email: 'test@example.com', password: 'testpass', courses: courses[0..13]

  Admin.delete_all
  Admin.create email: 'admin@example.com', password: 'adminpass'

  Site.delete_all
  sites = Site.create [
    {
      name: '최근 변경사항',
      url: 'https://sites.google.com/site/snuswppspr2015/system/app/pages/recentChanges',
      crawling_type: :google_site_recent_changes,
      course: courses[0]
    },
    {
      name: '메인 사이트',
      url: 'http://mobisys.snu.ac.kr/course/os15s/',
      crawling_type: :undefined,
      course: courses[6]
    },
    {
      name: '메인 사이트',
      url: 'http://bi.snu.ac.kr/Courses/PP15/PP15s.html',
      crawling_type: :undefined,
      course: courses[9]
    },
    {
      name: '메인 사이트',
      url: 'http://bi.snu.ac.kr/Courses/4ai15s/4ai15s.html',
      crawling_type: :undefined,
      course: courses[12]
    },
    {
      name: '메인 사이트',
      url: 'http://rubis.snu.ac.kr/logic_design_2015_spring',
      crawling_type: :undefined,
      course: courses[13]
    },
    {
      name: '메인 사이트',
      url: 'http://3map.snu.ac.kr/courses/2015/appmath/main.html',
      crawling_type: :undefined,
      course: courses[13]
    }
  ]

  Log.delete_all
  CrawlerJob.perform_later
  pivot_date = DateTime.new(2015, 3, 1, 0, 0, 0)
  Log.create [
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(day: 20, hour: 17, min: 16, sec: 3) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 4, day: 3, hour: 20, min: 36, sec: 51) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 4, day: 14, hour: 0, min: 41, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 4, day: 16, hour: 20, min: 7, sec: 58) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 4, day: 20, hour: 14, min: 24, sec: 9) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 5, day: 2, hour: 10, min: 31, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 5, day: 15, hour: 10, min: 31, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 5, day: 25, hour: 10, min: 31, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 5, day: 28, hour: 19, min: 31, sec: 37) },
    { message: '새 공지가 올라왔습니다.', site: sites[1], created_at: pivot_date.change(month: 6, day: 25, hour: 10, min: 31, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[2], created_at: pivot_date.change(month: 3, day: 12, hour: 13, min: 45, sec: 14) },
    { message: '새 공지가 올라왔습니다.', site: sites[2], created_at: pivot_date.change(month: 3, day: 20, hour: 10, min: 28, sec: 29) },
    { message: '새 공지가 올라왔습니다.', site: sites[2], created_at: pivot_date.change(month: 3, day: 28, hour: 19, min: 37, sec: 34) },
    { message: '새 공지가 올라왔습니다.', site: sites[2], created_at: pivot_date.change(month: 4, day: 5, hour: 21, min: 3, sec: 52) },
    { message: '새 공지가 올라왔습니다.', site: sites[2], created_at: pivot_date.change(month: 4, day: 17, hour: 15, min: 1, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[2], created_at: pivot_date.change(month: 4, day: 26, hour: 13, min: 45, sec: 14) },
    { message: '새 공지가 올라왔습니다.', site: sites[2], created_at: pivot_date.change(month: 5, day: 3, hour: 10, min: 28, sec: 29) },
    { message: '새 공지가 올라왔습니다.', site: sites[2], created_at: pivot_date.change(month: 5, day: 17, hour: 19, min: 37, sec: 34) },
    { message: '새 공지가 올라왔습니다.', site: sites[2], created_at: pivot_date.change(month: 6, day: 1, hour: 21, min: 3, sec: 52) },
    { message: '새 공지가 올라왔습니다.', site: sites[2], created_at: pivot_date.change(month: 6, day: 4, hour: 15, min: 1, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[3], created_at: pivot_date.change(month: 3, day: 2, hour: 13, min: 45, sec: 14) },
    { message: '새 공지가 올라왔습니다.', site: sites[3], created_at: pivot_date.change(month: 3, day: 13, hour: 10, min: 28, sec: 29) },
    { message: '새 공지가 올라왔습니다.', site: sites[3], created_at: pivot_date.change(month: 3, day: 24, hour: 19, min: 37, sec: 34) },
    { message: '새 공지가 올라왔습니다.', site: sites[3], created_at: pivot_date.change(month: 4, day: 15, hour: 21, min: 3, sec: 52) },
    { message: '새 공지가 올라왔습니다.', site: sites[3], created_at: pivot_date.change(month: 4, day: 20, hour: 15, min: 1, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[3], created_at: pivot_date.change(month: 4, day: 26, hour: 13, min: 45, sec: 14) },
    { message: '새 공지가 올라왔습니다.', site: sites[3], created_at: pivot_date.change(month: 5, day: 13, hour: 10, min: 28, sec: 29) },
    { message: '새 공지가 올라왔습니다.', site: sites[3], created_at: pivot_date.change(month: 5, day: 28, hour: 19, min: 37, sec: 34) },
    { message: '새 공지가 올라왔습니다.', site: sites[3], created_at: pivot_date.change(month: 6, day: 2, hour: 21, min: 3, sec: 52) },
    { message: '새 공지가 올라왔습니다.', site: sites[3], created_at: pivot_date.change(month: 6, day: 7, hour: 15, min: 1, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[4], created_at: pivot_date.change(month: 3, day: 2, hour: 13, min: 45, sec: 14) },
    { message: '새 공지가 올라왔습니다.', site: sites[4], created_at: pivot_date.change(month: 3, day: 12, hour: 10, min: 28, sec: 29) },
    { message: '새 공지가 올라왔습니다.', site: sites[4], created_at: pivot_date.change(month: 3, day: 24, hour: 19, min: 37, sec: 34) },
    { message: '새 공지가 올라왔습니다.', site: sites[4], created_at: pivot_date.change(month: 4, day: 16, hour: 21, min: 3, sec: 52) },
    { message: '새 공지가 올라왔습니다.', site: sites[4], created_at: pivot_date.change(month: 4, day: 19, hour: 15, min: 1, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[4], created_at: pivot_date.change(month: 4, day: 27, hour: 13, min: 45, sec: 14) },
    { message: '새 공지가 올라왔습니다.', site: sites[4], created_at: pivot_date.change(month: 5, day: 14, hour: 10, min: 28, sec: 29) },
    { message: '새 공지가 올라왔습니다.', site: sites[4], created_at: pivot_date.change(month: 5, day: 29, hour: 19, min: 37, sec: 34) },
    { message: '새 공지가 올라왔습니다.', site: sites[4], created_at: pivot_date.change(month: 6, day: 5, hour: 21, min: 3, sec: 52) },
    { message: '새 공지가 올라왔습니다.', site: sites[4], created_at: pivot_date.change(month: 6, day: 9, hour: 15, min: 1, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[5], created_at: pivot_date.change(month: 3, day: 2, hour: 13, min: 45, sec: 14) },
    { message: '새 공지가 올라왔습니다.', site: sites[5], created_at: pivot_date.change(month: 3, day: 12, hour: 10, min: 28, sec: 29) },
    { message: '새 공지가 올라왔습니다.', site: sites[5], created_at: pivot_date.change(month: 3, day: 24, hour: 19, min: 37, sec: 34) },
    { message: '새 공지가 올라왔습니다.', site: sites[5], created_at: pivot_date.change(month: 4, day: 16, hour: 21, min: 3, sec: 52) },
    { message: '새 공지가 올라왔습니다.', site: sites[5], created_at: pivot_date.change(month: 4, day: 19, hour: 15, min: 1, sec: 23) },
    { message: '새 공지가 올라왔습니다.', site: sites[5], created_at: pivot_date.change(month: 4, day: 27, hour: 13, min: 45, sec: 14) },
    { message: '새 공지가 올라왔습니다.', site: sites[5], created_at: pivot_date.change(month: 5, day: 14, hour: 10, min: 28, sec: 29) },
    { message: '새 공지가 올라왔습니다.', site: sites[5], created_at: pivot_date.change(month: 5, day: 29, hour: 19, min: 37, sec: 34) },
    { message: '새 공지가 올라왔습니다.', site: sites[5], created_at: pivot_date.change(month: 6, day: 1, hour: 21, min: 3, sec: 52) },
    { message: '새 공지가 올라왔습니다.', site: sites[5], created_at: pivot_date.change(month: 6, day: 3, hour: 15, min: 1, sec: 23) }
  ]
end

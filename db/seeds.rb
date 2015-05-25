case Rails.env
when 'development'
  Course.delete_all
  courses = Course.create [
    { name: '소프트웨어 개발의 원리와 실제', code: '001' },
    { name: '멀티코어 컴퓨팅', code: '001' },
    { name: 'IT-리더십 세미나', code: '001' },
    { name: '창의적통합설계2', code: '001' },
    { name: '시스템프로그래밍', code: '001' },
    { name: '시스템프로그래밍', code: '002' }
  ]

  User.delete_all
  User.create email: 'test@example.com', password: 'testpass', courses: courses[0..2]

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
      url: 'http://meslab.snu.ac.kr/courses/2015s/project/',
      crawling_type: :undefined,
      course: courses[3]
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
  ]
end

case Rails.env
when 'development'
  Course.delete_all
  courses = Course.create [
    { name: '소프트웨어 개발의 원리와 실제' },
    { name: '멀티코어 컴퓨팅' },
    { name: 'IT-리더십 세미나' },
    { name: 'Principles and Practices of Software Development' },
    { name: '창의적통합설계2' },
    { name: '시스템프로그래밍' }
  ]

  User.delete_all
  User.create email: 'test@example.com', password: 'testpass', course: courses[0..2]

  Admin.delete_all
  Admin.create email: 'admin@example.com', password: 'adminpass'

  Site.delete_all
  sites = Site.create [
    { name: '메인 사이트', url: 'https://sites.google.com/site/snuswppspr2015/', crawling_type: 'googlesite', course_id: Course.find_by(name: '소프트웨어 개발의 원리와 실제').id  },
    { name: '메인 사이트', url: 'https://sites.google.com/site/snuswppspr2015/', crawling_type: 'googlesite', course_id: Course.find_by(name:'Principles and Practices of Software Development').id },
    { name: '메인 사이트', url: 'http://meslab.snu.ac.kr/courses/2015s/project/', crawling_type: 'custom', course_id: Course.find_by(name: '창의적통합설계2').id }
  ]
end

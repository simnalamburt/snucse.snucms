SNUCMS
========

서울대학교 학생을 위한 강의정보 웹서비스

![Screenshot](https://swsnu.github.io/SNUCMS/screenshot.png)

### Instructions

1.  Checkout source codes

1.  Set up rails environment

    ```sh
    bundle install
    rake db:migrate db:seed
    ```

1.  Update crontab for crawling script

    ```sh
    vi config/schedule.rb
    whenever --update-crontab
    ```

1.  Test

    ```sh
    cucumber
    rake test
    ```

* 테스트용 계정, 비밀번호: `test@example.com`, `testpass`
* 개발용 관리자계정, 비밀번호: `admin@example.com`, `adminpass`

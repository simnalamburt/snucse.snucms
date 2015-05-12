class CrawlerJob < ActiveJob::Base
  def perform
    messages = <<-MESSAGES
3/4: Office hours changed from <strike>TuTh 11AM-12PM</strike> to MW 1PM-2PM
3/11: Class for 3/12 (Thu) will be given at <b>Bldg. 302, Rm. 311-1</b> (practice session)
3/16: Class for 3/16 (Today) will be given at <b>Bldg. 302, Rm. 106 (</b>proposal presentation & team formation)
3/17:  Individual warm-up project due 4/10 (Fri) 6PM
4/27: Class for 4/27 (Today) will be given at <b>Bldg. 302, Rm. 106</b> (iteration 1 presentation with pizza)
5/1: No class on 5/5 (Tue)
5/10: Class for 5/11 (Mon) will be given at <b>Bldg. 302, Rm. 106</b> (lecture)
    MESSAGES

    site = Course.find_by(name: '소프트웨어 개발의 원리와 실제').sites[0]
    pivot_date = DateTime.new(2015, 3, 1, 0, 0, 0)

    inputs = messages.lines.map do |l|
      { message: l.chomp, site: site, created_at: pivot_date.change(day: 3, hour: 13, min: 3, sec: 18) }
    end
    Log.create inputs
  end
end

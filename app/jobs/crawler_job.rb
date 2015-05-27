class CrawlerJob < ActiveJob::Base
  def perform
    entries = Site.google_site_recent_changes.flat_map do |site|
      result = Wombat.crawl do
        base_url site.url

        activities({ css: '#sites-recent-activity-wrapper tr' }, :iterator) do
          date do
            date_ge_one_day xpath: 'td[1]/strong/span'
            date_lt_one_day xpath: 'td[1]/strong/noscript'
          end
          msg({ css: 'td:nth(2)' }, :html)
        end
      end

      result['activities'].map do |action|
        {
          message: action['msg'],
          site: site,
          created_at: Date.parse(
            (action['date'])['date_ge_one_day'].nil? ?
            (action['date'])['date_lt_one_day'] :
            (action['date'])['date_ge_one_day']
          )
        }
      end
    end

    Log.create entries
  end
end

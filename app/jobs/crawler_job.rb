class CrawlerJob < ActiveJob::Base
  def perform
    entries = Site.google_site_recent_changes.flat_map do |site|
      result = Wombat.crawl do
        base_url site.url
        activities({ css: '#sites-recent-activity-wrapper tr' }, :iterator) do
          date0 xpath: 'td[1]/strong/noscript'
          date1 xpath: 'td[1]/strong/span'
          msg({ css: 'td:nth(2)' }, :html)
        end
      end

      result['activities'].map do |action|
        {
          site: site,
          message: action['msg'],
          created_at: DateTime.parse(action['date0'] || action['date1'])
        }
      end
    end

    Log.create entries
  end
end

class CrawlerJob < ActiveJob::Base
  def perform
    entries = Site.google_site_recent_changes.flat_map do |site|
      result = Wombat.crawl do
        base_url site.url

        activities({ css: '#sites-recent-activity-wrapper tr' }, :iterator) do
          date css: 'td:nth(1) span'
          msg({ css: 'td:nth(2)' }, :html)
        end
      end

      result['activities'].map do |action|
        byebug
        {
          message: action['msg'],
          site: site,
          created_at: Date.parse(action['date'])
        }
      end
    end

    Log.create entries
  end
end

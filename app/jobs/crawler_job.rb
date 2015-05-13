class CrawlerJob < ActiveJob::Base
  def perform
    entries = Site.google_site_recent_changes.flat_map do |site|
      # Perform crawling
      result = Wombat.crawl do
        base_url site.url
        activities({ css: '#sites-recent-activity-wrapper tr' }, :iterator) do
          date0 xpath: 'td[1]/strong/noscript'
          date1 xpath: 'td[1]/strong/span'
          msg({ css: 'td:nth(2)' }, :html)
        end
      end

      # Process
      entries = result['activities'].map do |action|
        {
          site: site,
          message: action['msg'],
          created_at: DateTime.parse(action['date0'] || action['date1'])
        }
      end

      # Store updated data into DB
      delta = entries - site.data
      unless delta.empty?
        site.data = entries
        site.save
      end
      delta
    end

    # Update logs table
    Log.create entries
  end
end

# Sitemap file exported to public/sitemap.xml.gz
#
# Generate sitemap using Rake: rake sitemap:refresh
#
# When testing on development server use without ping: rake sitemap:refresh:no_ping
#
# To generate uncompressed XML add compress: false as a Sitemap.create argument.

SitemapGenerator::Sitemap.default_host = "http://winnipegelection.ca"

SitemapGenerator::Sitemap.create do
  Page.find_each do |page|
    add page.friendly_path,
        lastmod: page.updated_at,
        priority: 0.8,
        changefreq: 'weekly'
  end

  Person.find_each do |person|
    unless person.most_recent_candidacy.nil?
      if person.most_recent_election.is_active
        priority = 0.9
        changefreq = 'daily'
      else
        priority = 0.7
        changefreq = 'yearly'
      end

      add person.friendly_path,
          lastmod: person.updated_at_including_news_mentions,
          priority: priority,
          changefreq: changefreq
    end
  end

  ElectoralRace.includes(:election, region: :region_type).each do |electoral_race|
    if electoral_race.election.is_active
      priority = 0.9
      changefreq = 'daily'
    else
      priority = 0.7
      changefreq = 'yearly'
    end
    add electoral_race.friendly_path,
        # TODO: lastmod should also consider associated candidacies
        lastmod: electoral_race.updated_at_including_news_articles,
        priority: priority,
        changefreq: changefreq
  end
end

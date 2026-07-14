require "date"

# Adds latest_event_date to each _citycamp doc (for sort: "latest_event_date" in Liquid)
# and builds site.data.citycamp_past_events: a flat list of all past events sorted
# most-recent-first, for the Past CityCamps accordion.
Jekyll::Hooks.register :site, :post_read do |site|
  site.collections["citycamp"]&.docs&.each do |doc|
    latest = (doc.data["events"] || []).map { |e| e["date"] }.compact.max
    doc.data["latest_event_date"] = latest ? latest.strftime("%Y-%m-%d") : ""
  end
end

Jekyll::Hooks.register :site, :pre_render do |site|
  today_str = site.config["current_date"] || Date.today.strftime("%Y-%m-%d")

  past_events = []
  site.collections["citycamp"]&.docs&.each do |doc|
    (doc.data["events"] || []).each do |event|
      next unless event["date"]
      date_str = event["date"].strftime("%Y-%m-%d")
      next if date_str >= today_str

      past_events << {
        "city"    => doc.data["city"],
        "region"  => doc.data["region"],
        "country" => doc.data["country"],
        "url"     => doc.url,
        "date"    => event["date"],
        "name"    => event["name"]
      }
    end
  end

  past_events.sort_by! { |e| e["date"].strftime("%Y-%m-%d") }.reverse!
  site.data["citycamp_past_events"] = past_events
end

require "date"

# Sets site.current_date for use in Liquid templates.
# Priority: CURRENT_DATE env var > current_date in _config.yml > today's date.
# Usage: CURRENT_DATE=2025-01-01 jekyll build
Jekyll::Hooks.register :site, :after_init do |site|
  site.config["current_date"] =
    if ENV["CURRENT_DATE"] && !ENV["CURRENT_DATE"].empty?
      ENV["CURRENT_DATE"]
    elsif site.config.key?("current_date")
      site.config["current_date"].to_s
    else
      Date.today.strftime("%Y-%m-%d")
    end
end

#!/usr/bin/env ruby
# One-time import: generates _citycamp/*.md from _data/citycamp/events.json
# Safe to re-run; skips files that already exist.

require "json"
require "yaml"
require "date"

ROOT = File.expand_path("..", __dir__)
events_data = JSON.parse(File.read(File.join(ROOT, "_data/citycamp/events.json")))

# Group by slug so Oakland/SF (which have two entries each) become one file
grouped = events_data.group_by { |e| e["slug"] }

grouped.each do |_slug, entries|
  base = entries.first
  city_name = base["city"]
  next unless city_name

  # Derive filename from city name
  filename_slug = city_name.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/^-|-$/, "")
  path = File.join(ROOT, "_citycamp", "#{filename_slug}.md")

  if File.exist?(path)
    puts "skip   #{filename_slug}.md (already exists)"
    next
  end

  fm = {}
  fm["city"]      = city_name
  fm["region"]    = base["addressRegion"]  if base["addressRegion"]
  fm["country"]   = base["addressCountry"] if base["addressCountry"]
  fm["latitude"]  = base["latitude"]       if base["latitude"]
  fm["longitude"] = base["longitude"]      if base["longitude"]

  events = entries.filter_map do |e|
    next unless e["date"]

    ev = {}
    ev["name"] = e["name"]
    ev["date"] = Date.parse(e["date"].to_s)

    ev["venue"]    = e["venue"]   if e["venue"]

    if e["streetAddress"] || e["addressLocality"]
      addr = [e["streetAddress"], e["addressLocality"], e["addressRegion"], e["postalCode"]].compact
      ev["address"] = addr.join(", ")
    end

    ev["website"]          = e["website"]         if e["website"]
    ev["organizer"]        = e["organizer"]        if e["organizer"]
    ev["organizer_website"] = e["organizer-url"]   if e["organizer-url"]
    ev["about"]            = e["about"]            if e["about"]
    ev
  end

  fm["events"] = events unless events.empty?

  yaml_body = YAML.dump(fm).sub(/\A---\s*\n/, "")
  File.write(path, "---\n#{yaml_body}---\n")
  puts "create #{filename_slug}.md"
end

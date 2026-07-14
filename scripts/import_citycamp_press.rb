#!/usr/bin/env ruby
# Extracts press items from _data/citycamp/press.yml into individual _citycamp/*.md files.
# Always replaces the press block for managed cities (idempotent re-run).

require "yaml"
require "date"

ROOT = File.expand_path("..", __dir__)
press_data = YAML.safe_load_file(File.join(ROOT, "_data/citycamp/press.yml"), permitted_classes: [Date])
all_press = press_data["docs"]

# State → city slug (for clear single-state attribution)
STATE_TO_CITY = {
  "GA"      => "savannah",
  "NC"      => "raleigh",
  "HI"      => "honolulu",
  "MN"      => "minneapolis",
  "CO"      => "denver",
  "MO"      => "kansas-city",
  "DC"      => "washington-dc",
  "IL"      => "chicago",
  "England" => "manchester",
}

# Title → one or more city slugs (for empty-state items with clear city attribution)
TITLE_TO_CITIES = {
  # Kevin Curry (Chicago organizer) talking about CityCamp Chicago
  "TechDrawl | Kevin Curry talks about CityCamp" => ["chicago"],
  # Jason Hibbets writing about Honolulu prep (Dec 2011)
  "Restoring trust in government" => ["honolulu"],
  # Jason Hibbets on organizing the Raleigh unconference (June 2011)
  "CityCamp: Organizing an unconference for a transparent city government" => ["raleigh"],
  # Source is "CityCamp NC" despite empty state
  "CityCampNC 2015 Lightning Talk - Mark Headd--keynote preview" => ["raleigh"],
  # Multi-city: Sacramento, Oakland, San Francisco, Chattanooga
  "4 Cities Jumpstart Civic Tech Solutions with CityCamp" => ["sacramento", "oakland", "san-francisco", "chattanooga"],
  # Explicitly Oakland-focused (CA state but Oakland-specific)
  "OpenOakland brigade encourages collaboration between government and community using technology" => ["oakland"],
}

# CA items not in TITLE_TO_CITIES are Palo Alto — no city page exists, skip them.

# Build city slug → [{ title, website, date }, ...] mapping
city_press = Hash.new { |h, k| h[k] = [] }

all_press.each do |item|
  title = item["title"]
  url   = item["url"]
  date  = item["date"]

  if TITLE_TO_CITIES.key?(title)
    TITLE_TO_CITIES[title].each do |slug|
      city_press[slug] << { "title" => title, "website" => url, "date" => date }
    end
    next
  end

  state = item["state"].to_s
  next if state.empty?

  slug = STATE_TO_CITY[state]
  next unless slug

  city_press[slug] << { "title" => title, "website" => url, "date" => date }
end

def serialize_press_item(p)
  lines = "- title: #{p["title"].inspect}\n"
  lines += "  website: #{p["website"].inspect}\n"
  lines += "  date: #{p["date"].strftime("%Y-%m-%d")}\n" if p["date"]
  lines
end

# Update each city file. For script-managed cities, always replace the press block entirely
# so re-runs are idempotent. Preserves non-press frontmatter text as-is to avoid
# reformatting multiline `about:` block scalars.
city_press.each do |slug, new_items|
  path = File.join(ROOT, "_citycamp", "#{slug}.md")
  unless File.exist?(path)
    puts "SKIP  #{slug}.md (not found)"
    next
  end

  content = File.read(path)

  # content looks like:  "---\n<frontmatter>\n---\n"
  parts = content.split(/^---\s*?\n/, 3)
  fm_text = parts[1]

  # Strip any existing press block (we always rewrite it)
  fm_without_press = fm_text.sub(/^press:.*\z/m, "").rstrip

  press_block = "press:\n" + new_items.map { |p| serialize_press_item(p) }.join
  new_fm = "#{fm_without_press}\n#{press_block}"

  File.write(path, "---\n#{new_fm}\n---\n")
  puts "OK    #{slug}.md (#{new_items.size} press items)"
end

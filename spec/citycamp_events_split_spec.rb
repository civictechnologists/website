require "jekyll"
require "timecop"
require "tmpdir"
require "fileutils"

RSpec.describe "citycamp upcoming/past events split" do
  Jekyll.logger.log_level = :error

  def build_site(today:)
    source = Dir.mktmpdir
    FileUtils.mkdir_p(File.join(source, "_citycamp"))
    FileUtils.mkdir_p(File.join(source, "_layouts"))
    FileUtils.mkdir_p(File.join(source, "_plugins"))

    File.write(File.join(source, "_layouts", "citycamp-city.html"), "---\n---\n{{ page.city }}")
    FileUtils.cp(
      File.join(__dir__, "..", "_plugins", "citycamp_latest_event.rb"),
      File.join(source, "_plugins", "citycamp_latest_event.rb")
    )
    FileUtils.cp(
      File.join(__dir__, "..", "_plugins", "current_date.rb"),
      File.join(source, "_plugins", "current_date.rb")
    )

    File.write(File.join(source, "_citycamp", "testville.md"), <<~MARKDOWN)
      ---
      layout: citycamp-city
      city: "Testville"
      country: "United States"
      latitude: 1.0
      longitude: 1.0
      events:
        - name: "Old Event"
          date: 2020-01-01
        - name: "Today Event"
          date: 2024-06-15
        - name: "Future Event"
          date: 2099-01-01
      ---
    MARKDOWN

    config = Jekyll.configuration(
      "source" => source,
      "destination" => File.join(source, "_site"),
      "collections" => { "citycamp" => { "output" => true, "permalink" => "/citycamp/:name" } }
    )

    site = Timecop.freeze(today) do
      site = Jekyll::Site.new(config)
      site.read
      site.render
      site
    end

    site.collections["citycamp"].docs.find { |doc| doc.data["city"] == "Testville" }
  ensure
    FileUtils.remove_entry(source) if source
  end

  it "splits events into upcoming and past relative to the current date" do
    doc = build_site(today: Date.new(2024, 6, 20))

    expect(doc.data["upcoming_events"].map { |e| e["name"] }).to eq(["Future Event"])
    expect(doc.data["past_events"].map { |e| e["name"] }).to eq(["Today Event", "Old Event"])
  end

  it "treats an event dated today as upcoming" do
    doc = build_site(today: Date.new(2024, 6, 15))

    expect(doc.data["upcoming_events"].map { |e| e["name"] }).to eq(["Today Event", "Future Event"])
    expect(doc.data["past_events"].map { |e| e["name"] }).to eq(["Old Event"])
  end

  it "sorts upcoming events soonest-first and past events most-recent-first" do
    doc = build_site(today: Date.new(2019, 1, 1))

    expect(doc.data["upcoming_events"].map { |e| e["name"] }).to eq(["Old Event", "Today Event", "Future Event"])
    expect(doc.data["past_events"]).to eq([])
  end
end

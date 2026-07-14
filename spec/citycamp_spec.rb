require "yaml"
require "date"

CITYCAMP_FILES = Dir.glob(File.join(__dir__, "../_citycamp/*.md"))

RSpec.describe "_citycamp pages" do
  it "has at least one city file" do
    expect(CITYCAMP_FILES).not_to be_empty
  end

  CITYCAMP_FILES.each do |file|
    describe File.basename(file) do
      subject(:frontmatter) do
        content = File.read(file)
        yaml = content.match(/\A---\n(.*?)^---/m)&.captures&.first
        YAML.safe_load(yaml, permitted_classes: [Date])
      end

      it "has a city" do
        expect(frontmatter["city"]).to be_a(String).and(satisfy { |v| !v.empty? })
      end

      it "has a country" do
        expect(frontmatter["country"]).to be_a(String).and(satisfy { |v| !v.empty? })
      end

      it "has a numeric latitude" do
        expect(frontmatter["latitude"]).to be_a(Numeric)
      end

      it "has a numeric longitude" do
        expect(frontmatter["longitude"]).to be_a(Numeric)
      end

      it "has no unrecognized top-level keys" do
        allowed = %w[city region country latitude longitude events press]
        extra = frontmatter.keys - allowed
        expect(extra).to be_empty, "unexpected keys: #{extra.join(", ")}"
      end

      describe "press" do
        let(:press) { frontmatter["press"] || [] }

        it "is an array" do
          expect(press).to be_an(Array)
        end

        it "each press item has required fields" do
          press.each_with_index do |item, i|
            aggregate_failures "press #{i + 1}" do
              expect(item["title"]).to be_a(String).and(satisfy { |v| !v.empty? })
              expect(item["website"]).to be_a(String).and(satisfy { |v| !v.empty? })
              expect(item["date"]).to be_a(Date) if item.key?("date")
              allowed = %w[title website date]
              extra = item.keys - allowed
              expect(extra).to be_empty, "unexpected keys: #{extra.join(", ")}"
            end
          end
        end
      end

      describe "events" do
        let(:events) { frontmatter["events"] || [] }

        it "is an array" do
          expect(events).to be_an(Array)
        end

        it "each event has required fields" do
          events.each_with_index do |event, i|
            aggregate_failures "event #{i + 1}" do
              expect(event["name"]).to be_a(String).and(satisfy { |v| !v.empty? })
              expect(event["date"]).to be_a(Date) if event.key?("date")
              allowed = %w[name date venue address website organizer organizer_website about]
              extra = event.keys - allowed
              expect(extra).to be_empty, "unexpected keys: #{extra.join(", ")}"
            end
          end
        end
      end
    end
  end
end

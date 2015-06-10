require 'beetrackapi'
require 'date'
require 'json'

RSpec.describe BeetrackAPI::Client, "#client" do

  context "export" do
    before :all do
      key = ENV['BEETRACK_API_KEY']
      if key.nil?
        raise "Must define BEETRACK_API_KEY environment variable"
      end
    end

    it "queues requests" do
      key = ENV['BEETRACK_API_KEY']
      client = BeetrackAPI::Client.new(
        key: key
      )
      params = {
        export_items: true,
        date: Date.today.prev_day
      }
      body = client.request_data_export(params)

      puts "Got body #{body}"

      # Check the response
      expect(body.nil?).to eq false
      expect(body['response'].nil?).to eq false
      expect(body['response']['id'].nil?).to eq false

      id = body['response']['id']

      # Wait for the url to be valid
      url = nil
      (1..10).each do |i|
        sleep(10 * i)
        body = client.get_data_export_status(id)
        expect(body.nil? || body['response'].nil?).to eq false
        url = body['response']['file_url']
        if !url.nil?
          break
        end
      end

      expect(url.nil?).to eq false
    end
  end
end

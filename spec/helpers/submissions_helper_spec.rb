require 'rails_helper'

RSpec.describe SubmissionsHelper, type: :helper do
  describe "URL hostname" do
    it "should extract the url host" do
      domain = Faker::Internet.domain_name
      expect(helper.get_host(Faker::Internet.url(host: domain))).to eq(domain)
    end
  end
end

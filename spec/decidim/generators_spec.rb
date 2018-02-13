# frozen_string_literal: true

require "spec_helper"

RSpec.describe Decidim::Generators do
  it "has a version number" do
    expect(Decidim::Generators::VERSION).not_to be nil
  end
end

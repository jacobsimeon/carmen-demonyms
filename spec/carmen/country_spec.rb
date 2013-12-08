require 'spec_helper'

describe Carmen::Country do
  describe "basic attributes" do
    before do
      @us = Carmen::Country.coded('us')
    end

    it "has a demonym" do
      expect(@us.demonym).to eq("American")
    end
  end
end

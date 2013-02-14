require "spec_helper"

describe ActiveRecord::ConnectionAdapters::VerticaAdapter do
  let(:connection) { ActiveRecord::Base.vertica_connection(TEST_CONNECTION_HASH) }

  describe "#initialize" do
    it "opens a connection" do
      connection.active?.should be_true
    end
  end

  describe "#quote_column_name" do
    it "quotes values" do
      connection.quote_column_name("column's").should == "\"column's\""
    end
  end
end

require "spec_helper"

describe ActiveRecord::Base do
  it "opens a connection" do
    connection = ActiveRecord::Base.vertica_connection(TEST_CONNECTION_HASH)
    connection.active?.should be_true
  end

  it "opens a connection using user or username" do
    connection_hash = TEST_CONNECTION_HASH
    connection_hash["username"] = TEST_CONNECTION_HASH["user"]
    connection_hash.delete("user")
    connection = ActiveRecord::Base.vertica_connection(TEST_CONNECTION_HASH)
    connection.active?.should be_true
  end
end

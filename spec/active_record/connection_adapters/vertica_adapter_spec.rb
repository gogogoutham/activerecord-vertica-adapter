require "spec_helper"

describe ActiveRecord::ConnectionAdapters::VerticaAdapter do
  let(:connection) { ActiveRecord::Base.vertica_connection(TEST_CONNECTION_HASH) }
  before(:all) do
    connection.query <<-sql
    CREATE TABLE public.test ( "id" INTEGER, "name" VARCHAR );
    CREATE TABLE public.test2 ( "id" INTEGER, "name" VARCHAR );
    INSERT INTO public.test VALUES (1, 'first');
    INSERT INTO public.test VALUES (2, 'second');
    CREATE SCHEMA test;
    CREATE TABLE test.test ( "id" INTEGER, "is" BOOL );
    CREATE TABLE test.test2 ( "id" INTEGER, "is" BOOL );
    sql
  end
  after(:all) do
    connection.query <<-sql
    DROP TABLE IF EXISTS public.test, public.test2, test.test, test.test2;
    DROP SCHEMA test;
    sql
  end

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

  describe "#tables" do
    it "returns all tables in public schema" do
      connection.tables("public").should == ["public.test", "public.test2"]
    end

    it "returns all tables in all schemas" do
      connection.tables.should == ["public.test", "public.test2", "test.test", "test.test2"]
      connection.tables(%w(public test)).should == ["public.test", "public.test2", "test.test", "test.test2"]
    end
  end

  describe "#columns" do
    it "returns all columns in table" do
      id = ActiveRecord::ConnectionAdapters::VerticaColumn.new("id", "", "int", false)
      is =  ActiveRecord::ConnectionAdapters::VerticaColumn.new("is", "", "boolean", false)
      connection.columns("test.test").should == [id, is]
    end

    it "returns all columns in table in public schema" do
      id = ActiveRecord::ConnectionAdapters::VerticaColumn.new("id", "", "int", false)
      name =  ActiveRecord::ConnectionAdapters::VerticaColumn.new("name", "", "varchar(80)", false)
      connection.columns("test").should == [id, name]
    end
  end

  describe "#table_exists?" do
    it "checks if table in schema exists" do
      connection.table_exists?("public.test").should be_true
    end

    it "checks if unknown table in schema doesn't exist" do
      connection.table_exists?("public.null").should be_false
    end

    it "checks if table in implied schema exists" do
      connection.table_exists?("test2").should be_true
    end
  end

  describe "#current_database" do
    it "returns current database" do
      connection.current_database.should == TEST_CONNECTION_HASH[:database]
    end
  end

  describe "#schema_search_path" do
    it "returns current database" do
      connection.schema_search_path.should == "public"
    end
  end

  describe "#update_sql" do
    it "returns the number of updated rows" do
      connection.update_sql("UPDATE public.test SET name = 'test'").should == 2
    end
  end

  describe "#quote_string" do
    it "quotes the string without surrouding quotes" do
      connection.quote_string("quote'd").should == "quote''d"
    end

    it "returns identical string when no quoting is required" do
      connection.quote_string("quote").should == "quote"
    end
  end
end

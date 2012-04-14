require 'spec_helper'

module UtopiaData
  describe Resource do
    before { load_defaults! }
    let(:application){ UtopiaData::Application.new }

    def config(options = {}, &block)
      @config ||= Resource.new(:lei, options, &block)
    end


    describe "#resource_table_name" do
      it "should return the resource's table name" do
        config.resource_table_name.should == '"leis"'
      end
      context "when the :as option is given" do
        it "should return the resource's table name" do
          config(:as => "Minhas Leis").resource_table_name.should == '"leis"'
        end
      end
    end

    describe "custom config" do
      let(:custom_config) do
        config do
          table_name "L123"
          attributes do
            set :name
          end
        end
      end

      it "should set table name to L123" do
        custom_config.model.table_name.should == 'L123'
      end

      it "should set columns only with name" do
        custom_config.columns.should == [:name]
      end
    end

    describe "controller name" do
      it "should return a namespaced controller name" do
        config.controller_name.should == "LeisController"
      end
    end
  end
end
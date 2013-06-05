class Salesperson < Struct.new(:name, :type, :left, :right, :manager)

  def success_rate
    if type == :sociopath
      return 0.85
    end
    if type == :clueless
      if manager && manager.type == :sociopath
        return 0.65
      else
        return 0.45
      end
    end

  end

end

require "minitest/autorun"

describe Salesperson do

  describe "success rate" do

    def make_sociopath
      Salesperson.new("john", :sociopath, nil, nil, nil)
    end

    it "should always be 0.85 for sociopaths" do
      sociopath = make_sociopath
      assert_equal sociopath.success_rate, 0.85
    end

    describe "clueless" do

      def make_clueless_with_manager(manager)
        Salesperson.new("george", :clueless, nil, nil, manager)
      end

      it "should be 0.65 if they are managed by a sociopath" do
        assert_equal make_clueless_with_manager(make_sociopath()).success_rate, 0.65
      end

      it "should be 0.45 if they are not managed" do
        assert_equal make_clueless_with_manager(nil).success_rate, 0.45
      end

      it "should be 0.45 if they are managed by another clueless" do
        assert_equal make_clueless_with_manager(make_clueless_with_manager(nil)).success_rate, 0.45
      end

    end

  end

end

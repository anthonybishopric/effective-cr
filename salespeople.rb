class Salesperson

  attr_accessor :name, :left, :right, :manager

  def initialize(name)
    @name = name
    @manager = nil
    @left = nil
    @right = nil
  end

  def left= salesperson
    @left = salesperson
    @left.manager = self
  end

  def right= salesperson
    @right = salesperson
    @right.manager = self
  end

end

class Sociopath < Salesperson

  def success_rate
    0.85
  end

end

class Clueless < Salesperson

  def success_rate
    manager && manager.class == Sociopath ? 0.65 : 0.45
  end

end

class Loser < Salesperson

  def success_rate
    if manager && manager.class == Loser
      manager.success_rate / 2.0
    else
      0.02
    end
  end

end

require "minitest/autorun"

describe Salesperson do

  def make_sociopath
    Sociopath.new "Sam"
  end

  def make_clueless_with_manager(manager)
    salesperson_with_manager Clueless.new("Carl"), manager
  end

  def make_loser_with_manager(manager)
    salesperson_with_manager Loser.new("Lars"), manager
  end

  def salesperson_with_manager(salesperson, manager)
    manager && manager.left = salesperson
    salesperson
  end

  describe Sociopath do

    describe "success rate" do

      it "should always be 0.85" do
        sociopath = make_sociopath
        assert_equal make_sociopath.success_rate, 0.85
      end

    end

    it "should have the right name" do
      assert_equal make_sociopath.name, "Sam"
    end

  end

  describe Clueless do

    describe "success rate" do

      it "should be 0.65 if they are managed by a sociopath" do
        assert_equal make_clueless_with_manager(make_sociopath()).success_rate, 0.65
      end

      it "should be 0.45 if they are not managed" do
        assert_equal make_clueless_with_manager(nil).success_rate, 0.45
      end

      it "should be 0.45 if they are managed by another clueless" do
        clueless_who_is_a_manager = make_clueless_with_manager(nil)
        assert_equal make_clueless_with_manager(clueless_who_is_a_manager).success_rate, 0.45
      end

    end

    it "should have the right name" do
      assert_equal make_clueless_with_manager(nil).name, "Carl"
    end

  end

  describe Loser do

    describe "success rate" do

      it "should be 0.02 if they are unmanaged" do
        assert_equal make_loser_with_manager(nil).success_rate, 0.02
      end

      it "should be 0.02 if they have a clueless manager" do
        assert_equal make_loser_with_manager(make_clueless_with_manager(nil)).success_rate, 0.02
      end

      it "should be 0.01 if they are managed by a loser" do
        loser_who_is_a_manager = make_loser_with_manager(nil)
        assert_equal make_loser_with_manager(loser_who_is_a_manager).success_rate, 0.01
      end

      it "should be 0.005 if they are managed by a loser who is in turn managed by another loser" do
        loser_who_is_the_top_manager = make_loser_with_manager(nil)
        loser_who_is_the_middle_manager = make_loser_with_manager(loser_who_is_the_top_manager)
        assert_equal make_loser_with_manager(loser_who_is_the_middle_manager).success_rate, 0.005
      end

    end

    it "should have the right name" do
      assert_equal make_loser_with_manager(nil).name, "Lars"
    end

  end

end

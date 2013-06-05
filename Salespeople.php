<?php

class SalesHierarchy
{
	public static function build($sales_hierarchy_string)
	{
		// implement me!
	}

	private $root;

	public function __construct(Salesperson $root)
	{
		$this->root = $root;
	}

	public function assign_to_best_rep(Lead $lead)
	{
		$rep = $this->root->get_best_sales_rep($lead);
		$rep->set_current_lead($lead);
	}

	public function total_risk()
	{
		return $this->root->total_risk_incurred();
	}
}

abstract class Salesperson
{
    protected $name;

	/**
	* @var Salesperson
	*/
	protected $right = null;

	/**
	* @var Salesperson
	*/
	protected $left = null;

    /**
     * @var Salesperson
     */
    protected $manager = null;

    public function __construct($name)
    {
        $this->name = $name;
    }

    public function name()
    {
        return $this->name;
    }

	public function left()
	{
		return $this->left;
	}

	public function right()
	{
		return $this->right;
	}

    public function manager()
    {
        return $this->manager;
    }

    public function set_manager(Salesperson $person)
    {
        $this->manager = $person;
    }

	public function set_right(Salesperson $person)
	{
		$this->right = $person;
        $person->set_manager($this);
	}

	public function set_left(Salesperson $person)
	{
		$this->left = $person;
        $person->set_manager($this);
	}

	/**
	* @return double a value between 0 and 1 that represents the
	* rate of success this salesperson has with deals.
	*/
	protected abstract function success_rate();

	protected function can_take_lead(Lead $lead)
	{
		// tip: you may want to override this function in one of the subclasses.
		return true;
	}

	public function get_best_sales_rep(Lead $lead, Salesperson $winner_so_far = null)
	{
		// implement me!
	}

	public function total_risk_incurred()
	{
		// implement me!
	}

	/**
	* @return calculates the risk that the company takes on given
	* the #{success_rate()} of the Salesperson
	*/
	public function risk(Lead $lead)
	{
		return $lead->value() * (1 - $this->success_rate());
	}

}

class Sociopath extends Salesperson
{
	public function success_rate()
	{
		return 0.85;
	}

}

class Clueless extends Salesperson
{
	public function success_rate()
	{
		if (is_a($this->manager, "Sociopath"))
        {
            return 0.65;
        }

        return 0.45;
	}
}

class Loser extends Salesperson
{
	public function success_rate()
	{
		if (is_a($this->manager, "Loser"))
        {
            if (is_a($this->manager->manager, "Loser"))
            {
               return 0.05;
            }

            return 0.1;
        }

        return 0.2;
	}
}

class Lead
{
	private $name;
	private $value;

	public function __construct($name, $value)
	{
		$this->name = $name;
		$this->value = $value;
	}

	public function value()
	{
		return $this->value;
	}
}
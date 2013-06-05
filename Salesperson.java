abstract class Salesperson
{
	
	private String name;
	protected Salesperson left = null;
	protected Salesperson right = null;
	protected Salesperson parent = null;	
	
	public Salesperson(){}
	public Salesperson left()
	{
		retuen this.left;
	}
	
	public Salesperson right()
	{
		return this.right;
	}
	
	public setLeft(Salesperson left)
	{
		this.left = left;
	}

	public setRight(Salesperson right)
	{
		this.right = right;
	}

	protected double success_rate(){}


}

class Sociapath extends Salesperson
{
	public double success_rate()
	{
		return 0.85;
	}			
}
class Clueless extends Salesperson
{
	public double success_rate()
	{	
		if(this.parent instanceOf Sociapath)
			return 0.65;
		else
			return 0.45;	
	}
		
}
class Loser extends Salesperson
{
	public double success_rate()
	{
		if(this.parent == null)
			return 0.02;
		else
			return this.parent.success_rate()/2;
}	


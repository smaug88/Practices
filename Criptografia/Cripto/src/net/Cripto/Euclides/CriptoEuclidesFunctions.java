package net.Cripto.Euclides;

public class CriptoEuclidesFunctions
{
	public static int a_Euclides(int a, int b)
	{
		if (a <= 0)
			return b;
		while (b != 0)
		{
			if (a > b)
				a = a-b;
			else
				b = b-a;	
		}
		return a;
	}

	public static int[] ea_Euclides(int a, int b)
	{
		int[] solution = new int[3];
		if(b<=0)
		{
			solution[0] = a;	
			solution[1] = 1;	
			solution[2] = 0;
		}		
		else
		{
			int s2 = 1, s1 = 0, s = 0;
			int t2 = 0, t1 = 1, t = 0;
			int q = 0, r = 0;
			while(b>0)
			{
				q = (a/b);
				r = a-q*b;
				s = s2-q*s1;
				t = t2-q*t1;
				a = b;
				b = r;
				s2 = s1;
				s1 = s;
				t2 = t1;
				t1 = t;
			}
			solution[0] = a;
			solution[1] = s2;
			solution[2] = t2;
		}
		return solution;
	}

	public static int MOD_MULT_Inverse(int a, int b)
	{
		int[] EA_Solution = ea_Euclides(a, b);
		if(EA_Solution[0] == 1)
		{
			return EA_Solution[1];
		}
		else
		{
			return -1;
		}
	}
}
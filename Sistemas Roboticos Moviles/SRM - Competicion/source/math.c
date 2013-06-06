#include <math.h>

float puiss(float nb, int deg)
{
  int i;
  float total=1;
  for(i=0; i<deg; i++)
  {
    total=total*nb;
  }
  return total;
}

int factor(int n)
{
  int i;
  int total=1;
  for(i=1; i<=n; i++)
    total=total*i;
  return total;
}

float sin(float xa)
{
  int i;
  float total=0;
  for(i=0; i<3; i++)
    total=total+( puiss(-1, i)*(puiss(xa, 2*i+1)))/factor(2*i+1);
  return total;
}

float cos(float xa)
{
  return (1-2*puiss(sin(xa/2), 2));
}



import java.util.Scanner;
public class ComputeTeams {
    public int [] weights;
    private int numberChildren;
     public ComputeTeams(int nChildren, int weightMax)
    {
        numberChildren = nChildren;
    }
    
    public int[] readWeights(Scanner in)
    {  
        weights = new int [numberChildren];
        for (int i = 0; i < weights.length; i++)
        {
            weights[i] = in.nextInt();
        }
        return weights;
    }
     public int findMinRec(int arr[], int i, int sumCalculated, int sumTotal) 
	{ 
                int result = arr.length;
                int table[][] = new int[result][i];
                //base case
                if (i == 0)
                {
                    return Math.abs((sumTotal-sumCalculated) - sumCalculated);
                }
                
                if (i < weights[i - 1])
                {
                    if(table[i][i - 1] == 0)
                    {
                        table[i][i - 1] = findMinRec(arr, i - 1, result, sumTotal);
                    }
                    return Math.abs((sumTotal - result) - result - i);
                } 
                else
                {
                    if (table[i - 1][i - 1] == 0)
                    {
                        table[i - 1][i - 1] = findMinRec(arr, i - 1, result, sumTotal);
                    } 
                    if (table[i - arr[i - 1]][i - 1] == 0)
                    {
                        table[i - arr[i - 1]][i - 1] = findMinRec(arr, i - 1, result, sumTotal);
                    }
                }
                return Math.min(findMinRec(arr, i - 1, sumCalculated + arr[i-1], sumTotal), findMinRec(arr, i-1,sumCalculated, sumTotal)); 
        } 
	 
	public int findMin(int arr[], int n) 
	{  
		int sumTotal = 0; 
		for (int i = 0; i < n; i++) 
			sumTotal += arr[i]; 
		return findMinRec(arr, n, 0, sumTotal); 
	} 
}

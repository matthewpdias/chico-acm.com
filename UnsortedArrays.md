#Unsorted Arrays

---

We describe an array as sorted if, for every integer __*A<sub>i</sub>*__ in the array, the following element __*A<sub>i + 1</sub>*__ is larger, or doesn't exist.

For this problem, we will define any position in the array where the above property doesn't hold as a sorting error.


Given an array __*A*__ containing __*n*__ distinct integers in an unknown order, and a error goal __*e*__, reorder the array so that it has exactly __*e*__ sorting errors.

*Note*: It's possible that multiple valid solutions exist.

##Input Format

The first line contains an integer __*n*__, the number of values in the array, and an integer __*e*__, the error goal, separated by a space.

The second line contains __*n*__ space-separated integers describing the values of the elements of the array, __*A<sub>0</sub>, A<sub>1</sub>,..., A<sub>n - 1</sub>*__

##Constraints

- 1 ≤  __*n*__ ≤ 10<sup>5</sup>
- 0 ≤  __*e*__ ≤ n - 1
- 1 ≤  __*A<sub>i</sub>*__ ≤ 10<sup>9</sup>
- All __*A<sub>i</sub>*__ are distinct.

##Output Format

Print a reordering of the original array that contains exactly __*e*__ errors.

###Sample Input
```
10 3
5 3 2 10 16 67 11 8 100 75
```

###Sample Output
```
2 3 8 5 11 10 67 16 75 100
```
###Explanation

The output contains the same values as the original array, and is sorted except for 3 errors, 8 > 5, 11 > 10, and 67 > 16.


---


##Walkthrough

Because the initial state of the array is unknown, we likely want to sort the array, even though the solution we want will not actually be sorted. We can start therefore with a simple std::sort.

After sorting the array we need to introduce the errors in the sorting. A naive look at the sample given might suggest that we can simply swap adjacent elements enough times to introduce the needed errors. However consider the following sorted array, followed by swaps,

```
1 2 3 4 5
``` 
```
1 2 4 3 5  
```  
```  
1 4 2 3 5  
```  

Even after performing two swaps, only one error is introduced, because we only moved the 4 two times. 
This problem could be removed by only swapping on every other index, such as in the sample, however this leads to another problem. The number of errors needed could be as large as n - 1. If we swap only every other index, only half that number of errors is possible. Therefore another solution is needed.


We can begin inserting the largest elements at the start of the array, ensuring an error for every such element inserted. For example to generate three errors on the above example we would do the following
``` 
1 2 3 4 5 
```
```
5 1 2 3 4 
```
``` 
5 4 1 2 3
```
```
5 4 3 1 2
```

This algorithm is valid and will generate the correct output, but it does have a problem. When we move an element to the front of the array, the remaining elements need to be shifted down, an O(n) operation. In the worst case, the number of errors needed would be n - 1, meaning we would have to do n - 1 insertions. Therefore our full solution will be O(n<sup>2</sup>) which is worse than we would like. 

One way to alleviate this problem is to instead do insertions into a new array. By copying the data over, we avoid shifting at all. Reducing this portion of the algorithm to O(n), although the full algorithm is still O(n log(n)), from the sort. However this solution would cause the algorithm to use an extra array increasing the memory usage unnecessarily.


A third solution can perform better than both of these. Instead of creating errors by inserting elements, notice that the maximum errors that an array can have comes from being in reversed order. This is somewhat intuitive, as a reversed list is as far from being sorted as possible. We can take advantage of this be reversing only a subarray, to generate the exact number of errors needed. For example,
```
1 2 3 4 5
```
```
1 5 3 4 2
```
```
1 5 4 3 2
```
Each step in a reversal only requires a swap, rather than a shift, so reversing is only an O(n) operation in the worst case, and takes constant memory. 

With this improvement our final anaylsis shows that our algorithm has a sort that is O(n log(n)) and a reversal that is O(e), e being the number of errors. Because we know the number of errors is always less than the number of elements in the array, we can conclude that the runtime of the whole algorithm is O(n log(n)).


---


##Full Solution

```cpp
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;


int main()
{
  unsigned int n;
  unsigned int e;
  cin >> n >> e;
  vector<unsigned int> arr(n);
  for(unsigned int i = 0; i < n; i++)
  {
    cin >> arr[i];
  }
  sort(arr.begin(), arr.end());
  reverse(arr.end() - e - 1, arr.end());
  for(unsigned int i = 0; i < n; i++)
  {
    cout << arr[i] << " ";
  }
  cout << endl;
}
```

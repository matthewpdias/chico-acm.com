# Discussion of [Non-Divisible Subset](https://www.hackerrank.com/challenges/non-divisible-subset/problem)
<br>
## Problem Statement:
Given a set, `S`, of  distinct integers, print the size of a maximal subset, `S'`, of `S` where the sum of any `2` numbers in `S'` is **not** evenly divisible by `k`.

**Input Format**

The first line contains `2` space-separated integers, `n` and `k`, respectively. 
The second line contains `n` space-separated integers (we'll refer to the `i-th` value as `ai`) describing the unique values of the set.

**Constraints**

* `1 <= n <= 10^5`
* `1 <= k <= 100`
* `1 <= ai <= 10^9`

All of the given numbers are distinct.

**Output Format**

Print the size of the largest possible subset (`S'`).

---

**Example Input 1**

```
4 3
1 7 2 4
```

**Expected Output 1**

```
3
```

**Example Input 2**
```
7 6
19 17 12 1 27 3 4
```

**Expected Output 2**
```
5
```

---

**Walkthrough**

Our task is to find the _size_ of the largest subset (not the elements in the subset) of `S` such that no two elements in the subset can be added together to form a number that is perfectly divisible by `k`.

As we prepare to process all of the elements in `S`, it is important to note that the magnitude of each number does not matter because we are only concerned with how much needs to be added to each number before it becomes divisible by `k`.  For example, if `k = 5` and `S = {6, 4, 10004}`, it doesn't matter if we add `6` to `4` or `10004`, in both cases the sum will be divisible by `5`.  What matters here is _how much_ can be added to each number before it becomes divisible by `5`.  We obtain this information using the modulo operator (%), which returns the remainder of a division operation.  Any two numbers whose remainders sum up to `k` will sum up to a number divisible by `k` themselves.  Continuing with our example, if we perform `e % k` for each element `e` in `S`, we get `Srem = {1, 4, 4}`.  `Srem` shows us that we have two elements in `S` which are "1 away" from `5`, and one element in `S` that is "4 away" from `5`.  So our subset for this example can contain either both of the elements with remainder 4, or the one element with remainder 1; because we are trying to maximize the number of elements in our subset, we want to pick the two elements that with remainder 4.

In fact this strategy is the key to solving the problem: essentially all we do is find out how many elements have remainder `r` where `0 <= r < k` and then for each pair of complementing remainders (sum to `k`), we choose the remainder with more elements belonging to it.

In order to keep track of how many elements in `S` have a certain remainder when divided by `k`, we maintain an array, `mods[]`, of length `k`.  We then iterate through each element, `e`, in `S` and increment `mods[e % k]`.  We can now lookup how many elements in `S` have remainder `r` when divided by `k` simply by retrieving the value located at `mods[r]`.

Here's what it looks like to create this array for our example inputs:

**Ex1:**

n = 4<br>
k = 3

![Ex1 create mods array](/images/ex1CreateMods.png)

**Ex2:**

n = 7<br>
k = 6

![Ex2 create mods array](/images/ex2CreateMods.png)

Once we have our `mods[]` array, we must use it to find each pair of complementing remainders and choose the remainder with more elements to add to our subset.  For an index `i` in `mods[]` (remember that the indices are equal to the remainders) where `i <= floor(k/2)`, complement, `i'`, will be located at `k - i`.  For example, if `k` is 9, 1's complement is 8, 2's complement is 7, 3's complement is 6, and so on.  This means we can "work our way inward" as we iterate through our array.

The first edge case we must consider is for elements that have a remainder of `0`, meaning they are perfectly-divisible by `k` already.  We can have **at most one** element that is perfectly divisible by `k` in our subset because the only complement to a perfect dividend is another perfect dividend.

Here we see what it looks like to scan `mods[]` in order to find out the `max` number of elements that can exist in our subset:

**Ex1:**

![Ex1 get maximum](/images/ex1GetMax.png)

The second edge case occurs when `k` is even and `S` contains more than one element with a remainder equal to exactly half of `k`.  If `k` is even, then elements with remainders equal to half of `k` can be added together to produce a number that is perfectly-divisible by `k`.  Just like remainders of `0`, remainders of this sort are their own complements, so we may have **at most one** element in our subset that is equal to `k/2` when `k` is even.

This is demonstrated in the second example input:

**Ex2:**

![Ex2 get maximum](/images/ex2GetMax.png)

---

## Full solution:

```
#include <iostream>
#include <cstring>

using namespace std;

int main() {
    int n, k;
    cin >> n >> k;

    // Array to contain number of modulo value occurrences
    int mods[k];
    memset(mods, 0, sizeof(mods));

    int s;
    for(int i=0; i<n; i++) {
        cin >> s;
        // Increment occurrence of modulo (indexed by modulo value)
        ++mods[s % k];
    }

    int opt = 0;
    for(int i=0; i*2 <= k; i++) {
        if(i == (k-i)%k)
            // Choose either 0 or 1 number perfectly-divisible by k (i == 0) OR
            // a number perfectly-divisible by half of k (i == k/2 && k % 2 == 0)
            opt += min(mods[i], 1);
        else
            opt += max(mods[i], mods[(k-i)%k]);
    }

    cout << opt << endl;

    return 0;
}
```
---
title: Cyclomatic Complexity
layout: post
type: post

---

I stumbled upon the concept of cyclomatic complexity a while back. It's a very useful metric that has been around since 1976 when **Thomas J McCabe** wrote a paper about it.  That paper, entitled _A Complexity Measure_,  is an easy read, as far as papers are concerned, weighing in at only 13 pages and fluffed up with many graphs.  If you've always told yourself, _hey I should read a technical paper once in a while_, I encourage you to give this one a go.

In brief, cyclomatic complexity is simply the amount of paths that you can traverse a function from beginning to end. If you have a function with an if block then there are two paths in that function.  **(1)** the path where you go in the if block and **(2)** the path where you don't enter the if block.

<img src="/images/cyclocomplex2.png">

The more conditional blocks and loops you have in a method the more combinations of paths there are from begin to end. If you want to fully test your code you need to make sure that all possible paths have been traversed. This is subtly different than making sure your tests cover every line.

The example in the previous image contains a bug to highlight the difference between statement coverage and branch coverage. If **condition==true** the code works fine, however, **condition==false** causes a null pointer exception during the return statement. 

If you want 100% test coverage for a critical piece of code you need to have a test for each potential path through that module. The cyclomatic complexity metric will give you a number that is equivalent to the number of paths that exist in your code module. If a function has a cyclomatic complexity of 4 then you will need four tests to fully test it.  The higher this number the more complex the code.  Generally numbers above 10 are consider overly complex and a candidate to be broken down into smaller chunks.


McCabe's paper takes the possible control flow of a program and displays it as a directed graph. The image below is a reproduction of the legend for common control mechanisms found in his original paper.

<img src="/images/cyclographs.jpg">

The legend contains enough information to represent any function as a graph. So if you ever inherit some complex code that you need to test simply draw out the control flow graph on a piece of paper.  Every possible path from the start to end state is a test you need to write if you're looking to test 100% of a function. 

When I first found out about this metric I was so inspired I wanted to write a plugin for my IDE that would represent it. Maybe even generate the control graph and link it to line numbers in the editor. Luckily I was lazy and eventually realized this, new to me metric, isn't new at all (going on forty years), and there are plenty of tools out there that will quickly calculate cyclomatic complexity for you.

For Java, **JavaNCSS** is one of many programs that can calculate the cyclomatic metric for you. Simply give it the -function option; the **CCN** column stands for **Cyclomatic Complexity Number**

<img src="/images/cyclojavancss.png">

Most software metric tools report on cyclomatic complexity.  It's easy to calculate and quite useful, although it doesn't make writing tests any easier. 

## References

- [In pursuit of code quality: Monitoring cyclomatic complexity][IBM]
- [Cyclomatic complexity][wiki]
- [JavaNCSS A Source Measurement Suite for Java][javancss]

[IBM]: http://www.ibm.com/developerworks/java/library/j-cq03316/
[wiki]: http://en.wikipedia.org/wiki/Cyclomatic_complexity
[javancss]: http://javancss.codehaus.org

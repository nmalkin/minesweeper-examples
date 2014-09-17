Minesweeper Examples
===========

This are reference implementations of the [Minesweeper Square Challenge](http://minesweeper.nm.io/)

They all output the same interface and implement a simple solver that tries to randomly guess where all the open coordinates are.

How to run
---------

To run any of these solvers you just need to execute the scripts without arguments. For example for Python and Ruby:

```
$ python python-solver.py
# Starting new Game
 Random Guess: (5,0): 0
 Random Guess: (0,1): 0
 Random Guess: (2,1): 1
 Random Guess: (4,2): 1
 Random Guess: (5,4): 0
 Random Guess: (3,3): 1
 Random Guess: (3,2): lost
 Final board:

? ? ? ? ? 0
0 ? 1 ? ? ?
? ? ? ? 1 ?
? ? ? 1 ? ?
? ? ? ? ? 0
? ? ? ? ? ?

Final Results: 0 Wins, 1 Losses

$ ruby ruby-solver.rb
# Starting new Game
Random Guess: (2,2): 1
Random Guess: (0,2): 1
Random Guess: (3,3): 0
Random Guess: (3,1): 0
Random Guess: (1,3): 1
Random Guess: (0,1): 1
Random Guess: (1,5): lost
Final board:

 ? 1 1 ? ? ?
 ? ? ? 1 ? ?
 ? ? 1 ? ? ?
 ? 0 ? 0 ? ?
 ? ? ? ? ? ?
 ? ? ? ? ? ?

Final Results: 0 Wins, 1 Losses
```

What to change
---------

There are three main things that you should change in these examples:

 - The name of the game:
  ```solver = PythonSolver("diogo@squareup.com") # XXX: Replace this with your own unique name```
 - The method that executes your logic:
  ```solver_alg = solver.random_solve # XXX: Replace this with your own solver method```
 - The total number of games per execution
  ```GAMES = 1 # XXX: replace this with the number of games that you want to play```


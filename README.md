sudoku-solver
=============

A little sudoku solver using JavaFX for GUI and SWI-Prolog for AI.

Running
=============

Windows
-------------
you need compile sources and place them in same structure:
 
```
out/
    artifacts /
        run.bat
        bin /
            sudoku.pl          - sudoku.pl root dir
            sudoku-solver.jar  - compiled sources (with controlsfx-8.0.5.jar included in jar)
            swipl /
                ...
                swi-prolog installation files
                ...
```
Than you need to run [out/artifacts/run.bat](https://github.com/zlumyo/sudoku-solver/blob/master/out/artifacts/run.bat "run.bat").

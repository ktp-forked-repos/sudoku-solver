@echo off
cd /D %~dp0bin
set PATH=%PATH%;%cd%\swipl\bin;%cd%\swipl\lib;%cd%\swipl\library
java -classpath "swipl\lib\jpl.jar;sudoku-solver.jar" sudoku.solver.SudokuSolver
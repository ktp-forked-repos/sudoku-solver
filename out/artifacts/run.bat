cd /D %~dp0\bin
set PATH=%PATH%;%cd%\swipl\bin;%cd%\swipl\lib;%cd%\swipl\library
echo %PATH%
java -classpath "swipl\lib\jpl.jar;sudoku-solver.jar" sudoku.solver.SudokuSolver
package sudoku.solver;

import jpl.*;

/**
 * Realizes interaction with SWI-Prolog.
 * @author Владимир
 */
public class SudokuModel {
    
    public SudokuModel() throws JPLException {
        String t = "consult('sudoku.pl')";
        Query q = new Query(t);

        if (!q.hasSolution()) {
            throw new JPLException("There is no file 'sudoku.pl'!");
        }
    }
    
    public int[][] solve(int[][] cells) {
        Query q = new Query("sudoku(" + buildMatrix(cells) + ", Result)");      
        return (int[][])q.getSolution().get("Result");
    }
    
    private String buildMatrix(int[][] cells) {
        String result = "[";
        
        for (int[] i : cells) {
            result += buildList(i) + ",";
        }
        
        return result + "]";
    }
    
    private String buildList(int[] line) {
        String result = "[";
        
        for (int i : line) {
            result += i + ",";
        }
        
        return result + "]";
    } 
}

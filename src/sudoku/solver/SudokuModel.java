package sudoku.solver;

import jpl.*;
import java.util.*;

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
        
        Term[] rows = Util.listToTermArray((Term)q.oneSolution().get("Result"));
        int[][][] matrix = new int[rows.length][rows.length][];
        for (int i = 0; i < rows.length; ++i) {
            Term[] temp = Util.listToTermArray(rows[i]);
            for (int j = 0; j < temp.length; ++j) {
                Term[] tempTerm = Util.listToTermArray(temp[j]);
                int[] temp2 = new int[tempTerm.length];
                
                for (int k = 0; k < tempTerm.length; ++k) {
                    temp2[k] = tempTerm[k].intValue();
                }
                        
                matrix[i][j] = temp2;
            }
        }
        
        return new int[][] {};
    }
    
    private String buildMatrix(int[][] cells) {
        StringBuilder result = new StringBuilder("[");
        
        List<String> strList = new ArrayList<>();
        for (int[] i : cells) {
            strList.add(buildList(i));
        }
        
        result.append(String.join(",", strList));
        
        result.append("]");
        
        return result.toString();
    }
    
    private String buildList(int[] line) {
        StringBuilder result = new StringBuilder("[");
        
        List<String> intList = new ArrayList<>();
        for (int i : line) {
            intList.add(String.valueOf(i));
        }     
  
        result.append(String.join(",", intList));
        
        result.append("]");
        
        return result.toString();
    } 
}

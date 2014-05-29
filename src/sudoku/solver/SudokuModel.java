package sudoku.solver;

import jpl.*;

import java.lang.Integer;
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
    
    public List<List<List<Integer>>> solve(int[][] cells) {
        Query q = new Query("sudoku(" + buildMatrix(cells) + ", Result)");
        
        Term[] rows = Util.listToTermArray((Term)q.oneSolution().get("Result"));
        List<List<List<Integer>>> matrix = new ArrayList<>();
        for (int i = 0; i < rows.length; ++i) {
            Term[] temp = Util.listToTermArray(rows[i]);
            matrix.add(new ArrayList<>());
            for (int j = 0; j < temp.length; ++j) {
                Term[] tempTerm = Util.listToTermArray(temp[j]);
                List<Integer> temp2 = new ArrayList<>();
                
                for (int k = 0; k < tempTerm.length; ++k) {
                    temp2.add(tempTerm[k].intValue());
                }
                        
                matrix.get(i).add(temp2);
            }
        }
        
        return matrix;
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

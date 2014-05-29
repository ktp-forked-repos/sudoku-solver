package sudoku.solver;

import fxsolver.FxSolver;
import javafx.application.Application;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import org.controlsfx.dialog.Dialogs;


/**
 * Main application class.
 * @author Владимир
 */
public class SudokuSolver extends Application {
    
    private SudokuModel model = new SudokuModel();
    private GridPane sudokuTable;
    private final int[][] initsudoku1 = {
            {1,0,0,8,9,4,3,2,7},
            {9,2,8,7,3,1,4,5,6},
            {4,7,3,2,6,5,9,1,8},
            {3,6,0,4,1,7,8,9,5},
            {7,8,9,3,5,2,6,4,1},
            {5,1,4,0,8,6,2,7,3},
            {8,3,1,5,4,9,7,6,2},
            {6,0,7,0,2,3,5,8,4},
            {2,4,0,6,7,0,1,3,0}
    };
    
    @Override
    public void start(Stage primaryStage) {
        Button btn = new Button();
        btn.setText("Solve sudoku");
        btn.setOnAction((ActionEvent event) -> {
            Dialogs msgBox = Dialogs.create();
            msgBox.title("Message");
            msgBox.masthead("Sudoku solution");        
            
            int[][] cells = new int[9][9];
            
            for (int i = 0; i < 9; ++i) {
                for (int j = 0; j < 9; ++j) {
                    ComboBox tempBox = (ComboBox)getNodeByRowColumnIndex(i, j);
                    cells[i][j] = (int)tempBox.getValue();
                }
            }

            model.solve(cells);
            if (util(cells)) {
                for (int i = 0; i < 9; ++i) {
                    for (int j = 0; j < 9; ++j) {
                        ComboBox tempBox = (ComboBox)getNodeByRowColumnIndex(i, j);
                        tempBox.setValue(cells[i][j]);
                    }
                }
                
                msgBox.message("Solution was found!");
                msgBox.showInformation();
            } else {
                msgBox.message("There is no solution!");
                msgBox.showInformation();
            }
        });
 
        sudokuTable = new GridPane();
        sudokuTable.setAlignment(Pos.CENTER);
        sudokuTable.setHgap(5);
        sudokuTable.setVgap(5);
        
        for (int i = 0; i < 9; ++i) {
            for (int j = 0; j < 9; ++j) {
                ComboBox tempBox = new ComboBox();
                tempBox.getItems().addAll(
                    0,
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7,
                    8,
                    9
                );
                tempBox.setValue(initsudoku1[i][j]);
                sudokuTable.add(tempBox, i, j);
            }
        }
        
        VBox vbox = new VBox(sudokuTable, btn);
        vbox.setAlignment(Pos.CENTER);
        vbox.setPadding(new Insets(10));
        vbox.setSpacing(10);
        
        StackPane root = new StackPane(vbox);
        root.setAlignment(Pos.CENTER);     
        
        Scene scene = new Scene(root, 640, 480);
        
        primaryStage.setTitle("Sudoku solver");
        primaryStage.setScene(scene);
        primaryStage.setResizable(false);
        primaryStage.show();
        
//        try {
//            this.model = new SudokuModel();
//        } catch (JPLException ex) {
//            Dialogs msgBox = Dialogs.create();
//            msgBox.title("Message");
//            msgBox.message(ex.getMessage());
//            msgBox.masthead("Error");
//            msgBox.showInformation();
//        }
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        launch(args);
    }
    
    public static boolean util(int[][] cells) {
        return FxSolver.solve(cells);
    }
    
    public Node getNodeByRowColumnIndex(final int column, final int row) {
        Node result = null;
        ObservableList<Node> childrens = sudokuTable.getChildren();
        for(Node node : childrens) {
            if(sudokuTable.getRowIndex(node) == row && sudokuTable.getColumnIndex(node) == column) {
                result = node;
                break;
            }
        }
        return result;
    }
}

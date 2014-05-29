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
import jpl.*;

import java.lang.Integer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


/**
 * Main application class.
 * @author Владимир
 */
public class SudokuSolver extends Application {
    
    private SudokuModel model = null;
    private GridPane sudokuTable;
    ComboBox templateselectioncombobox = new ComboBox();
    private final int[][][] initsudoku = {
            {
                    {1,0,0,8,9,4,3,2,7},
                    {9,2,8,7,3,1,4,5,6},
                    {4,7,3,2,6,5,9,1,8},
                    {3,6,0,4,1,7,8,9,5},
                    {7,8,9,3,5,2,6,4,1},
                    {5,1,4,0,8,6,2,7,3},
                    {8,3,1,5,4,9,7,6,2},
                    {6,0,7,0,2,3,5,8,4},
                    {2,4,0,6,7,0,1,3,0}
            },
            {
                    {1,0,0,8,0,4,0,0,0},
                    {0,2,0,0,0,0,4,5,6},
                    {0,0,3,2,0,5,0,0,0},
                    {0,0,0,4,0,0,8,0,5},
                    {7,8,9,0,5,0,0,0,0},
                    {0,0,0,0,0,6,2,0,3},
                    {8,0,1,0,0,0,7,0,0},
                    {0,0,0,1,2,3,0,8,0},
                    {2,0,5,0,0,0,0,0,9}
            },
            {
                    {0,0,2,0,3,0,1,0,0},
                    {0,4,0,0,0,0,0,3,0},
                    {1,0,5,0,0,0,0,8,2},
                    {0,0,0,2,0,0,6,5,0},
                    {9,0,0,0,8,7,0,0,3},
                    {0,0,0,0,4,0,0,0,0},
                    {8,0,0,0,7,0,0,0,4},
                    {0,9,3,1,0,0,0,6,0},
                    {0,0,7,0,6,0,5,0,0}
            },
            {
                    {1,0,0,0,0,0,0,0,0},
                    {0,0,2,7,4,0,0,0,0},
                    {0,0,0,5,0,0,0,0,4},
                    {0,3,0,0,0,0,0,0,0},
                    {7,5,0,0,0,0,0,0,0},
                    {0,0,0,0,0,9,6,0,0},
                    {0,4,0,0,0,6,0,0,0},
                    {0,0,0,0,0,0,0,7,1},
                    {0,0,0,0,0,1,0,3,0}
            }
    };

    
    @Override
    public void start(Stage primaryStage) {
        templateselectioncombobox.getItems().setAll(
                1,
                2,
                3,
                4
        );
        templateselectioncombobox.setValue(1);
        templateselectioncombobox.setOnAction((event) -> {
            initSudokuValues();
        });

        Button reloadbtn = new Button();

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

            sudokuTable.getChildren().clear();
            List<List<List<Integer>>> matrix = this.model.solve(cells);
            for (int i = 0; i < 9; ++i) {
                for (int j = 0; j < 9; ++j) {
                    ComboBox tempBox = new ComboBox();
                    List<Integer> toView = matrix.get(i).get(j);
                    if (toView.size() > 1) {
                        toView.add(0,0);
                    }
                    tempBox.getItems().setAll(toView);
                    tempBox.getSelectionModel().select(0);
                    sudokuTable.add(tempBox, i, j);
                }
            }

            msgBox.message("Complite!");
            msgBox.showInformation();
            btn.setVisible(false);
            reloadbtn.setVisible(true);
        });


        reloadbtn.setText("Again");
        reloadbtn.setOnAction((ActionEvent event) -> {
            initSudokuValues();
            btn.setVisible(true);
            reloadbtn.setVisible(false);
        });
        reloadbtn.setVisible(false);
 
        sudokuTable = new GridPane();
        sudokuTable.setAlignment(Pos.CENTER);
        sudokuTable.setHgap(5);
        sudokuTable.setVgap(5);

        initSudokuValues();
        
        VBox vbox = new VBox(templateselectioncombobox, sudokuTable, btn, reloadbtn);
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
        
        try {
            this.model = new SudokuModel();
        } catch (JPLException ex) {
            Dialogs msgBox = Dialogs.create();
            msgBox.title("Message");
            msgBox.message(ex.getMessage());
            msgBox.masthead("Error");
            msgBox.showInformation();
        }
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

    public void initSudokuValues() {
        final int templatenum = ((int)templateselectioncombobox.getValue())-1;
        sudokuTable.getChildren().clear();
        for (int i = 0; i < 9; ++i) {
            for (int j = 0; j < 9; ++j) {
                ComboBox c = new ComboBox();
                c.getItems().setAll(
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

                c.setValue(initsudoku[templatenum][i][j]);
                sudokuTable.add(c, i, j);
            }
        }
    }
}

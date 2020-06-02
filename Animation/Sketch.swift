import Foundation
import CanvasGraphics

class Sketch : NSObject {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas : Canvas
    
    // Define a row on the board
    var row = Array(repeating: false, count: 50)
    
    // Define an empty board
    var board: [[Bool]] = []
    
    // Define an empty board with numbers of living cells around instead of Bollean values
    var numberBoard: [[Int]] = []
    
    // Define and row in the number board
    var numberRow = Array(repeating: 0, count: 50)
    
    // Define cell width and height
    let size = 10
    
    // Control the colour of the fill
    var color : Color = .black
    
    // Control the number of rows
    var rows : Int = 50
    
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Set the fill color
        canvas.fillColor = color
        
        // Iterate through the rows
        for _ in 1...50 {
            board.append(row)
        }
        
        for _ in 1...50 {
            numberBoard.append(numberRow)
        }
        
        // Initial values HERE
        //NOTE: board[y-value][x-value]
        
        // Pattern 1: LWSS and Glider
        
//        board[10][40] = true
//        board[11][40] = true
//        board[12][40] = true
//        board[13][40] = true
//        board[13][41] = true
//        board[13][42] = true
//        board[12][43] = true
//        board[9][41] = true
//        board[9][43] = true
        
        // Pattern 2: Gosper's Glider Gun
        board[40][8] = true
        board[41][8] = true
        board[40][9] = true
        board[41][9] = true
        board[39][20] = true
        board[40][20] = true
        board[41][20] = true
        board[42][20] = true
        board[43][20] = true
        board[38][21] = true
        board[40][21] = true
        board[41][21] = true
        board[42][21] = true
        board[44][21] = true
        board[39][22] = true
        board[43][22] = true
        board[40][23] = true
        board[41][23] = true
        board[42][23] = true
        board[41][24] = true
        board[39][25] = true
        board[40][25] = true
        board[38][26] = true
        board[40][26] = true
        board[38][27] = true
        board[40][27] = true
        board[39][28] = true
        board[36][31] = true
        board[37][31] = true
        board[39][31] = true
        board[41][31] = true
        board[42][31] = true
        board[36][32] = true
        board[42][32] = true
        board[37][33] = true
        board[41][33] = true
        board[38][34] = true
        board[39][34] = true
        board[40][34] = true
        board[38][42] = true
        board[39][42] = true
        board[38][43] = true
        board[39][43] = true
    }
    //
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        print("number of rows is \(rows)")
        
        //clear the canvas
        clearCanvas()
        
        //remove the borders for all shapes to make it looks better
        canvas.drawShapesWithBorders = false
        
        // Set the fill color
        canvas.fillColor = color
        
        // Iterate over all the rows and columns
        // Draw a filled black square when a value is true
        for row in 0...board.count - 1 {
            for column in 0...board[row].count - 1 {
                if board[row][column] == true {
                    canvas.drawShapesWithFill = true
                } else {
                    canvas.drawShapesWithFill = false
                }
                canvas.drawRectangle(at: Point(x: column * size, y: row * size), width: size, height: size)
                // Try make the cells round
//                canvas.drawEllipse(at: Point(x: column * size, y: row * size), width: size, height: size)
                
            }
        }
        // Count the number of cells alive around each cell and stored the data in the number board
        for row in 1...board.count - 2 {
            for column in 1...board[row].count - 2 {
                
                numberBoard[row][column] = numberOfCellsAliveAround(row: row, column: column)
               
            }
        }
        // Change the status of every cell
        for row in 1...board.count - 2 {
            for column in 1...board[row].count - 2 {
                
                //if living cells around a cell is less than 2, the cell dies
                if numberBoard[row][column] < 2  {
                    board[row][column] = false
                }
                //if living cells around a cell is greater than 3, the cell dies
                if numberBoard[row][column] > 3  {
                    board[row][column] = false
                }
                //if living cells around a cell is exactly 3, the cell resurge
                if numberBoard[row][column] == 3  {
                    board[row][column] = true
                }
            }
            
        }
    }
    // Introduce a function that checks how many living and dead cells are around a cell
    func numberOfCellsAliveAround(row:Int, column:Int)->Int{
        var numberAlive = 0
        // Need to find a way when index is out of range?
        for x in row-1...row+1 {
            for y in column-1...column+1{
                if board[x][y] == true{
                    numberAlive += 1
                }
                if x == row && y == column && board[row][column] == true {
                    numberAlive -= 1
                }
            }
        }
        return numberAlive
    }
    func clearCanvas() {
        canvas.drawShapesWithFill = true
        canvas.drawShapesWithBorders = false
        canvas.fillColor = .white
        canvas.drawRectangle(at: Point(x:0, y:0), width: canvas.width, height: canvas.height)
        canvas.drawShapesWithBorders = true
    }
}




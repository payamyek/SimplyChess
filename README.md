# SimplyChess

A robust yet simple and comprehensive implementation of the infamous game "Chess"

## UML Diagram

```mermaid
classDiagram

class Move {
    -int destX
    -int destY
    -Piece original
    -Piece captured
    -Piece promotion
    -MoveType type
    -Move(MoveBuilder)
    +getDestX() int
    +getDestY() int
    +getMoveType() PieceMoveType
    +getOriginalPiece() Piece
    +getCapturedPiece() Piece
    +getPromotionPiece() Piece
}

class Builder {
    <<static class>>
    -int destX
    -int destY
    -Piece original
    -Piece captured
    -Piece promotion
    -MoveType type
    +Builder(MoveType)
    +withDestCoordinates(int,int) Builder
    +withCapturedPiece(Piece) Builder
    +withPromotionPiece(Piece) Builder
    -validate() bool
    +build() Move
}



class GameResult {
    <<enumeration>>
    WHITE_WIN_CHECKMATE
    WHITE_WIN_RESIGNATION
    WHITE_WIN_TIMEOUT
    BLACK_WIN_CHECKMATE
    BLACK_WIN_RESIGNATION
    BLACK_WIN_TIMEOUT
    DRAW_STALEMATE
    DRAW_INSUFFICIENT_MATERIAL
    DRAW_50_MOVE_RULE
    DRAW_REPETITION
    DRAW_AGREEMENT
}

class GameTurn {
    <<enumeration>>
    BLACK_TURN
    WHITE_TURN
}

class MoveType {
    <<enumeration>>
    NORMAL
    CHECKMATE
    CAPTURE
    CASTLE_KING_SIDE
    CASTLE_QUEEN_SIDE
    PROMOTION
}

class PieceState {
    <<enumeration>>
    ALIVE_NOT_MOVED
    ALIVE_MOVED
    ALIVE_PAWN_MOVED_TWO_SQUARES
    CAPTURED
}

class PieceType {
    <<enumeration>>
    PAWN
    BISHOP
    KING
    QUEEN 
    ROOK
    KNIGHT
}

class PieceColour {
    <<enumeration>>
    WHITE
    BLACK
}


class TimerState {
    <<enumeration>>
    RUNNING
    PAUSED
    EXPIRED
}

class Timer {
    -int time
    +Timer(int time)
    +getTime(): int
    +start() void
    +pause() void
    +resume() void
    +getState(): TimerState
}

class Piece{
    <<abstract>>
    -int x
    -int y
    -PieceColour colour
    -PieceState state
    +getX(): int
    +getY(): int
    +getColour(): PieceColour
    +getState() PieceState 
    +setX(int) void
    +setY(int) void
    +setState(PieceState) void
    +setColour(PieceColour) void
}

class Pawn{
    +Pawn(int x, int y, PieceColour)
}

class Bishop{
    +Bishop(int x, int y, PieceColour)
}


class King{
    +King(int x, int y, PieceColour)
}

class Queen{
    +Queen(int x, int x, PieceColour)
}


class Rook{
    +Rook(int x, int y, PieceColour)
}


class Knight{
    +Knight(int x, int y, PieceColour)
}

class Board {
    -int[8][8] Piece
    +Board()
    +getWhitePieces() List~Piece~
    +getBlackPieces() List~Piece~
    +getPiece(int x, int y) Piece
    +updatePiecePosition(int origX, int origY, int destX, int destY)
}

class Game {
    -Player playerA
    -Player playerB
    -Board Board
    -Timer timerA
    -Timer timerB
    -UUID id
    -GameTurn turn
    +Game(Player, Player)
    -toggleTurn() void
    +makeMove(Move) void
    +getPiece(int x, int y) Piece
    +getCurrentPlayerPieces() List~Piece~
}

class LogicEngine{
    <<final>>
    -LogicEngine()
    -validatePawnMove(Board, Move)$ bool
    -validateRookMove(Board, Move)$ bool
    -validateKnightMove(Board, Move)$ bool
    -validateKingMove(Board, Move)$ bool
    -validateQueenPawnMove(Board, Move)$ bool
    -validateBishopPawnMove(Board, Move)$ bool
    -validateCastleMove(Board, Move)$ bool
    -validatePromotionMove(Board, Move)$ bool
    -validateCheckMateMove(Board, Move)$ bool
    +validate(Board, Move)$ bool
}

class Player {
    <<interface>>
    +readyToPlay() void
    +executeMove(Move) void
    +resign() void
    +requestDraw() void
    +acceptDraw() void
    +exit() void
}

class HumanPlayer {
    -String name
    -String email
    -int rank
    +getName() String
    +getEmail() String
    +getRank() int
    +setRank(int) void
}

class ScoreCalculator {
    <<interface>>
    +calculate(Player p1, Player p2, GameResult result)$ int[2]
}

class GlickoTwoCalculator {
    <<final>>
    -GlickTwoCalculator()
}

%% player relationships
Player <|-- HumanPlayer

%% score relationships
ScoreCalculator <|-- GlickoTwoCalculator


%% piece relationships 
Piece <|-- Pawn
Piece <|-- Bishop 
Piece <|-- King 
Piece <|-- Queen
Piece <|-- Rook 
Piece <|-- Knight

```

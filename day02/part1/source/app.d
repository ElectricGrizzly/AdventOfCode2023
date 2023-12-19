import std.conv;
import std.stdio : File, readln, write, writeln, writef;
import std.string;

import parsing : GameDataParser;
import games : Game, Colour;

void main()
{
    printHeader();
    
    string isTest = getRunState(); 
    File input = File("test-input.txt");
    if(isTest == "N" || isTest == "n") 
    {
        input = File("input.txt");
    }
    
    runDay(input);
}

void printHeader() 
{
    writeln("**** Advent of Code 2023");
    writeln("**** Day 2: Code Conundrum");
}

string getRunState()
{
    write("Are you testing? (Y/n): ");
    
    return strip(readln());
}

void runDay(File input) 
{
    int redThreshold = getColourThreshold(Colour.red);
    int greenThreshold = getColourThreshold(Colour.green);
    int blueThreshold = getColourThreshold(Colour.blue);

    int sum = 0;
    string gameDataLine;
    while((gameDataLine = input.readln()) !is null)
    {
        Game game = GameDataParser.getGame(gameDataLine);
        if(game.isValidGame(redThreshold, greenThreshold, blueThreshold))
        {
            sum += game.number;
        }
    }
    writeln(sum);
}

int getColourThreshold(Colour colour)
{
    writef("How many %s?: ", colour);
    
    return to!int(strip(readln()));
}

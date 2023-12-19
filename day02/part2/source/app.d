import std.conv;
import std.stdio : File, readln, write, writeln;
import std.string;

import parsing : GameDataParser;
import games : Game;

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
    int sum = 0;
    string gameDataLine;
    while((gameDataLine = input.readln()) !is null)
    {
        Game game = GameDataParser.getGame(gameDataLine);

        sum += game.maxRed * game.maxGreen * game.maxBlue;
    }
    writeln(sum);
}

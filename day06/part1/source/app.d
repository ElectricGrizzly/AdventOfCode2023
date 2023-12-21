import std.stdio : File, readln, write, writeln;
import std.string;

import parsing : RaceParser;
import races : Race;

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
    writeln("**** Day 6: Wait For It");
}

string getRunState()
{
    write("Are you testing? (Y/n): ");

    return strip(readln());
}

void runDay(File input)
{
    Race[] races = RaceParser.getRaces(input);


    int product = 1;
    bool foundSolution = false;
    foreach(Race race; races)
    {
        int racesCount = race.getWinningRacesCount();
        if(racesCount > 0)
        {
            product *= racesCount;
            foundSolution = true;
        }
    }
    
    if(foundSolution)
    {
        writeln(product);
    }
    else
    {
        writeln(0);
    }
}

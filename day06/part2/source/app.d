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
    Race race = RaceParser.getRace(input);
    writeln(race.getWinningRacesCount());
}

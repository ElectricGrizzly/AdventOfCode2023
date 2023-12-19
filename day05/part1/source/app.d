import std.stdio : File, readln, write, writeln;
import std.string;

import parsing : AlmanacParser;
import gardening : Almanac;

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
    writeln("**** Day 5: If You Give A Seed A Fertilizer");
}

string getRunState()
{
    write("Are you testing? (Y/n): ");

    return strip(readln());
}

void runDay(File input)
{
    Almanac almanac = AlmanacParser.getAlmanac(input);

    long[] locations = almanac.getLocations();
    long lowestLocation = locations[0];

    foreach(long location; locations)
    {
        if(location < lowestLocation)
        {
            lowestLocation = location;
        }
    }

    writeln(lowestLocation);
}

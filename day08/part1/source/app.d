import std.algorithm : sort;
import std.stdio : File, readln, write, writeln;
import std.string;

import parsing : NodeParser;
import nodes : Node;

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
    writeln("**** Day 8: Haunted Wasteland");
}

string getRunState()
{
    write("Are you testing? (Y/n): ");

    return strip(readln());
}

void runDay(File input)
{
    long count = NodeParser.getStepsCount(input);
    writeln(count);
}

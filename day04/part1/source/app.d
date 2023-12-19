import std.stdio;
import std.string;

import parsing : ScratchcardParser;

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
    writeln("**** Day 4: Scratchcards");
}

string getRunState()
{
    write("Are you testing? (Y/n): ");

    return strip(readln());
}

void runDay(File input)
{
    int sum = 0;
    string cardDataLine;
    while((cardDataLine = input.readln()) !is null)
    {
        sum += ScratchcardParser.getCard(cardDataLine).score;
    }

    writeln(sum);
}

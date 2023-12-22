import std.algorithm : sort;
import std.stdio : File, readln, write, writeln;
import std.string;

import parsing : HandParser;
import cards : Hand;

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
        writeln(sumOfProducts);
    writeln("**** Day 7: Camel Cards");
}

string getRunState()
{
    write("Are you testing? (Y/n): ");

    return strip(readln());
}

void runDay(File input)
{
    Hand[] hands = HandParser.getHands(input);
    sort(hands);

    long sumOfProducts;
    for(long index = 0; index < hands.length; index++)
    {
        sumOfProducts += (index + 1) * hands[index].bid;
    }

    writeln(sumOfProducts);
}

import std.conv;
import std.string;
import std.stdio : File, readln, write, writeln;

import parsing : CalibrationParser;

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
    writeln("**** Day 1: Trebuchet?!");
}

string getRunState()
{
    write("Are you testing? (Y/n): ");
    
    return strip(readln());
}

void runDay(File input) 
{
    int sum;
    string calibrationLine;
    while((calibrationLine = input.readln()) !is null)
    {
        string firstNumber = CalibrationParser.getFirstNumber(calibrationLine);
        string lastNumber = CalibrationParser.getLastNumber(calibrationLine);
        sum += to!int(firstNumber ~ lastNumber);
    }
    writeln(sum);
}

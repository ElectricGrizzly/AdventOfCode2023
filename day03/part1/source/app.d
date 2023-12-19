import std.stdio : File, readln, write, writeln;
import std.string;
import std.ascii : isDigit;

import parsing : SchematicParser;
import schematics : Point, SchematicPoint, PartNumber;

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
    writeln("**** Day 3: Gear Ratios");
}

string getRunState()
{
    write("Are you testing? (Y/n): ");
    
    return strip(readln());
}

void runDay(File input) 
{
    int sum = 0;
    string schematicLine;
    while((schematicLine = input.readln()) !is null)
    {
        SchematicParser.parseSchematicLine(strip(schematicLine));
    }

    foreach(PartNumber partNumber; SchematicParser.getPartNumbers())
    {
        sum += partNumber.value;
    }
    writeln(sum);
}

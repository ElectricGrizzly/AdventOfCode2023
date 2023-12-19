import std.ascii : isDigit;
import std.conv;
import std.stdio : File, readln, write, writeln;
import std.string;

import parsing : SchematicParser;
import schematics : PartNumber, Point, SchematicPoint;

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

    SchematicPoint[] gears = SchematicParser.getGears();
    foreach(SchematicPoint gear; gears)
    {
        sum += gear.gearRatio;
    }
    writeln(sum);
}

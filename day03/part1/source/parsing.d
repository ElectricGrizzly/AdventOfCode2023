module parsing;

import std.ascii : isDigit;
import std.conv;
import std.range : enumerate;
import std.stdio;

import schematics : Point, SchematicPoint, PartNumber;

struct SchematicParser
{
    private static PartNumber[] potentialPartNumbers;
    static SchematicPoint[Point] schematic;
    static int row = 0;

    public static void parseSchematicLine(string schematicLine)
    {
        string currentPartNumber = "";
        Point[] currentPartNumberPoints;

        foreach(int column, dchar character; schematicLine.enumerate(0))
        {
            Point point = Point(column, this.row);
            this.schematic[point] = SchematicPoint(point, character);
            
            if(isDigit(character))
            {
                currentPartNumber ~= to!string(character);
                currentPartNumberPoints ~= point;
            }
            else if(currentPartNumberPoints.length > 0)
            {
                potentialPartNumbers ~= PartNumber(currentPartNumberPoints, to!int(currentPartNumber));
                currentPartNumber = "";
                currentPartNumberPoints.destroy;
            }
        }
        if(currentPartNumberPoints.length > 0)
        {
            potentialPartNumbers ~= PartNumber(currentPartNumberPoints, to!int(currentPartNumber));
        }

        this.row++;
    }

    public static PartNumber[] getPartNumbers()
    {
        PartNumber[] partNumbers;
        foreach(PartNumber partNumber; this.potentialPartNumbers)
        {
            if(isValidPartNumber(partNumber))
            {
                partNumbers ~= partNumber;
            }
        }

        return partNumbers;
    }
    
    private static bool isValidPartNumber(PartNumber partNumber)
    {
        foreach(Point point; partNumber.nearbyPoints)
        {
            dchar character = schematic.get(point, SchematicPoint(point, '.')).character;
            if(character != '.' && !isDigit(character))
            {
                return true;
            }
        }

        return false;
    }
}

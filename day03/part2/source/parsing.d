module parsing;

import std.algorithm.mutation : remove;
import std.ascii : isDigit;
import std.conv;
import std.range : enumerate;
import std.stdio;

import schematics : PartNumber, Point, SchematicPoint;

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
                this.potentialPartNumbers ~= PartNumber(currentPartNumberPoints, to!int(currentPartNumber));
                currentPartNumber = "";
                currentPartNumberPoints.destroy;
            }
        }
        if(currentPartNumberPoints.length > 0)
        {
            this.potentialPartNumbers ~= PartNumber(currentPartNumberPoints, to!int(currentPartNumber));
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
            dchar character = this.schematic.get(point, SchematicPoint(point, '.')).character;
            if(character != '.' && !isDigit(character))
            {
                return true;
            }
        }

        return false;
    }

    public static SchematicPoint[] getGears()
    {
        SchematicPoint[] potentialGears = getPotentialGears();
        

        return getValidGears(potentialGears); 
    }

    private static SchematicPoint[] getPotentialGears()
    {
        SchematicPoint[] potentialGears;
        foreach(PartNumber partNumber; getPartNumbers())
        {
            foreach(Point point; partNumber.nearbyPoints)
            {
                SchematicPoint schematicPoint = schematic.get(point, SchematicPoint(point, '.'));
                if(isValidPotentialGear(schematicPoint))
                {
                    schematicPoint.addNearbyPartNumber(partNumber);
                    schematic[point] = schematicPoint;
                    
                }
                if(isValidGear(schematicPoint))
                {
                    potentialGears ~= schematicPoint;
                }
            }
        }

        return potentialGears;
    }

    private static bool isValidPotentialGear(SchematicPoint schematicPoint)
    {
        return schematicPoint.character == '*';
    }

    private static bool isValidGear(SchematicPoint schematicPoint)
    {
        return schematicPoint.nearbyPartNumbers.length == 2;
    }


    private static SchematicPoint[] getValidGears(SchematicPoint[] potentialGears)
    {
        SchematicPoint[] gears;
        foreach(SchematicPoint schematicPoint; potentialGears)
        {
            PartNumber[] nearbyPartNumbers = schematicPoint.nearbyPartNumbers;
            if(nearbyPartNumbers.length == 2)
            {
                schematicPoint.gearRatio = getGearRatio(nearbyPartNumbers);
                gears ~= schematicPoint;
            }
        }

        return gears;
    }

    private static int getGearRatio(PartNumber[] partNumbers)
    {
        int gearRatio = 1;
        foreach(PartNumber partNumber; partNumbers)
        {
            gearRatio *= partNumber.value;
        }

        return gearRatio;
    }
}

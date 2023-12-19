module parsing;

import std.ascii : isDigit;
import std.conv;
import std.stdio : File;
import std.string;
import std.traits : EnumMembers;

import gardening : Almanac, AlmanacMap, Destination;

struct AlmanacParser
{
    public static Almanac getAlmanac(File almanacFile)
    {
        Destination[] destinations = getDestinations();
        long[] seedsData = getSeedsData(almanacFile.readln());
        Almanac almanac = Almanac(seedsData);

        int destinationIndex = -1;
        string almanacLine;
        while((almanacLine = strip(almanacFile.readln())) !is null)
        {
            if(almanacLine == "")
            {
                continue;
            }
            if(!isDigit(to!dchar(almanacLine[0])))
            {
                destinationIndex++;
                continue;
            } 

            string[] mapParameters = strip(almanacLine).split();
            long destinationStart = to!long(mapParameters[0]);
            long sourceStart = to!long(mapParameters[1]);
            long range = to!long(mapParameters[2]);
            AlmanacMap almanacMap = AlmanacMap(destinationStart, sourceStart, range);
            almanac.addMap(destinations[destinationIndex], almanacMap);
        }

        return almanac;
    }

    private static long[] getSeedsData(string seedLine)
    {
        // Expected format is "seeds: w x y z"
        string[] seedStrings = strip(strip(seedLine).replace("seeds: ", "")).split;
        
        return to!(long[])(seedStrings);
    }

    private static Destination[] getDestinations()
    {
        Destination[] destinations;
        foreach(Destination destination; EnumMembers!Destination)
        {
            destinations ~= destination;
        }

        return destinations;
    }
}

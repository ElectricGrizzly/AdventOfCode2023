module parsing;

import std.conv;
import std.range : enumerate;
import std.stdio : File;
import std.string;

import races : Race;

struct RaceParser
{
    public static Race[] getRaces(File raceData)
    {
        Race[] races;
        int[] times = getTimes(raceData.readln());
        int[] recordDistances = getRecordDistances(raceData.readln());
        
        foreach(int index, int time; times)
        {
            races ~= Race(time, recordDistances[index]);
        }

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
        return races;
    }

    private static int[] getTimes(string timeData)
    {
        // Expected format "Time: w x y z"
        string timesString = strip(timeData.replace("Time: ", ""));
        return to!(int[])(timesString.split());
    }

    private static int[] getRecordDistances(string recordDistanceData)
    {
        // Expected format "Distance: w x y z"
        string recordDistancesString = strip(recordDistanceData.replace("Distance: ", ""));
        return to!(int[])(recordDistancesString.split());
    }
}

module parsing;

import std.conv;
import std.stdio : File;
import std.string;

import races : Race;

struct RaceParser
{
    public static Race getRace(File raceData)
    {
        long time = getTime(raceData.readln());
        long recordDistance = getRecordDistance(raceData.readln());
        
        return Race(time, recordDistance);
    }

    private static long getTime(string timeData)
    {
        // Expected format "Time: w x y z"
        string timeString = strip(timeData.replace("Time: ", "")).replace(" ", "");
        return to!long(timeString);
    }

    private static long getRecordDistance(string recordDistanceData)
    {
        // Expected format "Distance: w x y z"
        string recordDistanceString = strip(recordDistanceData.replace("Distance: ", "")).replace(" ", "");
        return to!long(recordDistanceString);
    }
}

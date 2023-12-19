module parsing;

import std.conv;
import std.string;
import std.uni : isNumber;

class CalibrationParser
{
    static string getFirstNumber(string calibrationLine)
    {
        foreach(char character; calibrationLine)
        {
            if(isNumber(character))
            {
                return to!string(character);
            }
        }
        return "";
    }

    static string getLastNumber(string calibrationLine)
    {
        foreach_reverse(char character; calibrationLine)
        {
            if(isNumber(character))
            {
                return to!string(character);
            }
        }
        return "";
    }
}

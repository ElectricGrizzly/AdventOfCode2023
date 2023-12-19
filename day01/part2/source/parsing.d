module parsing;

import std.algorithm.mutation : reverse;
import std.conv;
import std.range : enumerate;
import std.stdio : writeln;
import std.string;
import std.traits : EnumMembers;
import std.uni : isNumber;

class CalibrationParser
{
    private static enum NumberValue: int
    {
        one = 1,
        two = 2,
        three = 3,
        four = 4,
        five = 5,
        six = 6,
        seven = 7,
        eight = 8,
        nine = 9
    }

    static long firstIndex = 0;
    static string firstNumber = "";

    public static string getFirstNumber(string calibrationLine)
    {
        initialize(calibrationLine);
        getFirstNumberCharacter(calibrationLine);
        getFirstNumberWord(calibrationLine);

        return firstNumber;
    }

    public static string getLastNumber(string calibrationLine)
    {
       string reversedCalibrationLine = calibrationLine.dup.reverse;

       initialize(reversedCalibrationLine);
       getLastNumberCharacter(reversedCalibrationLine);
       getLastNumberWord(reversedCalibrationLine);

       return firstNumber;
    }

    private static void getFirstNumberCharacter(string calibrationLine)
    {
        foreach(long index, dchar character; calibrationLine.enumerate())
        {
            if(isNumber(character))
            {
                firstIndex = index;
                firstNumber = to!string(calibrationLine[index]);
                break;
            }
        }
    }

    private static void getFirstNumberWord(string calibrationLine)
    {
        foreach(numberValue; EnumMembers!NumberValue)
        {
            long numberValueIndex = calibrationLine.indexOf(to!string(numberValue));
            if(numberValueIndex > -1 && numberValueIndex <= firstIndex)
            {
                firstIndex = numberValueIndex;
                firstNumber = to!string(to!int(numberValue));
            }
        } 
    }

    private static void getLastNumberCharacter(string calibrationLine)
    {
        getFirstNumberCharacter(calibrationLine);
    }

    private static void getLastNumberWord(string calibrationLine)
    {
        foreach(numberValue; EnumMembers!NumberValue)
        {
            long numberValueIndex = calibrationLine.indexOf(to!string(numberValue).dup.reverse);
            if(numberValueIndex > -1 && numberValueIndex <= firstIndex)
            {
                firstIndex = numberValueIndex;
                firstNumber = to!string(to!int(numberValue));
            }
        } 
    }

    private static void initialize(string calibrationLine)
    {
        firstNumber = "";
        firstIndex = calibrationLine.length;
    }
}

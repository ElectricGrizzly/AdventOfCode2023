module parsing;

import std.conv;
import std.string;

import games : Game, Pull, Cube, Colour;

struct GameDataParser
{

    public static Game getGame(string gameDataLine)
    {
        string[] splitOnColon = split(gameDataLine, ":");

        int gameNumber = getGameNumber(splitOnColon[0]); 
        Pull[] pulls = getPulls(splitOnColon[1]);
        
        return Game(gameNumber, pulls);
    }

    private static int getGameNumber(string expectedData)
    {
        // Expected format is "Game x", where x is the game number.
        return to!int(strip(expectedData).replace("Game ", ""));
    }

    private static Pull[] getPulls(string expectedData)
    {
        // Expected format is " x blue, y red; z red, z green, y blue"
        // semicolon-separated listing of comma-separated number of coloured cubes.
        // x, y, and z are number of cubes of the given colour.
        string[] pullsData = split(strip(expectedData), ";");
        Pull[] pulls;
        foreach(string pullData; pullsData)
        {
            Cube[] cubes = getCubes(pullData);
            pulls ~= Pull(cubes);
        }

        return pulls;
    }

    private static Cube[] getCubes(string expectedData)
    {
        // Expected format is "x blue, y red", where x and y are number of cubes
        // of the given colour.
        string[] cubesData = split(strip(expectedData), ",");
        Cube[] cubes;
        foreach(string cubeData; cubesData)
        {
            string[] cubeNumberAndColour = split(strip(cubeData), " ");

            int numberOfCubes = to!int(cubeNumberAndColour[0]);
            Colour cubeColour = to!Colour(cubeNumberAndColour[1]);

            cubes ~= Cube(numberOfCubes, cubeColour);
        }

        return cubes;
    }
}


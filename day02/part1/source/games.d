module games;

struct Game
{
    int number;
    Pull[] pulls;
    int maxRed;
    int maxGreen;
    int maxBlue;

    this(int number, Pull[] pulls)
    {
        this.number = number;
        this.pulls = pulls;
        
        getMaxCubeNumbers();
    }

    private void getMaxCubeNumbers()
    {
        foreach(Pull pull; this.pulls)
        {
            foreach(Cube cube; pull.cubes)
            {
                getMaxNumberByCubeColour(cube);
            }
        }
    }

    private void getMaxNumberByCubeColour(Cube cube)
    {
        switch(cube.colour)
        {
            case Colour.red:
            {
                if(cube.number > maxRed)
                {
                    maxRed = cube.number;
                }
                break;
            }
            case Colour.green:
            {
                if(cube.number > maxGreen)
                {
                    maxGreen = cube.number;
                }
                break;
            }
            case Colour.blue:
            {
                if(cube.number > maxBlue)
                {
                    maxBlue = cube.number;
                }
                break;
            }
            default:
            {
                break;
            }
        }
    }


    bool isValidGame(int maxRed, int maxGreen, int maxBlue)
    {
        return this.maxRed <= maxRed
            && this.maxGreen <= maxGreen
            && this.maxBlue <= maxBlue;
    }
}

struct Pull
{
    Cube[] cubes;

    this(Cube[] cubes)
    {
        this.cubes = cubes;
    }
}

struct Cube
{
    Colour colour;
    int number;

    this(int number, Colour colour)
    {
        this.colour = colour;
        this.number = number;
    }
}

enum Colour
{
    red,
    green,
    blue,
}

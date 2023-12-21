module races;

import std.conv;
import std.math : abs, ceil, floor, pow, sqrt;

struct Race
{
    int raceTime;
    int recordDistance;

    this(int raceTime, int recordDistance)
    {
        this.raceTime = raceTime;
        this.recordDistance = recordDistance;
    }

    public int getWinningRacesCount()
    { 
        // If x is the time holding the button and y is the distance covered,
        // all solutions exist on y = -x^2 +xt, where t is the given race time
        // Solving the equation where y = recordDistance + 1 (a winning race), 
        // provides an of form 0 = -x^2 + xt - y. When there is more than one
        // real solution, the roots of the quadratic represent the range of valid
        // integer solutions. With the ceiling of the first root, and floor of
        // the second root being the first integer solutions
        float radicand = pow(this.raceTime, 2) - (4 * -1 * (-1 * (this.recordDistance + 1)));
        
        // No real solutions
        if(radicand < 0)
        {
            return 0;
        }
        // One real solution
        else if(radicand == 0)
        {
            return 1;
        }

        int firstSolution = to!int(ceil(((-1 * this.raceTime) + sqrt(radicand)) / -2));
        int secondSolution = to!int(floor(((-1 * this.raceTime) - sqrt(radicand)) / -2));
        
        return abs(firstSolution - secondSolution) + 1;
    }
}

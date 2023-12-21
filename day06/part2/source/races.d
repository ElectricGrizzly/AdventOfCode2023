module races;

import std.conv;
import std.math : abs, ceil, floor, pow, sqrt;
p

struct Race
{
    long raceTime;
    long recordDistance;

    this(long raceTime, long recordDistance)
    {
        this.raceTime = raceTime;
        this.recordDistance = recordDistance;
    }

    public long getWinningRacesCount()
    {
        // If x is the time holding the button and y is the distance covered,
        // all solutions exist on y = -x^2 +xt, where t is the given race time
        // Solving the equation where y = recordDistance + 1 (a winning race), 
        // provides an of form 0 = -x^2 + xt - y. When there is more than one
        // real solution, the roots of the quadratic represent the range of valid
        // integer solutions. With the ceiling of the first root, and floor of
        // the second root being the first integer solutions
        double radicand = pow(this.raceTime, 2) - (4 * -1 * (-1 * (this.recordDistance + 1)));
        
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

        long firstSolution = to!long(ceil(((-1 * this.raceTime) + sqrt(radicand)) / -2));
        long secondSolution = to!long(floor(((-1 * this.raceTime) - sqrt(radicand)) / -2));
        
        return abs(firstSolution - secondSolution) + 1;
    }
}

module schematics;

import std.algorithm : canFind;
import std.conv;

struct Point
{
    int column;
    int row;

    this(int column, int row)
    {
        this.column = column;
        this.row = row;
    }
}

struct SchematicPoint
{
    Point point;
    dchar character;
    PartNumber[] partNumbers;

    this(Point point, dchar character)
    {
        this.point = point;
        this.character = character;
    }

    public void addPartNumber(PartNumber partNumber)
    {
        partNumbers ~= partNumber;
    }
}

struct PartNumber
{
    Point[] points;
    Point[] nearbyPoints;
    int value;

    this(Point[] points, int value)
    {
        this.points = points;
        this.value = value;
        setNearbyPoints();
    }

    private void setNearbyPoints()
    {
        int leftColumn = getLeftmostColumn();
        int partNumberLength = to!int(this.points.length);
        int rightColumn = leftColumn + partNumberLength + 1;
        int topRow = this.points[0].row - 1;
        int bottomRow = this.points[0].row + 1;
               
        for(int column = leftColumn; column <= rightColumn; column++)
        {
            for(int row = topRow; row <= bottomRow; row++)
            {
                Point point = Point(column, row);
                if(!isPartOfPartNumber(point))
                {
                    this.nearbyPoints ~= point;
                }
            }
        }
    }

    private int getLeftmostColumn()
    {
        int leftmostColumn = this.points[0].column;
        foreach(Point point; this.points)
        {
            if(point.column < leftmostColumn)
            {
                leftmostColumn = point.column;
            }
        }

        return leftmostColumn - 1;
    }

    private bool isPartOfPartNumber(Point point)
    {
        return this.points.canFind(point);
    }
}

module nodes;

import std.string;

struct Node
{
    string entry;
    string leftExit;
    string rightExit;

    this(string entry, string leftExit, string rightExit)
    {
        this.entry = entry;
        this.leftExit = leftExit;
        this.rightExit = rightExit;
    }
}

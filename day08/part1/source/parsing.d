module parsing;

import std.stdio : File, readln, writeln;
import std.string;

import nodes : Node;

struct NodeParser
{
    public static long getStepsCount(File nodeData)
    {
        Node[string] nodes;
        string instructions = strip(nodeData.readln());
    
        string nodeDataLine;
        while((nodeDataLine = nodeData.readln()) !is null)
        {
            if(strip(nodeDataLine) == "")
            {
                continue;
            }

            string[] splitOnEquals = split(nodeDataLine, "=");

            string nodeEntry = strip(splitOnEquals[0]);

            string[] leftRight = split(strip(strip(splitOnEquals[1]), "(", ")"), ", ");
            string leftExit = leftRight[0];
            string rightExit = leftRight[1];

            nodes[nodeEntry] = Node(nodeEntry, leftExit, rightExit);
        }

        return stepsToFinish(instructions, nodes);
    }

    private static string getLeft(string expectedData)
    {
        // Expected format is "(XXX"
        return strip(expectedData, "(");
    }

    private static string getRight(string expectedData)
    {
        // Expected format is "YYY)"
        return strip(expectedData, ")");
    }

    private static long stepsToFinish(string instructions, Node[string] nodes)
    {
        Node currentNode = nodes["AAA"];
        long count;
        while(currentNode.entry != "ZZZ")
        {
            long index = count % instructions.length;
            switch(instructions[index])
            {
                case 'L':
                    currentNode = nodes[currentNode.leftExit];
                    break;
                case 'R':
                    currentNode = nodes[currentNode.rightExit];
                    break;
                default:
                    break;
            }

            count++;
        }

        return count;
    }
}

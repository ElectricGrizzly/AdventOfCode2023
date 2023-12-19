module gardening;

enum Destination
{
    SOIL,
    FERTILIZER,
    WATER,
    LIGHT,
    TEMPERATURE,
    HUMIDITY,
    LOCATION
};

struct Almanac
{
    long[] seeds;
    AlmanacMap[] seedToSoilMaps;
    AlmanacMap[] soilToFertilizerMaps;
    AlmanacMap[] fertilizerToWaterMaps;
    AlmanacMap[] waterToLightMaps;
    AlmanacMap[] lightToTemperatureMaps;
    AlmanacMap[] temperatureToHumidityMaps;
    AlmanacMap[] humidityToLocationMaps;

    this(long[] seeds)
    {
        this.seeds = seeds;
    }

    public void addMap(Destination destination, AlmanacMap almanacMap)
    {
        switch(destination)
        {
            case Destination.SOIL:
                seedToSoilMaps ~= almanacMap;
                break;
            case Destination.FERTILIZER:
                soilToFertilizerMaps ~= almanacMap;
                break;
            case Destination.WATER:
                fertilizerToWaterMaps ~= almanacMap;
                break;
            case Destination.LIGHT:
                waterToLightMaps ~= almanacMap;
                break;
            case Destination.TEMPERATURE:
                lightToTemperatureMaps ~= almanacMap;
                break;
            case Destination.HUMIDITY:
                temperatureToHumidityMaps ~= almanacMap;
                break;
            case Destination.LOCATION:
                humidityToLocationMaps ~= almanacMap;
                break;
            default:
                break;
        }
    }

    public long[] getLocations()
    {
        long[] locations;
        foreach(long seed; seeds)
        {
            locations ~= getLocation(seed);
        }

        return locations;
    }

    private long getSoil(long seed)
    {
        return getDestination(seed, this.seedToSoilMaps);
    }

    private long getFertilizer(long seed)
    {
        long soil = getSoil(seed);
        return getDestination(soil, this.soilToFertilizerMaps);
    }

    private long getWater(long seed)
    {
        long fertilizer = getFertilizer(seed);
        return getDestination(fertilizer, this.fertilizerToWaterMaps);
    }

    private long getLight(long seed)
    {
        long water = getWater(seed);
        return getDestination(water, this.waterToLightMaps);
    }

    private long getTemperature(long seed)
    {
        long light = getLight(seed);
        return getDestination(light, this.lightToTemperatureMaps);
    }

    private long getHumidity(long seed)
    {
        long temperature = getTemperature(seed);
        return getDestination(temperature, this.temperatureToHumidityMaps);
    }

    private long getLocation(long seed)
    {
        long humidity = getHumidity(seed);
        return getDestination(humidity, this.humidityToLocationMaps);
    }

    private long getDestination(long source, AlmanacMap[] almanacMaps)
    {
        foreach(AlmanacMap almanacMap; almanacMaps)
        {
            long destination = almanacMap.getDestination(source);
            if(destination != -1)
            {
                return destination;
            }
        }

        return source;
    }

}

struct AlmanacMap
{
    long destinationStart;
    long sourceStart;
    long range;

    this(long destinationStart, long sourceStart, long range)
    {
        this.destinationStart = destinationStart;
        this.sourceStart = sourceStart;
        this.range = range;
    }

    private bool isWithinSourceRange(long sourceInput)
    {
        long sourceEnd = sourceStart + range;
        return sourceInput >= sourceStart && sourceInput < sourceEnd;
    }

    public long getDestination(long sourceInput)
    {
        if(this.isWithinSourceRange(sourceInput))
        {
            return (sourceInput - sourceStart) + destinationStart;
        }

        return -1;
    }
}


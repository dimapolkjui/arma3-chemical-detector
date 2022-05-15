# Installation
Copy the `chemicalDetector.sqf` file into the root of you mission.

# Usage
Execute this script locally for each player. For example, add it to `initPlayerLocal.sqf`.
```
[object, maxDistance, minDistance, maxThreat, condition] execVM "chemicalDetector.sqf";
```

| Parameter | Required? | Type | Description |
| --- | --- | --- | --- |
| object | Yes | Object | The object that the chemical detector is tracking. |
| maxDistance | Yes | Number | The maximum distance from the object that this detector will detect the object. At this distance and beyond, the detector will read a threat level of 0. |
| minDistance | No | Number | The minimum distance from the object where this detector will detect a threat level of 1. The default is 0. |
| maxThreat | No | Number | The threat level that will be detected when at the minimum distance. The default is 1. |
| condition | No | Code | The code to execute to determine if it should continue to update the threat level. The default it `{true}`. |

## Example
In `initPlayerLocal.sqf`
```
[chemicalBarrel, 250, 50, 0.6] execVM "chemicalDetector.sqf";
```

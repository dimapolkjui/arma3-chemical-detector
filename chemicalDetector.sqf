if (!hasInterface) exitWith {};

params ["_object", "_maxDistance", ["_minDistance", 0], ["_maxThreat", 1], ["_condition", {true}]];

"ChemicalDetector" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];

private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
private _ctrl = _ui displayCtrl 101;

_maxDistance = _maxDistance - _minDistance;

// Create the chromatic aberration effect!
// Just in case it fails, keep trying to create the effect
private _fancyScreenThing = ppEffectCreate["ChromAberration", 200];
while {
	_fancyScreenThing < 0; // ppEffectCreate returns -1 when it fails
} do {
	_fancyScreenThing = ppEffectCreate["ChromAberration", 200];
};
_fancyScreenThing ppEffectEnable false;
_fancyScreenThing ppEffectAdjust [0, 0, true];
_fancyScreenThing ppEffectCommit 1;


while _condition do {
	private _distance = ((player distance _object) - _minDistance) max 0;

	private _threat = ((_maxThreat - ((_distance/_maxDistance) * _maxThreat)) max 0) min _maxThreat; // Threat level works at point blank, but distance is cut in half if you don't do the *_maxThreat
	_ctrl ctrlAnimateModel ["Threat_Level_Source", [_threat, 2] call BIS_fnc_cutDecimals, true];

	// Enable the visual effect if the threat level is high enough
	if (_threat < 0.3) then {
		if (ppEffectEnabled _fancyScreenThing) then {
			// I think this makes the transition from enabled to disabled a little softer visually, but it might just be my imagination
			_fancyScreenThing ppEffectAdjust [0, 0, true];
			_fancyScreenThing ppEffectCommit 2;
			_fancyScreenThing ppEffectEnable false;
		};
	} else {
		_fancyScreenThing ppEffectEnable true;
		_fancyScreenThing ppEffectAdjust [_threat/40, _threat/40, true];
	};

	sleep 1;
};

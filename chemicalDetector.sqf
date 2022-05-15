if (!hasInterface) exitWith {};

params ["_object", "_maxDistance", ["_minDistance", 0], ["_maxThreat", 1], ["_condition", {true}]];

"ChemicalDetector" cutRsc ["RscWeaponChemicalDetector", "PLAIN", 1, false];

private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
private _ctrl = _ui displayCtrl 101;

_maxDistance = _maxDistance - _minDistance;

while _condition do {
	private _distance = ((player distance _object) - _minDistance) max 0;

	private _threat = ((_maxThreat - ((_distance/_maxDistance) * _maxThreat)) max 0) min _maxThreat;
	_ctrl ctrlAnimateModel ["Threat_Level_Source", [_threat, 2] call BIS_fnc_cutDecimals, true];

	sleep 1;
};

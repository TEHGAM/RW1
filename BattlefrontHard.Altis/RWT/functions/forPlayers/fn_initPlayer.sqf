private ["_veh","_curnade","_hasnade"];
_veh = _this select 0;
// give player gear

// find player's grenades for HUD
[_veh] call LB_fnc_getNades;


// add handlers
// display handler
waitUntil {!isNull (findDisplay 46)};
(findDisplay 46) displayAddEventHandler ["KeyDown", {_this call LB_fnc_keyDown;}];
true
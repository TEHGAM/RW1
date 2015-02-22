private ["_handled","_control","_dikcode","_keyshift","_keyctrl","_keyalt"];
_control = _this select 0;
_dikcode = _this select 1;
_keyshift = _this select 2;
_keyctrl = _this select 3;
_keyalt = _this select 4;

_handled = false;


// Check for throwing item
if (!_keyshift && !_keyctrl && !_keyalt) then {
	if (_dikcode in (actionKeys "Throw")) then {
		nul = [] call LB_fnc_fireCurrentNade;
		_handled = true;
	};
};

// Check switching thrown items
if (!_keyshift && _keyctrl && !_keyalt) then {
	if (_dikcode in (actionKeys "Throw")) then {
		nul = [] call LB_fnc_switchNade;
		_handled = true;
	};
};



// Exiting event handler
_handled;
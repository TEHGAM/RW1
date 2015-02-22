/************************************************************
	Array Rotate by longbow

This function rotates array in both directions and returns
resulting array.

Example #1:
array = [1,2,3,4]
array = [array1,true] call BIS_fnc_arrayShift

array is now [2,3,4,1]

Example #2:
array = [1,2,3,4]
array = [array,false] call BIS_fnc_arrayShift

array is now [4,1,2,3]
************************************************************/
private ["_array","_direction","_shift"];
_array = _this select 0;
_direction = _this select 1;

if (_direction) then {
	// take first element of array
	_shift = [_array] call BIS_fnc_arrayShift;
	// put element in the end of array
	_array = [_array,_shift] call BIS_fnc_arrayPush;
	} else {
	// take last element of array
	_shift = _array call BIS_fnc_arrayPop;
	// put element in the beginning of array
	_array = [_array,[_shift],0] call BIS_fnc_arrayInsert;
};
_array
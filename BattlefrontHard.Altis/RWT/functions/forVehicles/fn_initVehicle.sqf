_veh = _this select 0;
_veh addEventHandler [
	"GetIn",
	{
		[_this select 0, _this select 2] call LB_fnc_enableLaserGuide;
	}
];
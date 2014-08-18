_position = _this select 0;
_unitGroup = _this select 1;
_radius = _this select 2;

_roadsInRange = _position nearRoads _radius;
_numberOfWaypoints = floor random 8;
if(_numberOfWaypoints < 3)then{_numberOfWaypoints = 3;};
_firstWaypointPosition = "";



for [{_i=0},{_i<_numberOfWaypoints},{_i=_i+1}] do
{
	_randomRoadInRange = _roadsInRange select floor (random (count _roadsInRange));
	_waypointPosition = position _randomRoadInRange;
	_waypointType = "Move";

	if(_i == 0)then{_firstWaypointPosition = _waypointPosition;};
	if(_i == (_numberOfWaypoints - 1))then{_waypointPosition = _firstWaypointPosition; _waypointType = "CYCLE";};


	_waypointString = format ["%1WP%2",_unitGroup, _i];
	_waypoint = _unitGroup addWaypoint [_waypointPosition,0];
	_waypoint setWaypointType _waypointType;
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointName _waypointString;

};
